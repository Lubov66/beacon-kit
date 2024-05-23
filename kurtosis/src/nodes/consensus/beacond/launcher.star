shared_utils = import_module("github.com/kurtosis-tech/ethereum-package/src/shared_utils/shared_utils.star")
execution = import_module("../../execution/execution.star")
node = import_module("./node.star")
bash = import_module("../../../lib/bash.star")

# 1x resources
# DEFAULT_MAX_CPU = 1000
# DEFAULT_MAX_MEMORY = 4096
# DEFAULT_MIN_CPU = 500
# DEFAULT_MIN_MEMORY = 1024

# 2x resources
# DEFAULT_MAX_CPU = 2000
# DEFAULT_MAX_MEMORY = 8192
# DEFAULT_MIN_CPU = 1000
# DEFAULT_MIN_MEMORY = 4096

# 4x resources
# DEFAULT_MAX_CPU = 4000
# DEFAULT_MAX_MEMORY = 16384
# DEFAULT_MIN_CPU = 4000
# DEFAULT_MIN_MEMORY = 16384

# 8x resources
DEFAULT_MAX_CPU = 8000
DEFAULT_MAX_MEMORY = 32768
DEFAULT_MIN_CPU = 8000
DEFAULT_MIN_MEMORY = 32768

COMETBFT_RPC_PORT_NUM = 26657
COMETBFT_P2P_PORT_NUM = 26656
COMETBFT_GRPC_PORT_NUM = 9090
COMETBFT_REST_PORT_NUM = 1317
METRICS_PORT_NUM = 26660
ENGINE_RPC_PORT_NUM = 8551

# Port IDs
COMETBFT_RPC_PORT_ID = "cometbft-rpc"
COMETBFT_P2P_PORT_ID = "cometbft-p2p"
COMETBFT_GRPC_PORT_ID = "cometbft-grpc"
COMETBFT_REST_PORT_ID = "cometbft-rest"
ENGINE_RPC_PORT_ID = "engine-rpc"
METRICS_PORT_ID = "metrics"
METRICS_PATH = "/metrics"

USED_PORTS = {
    COMETBFT_RPC_PORT_ID: shared_utils.new_port_spec(COMETBFT_RPC_PORT_NUM, shared_utils.TCP_PROTOCOL),
    COMETBFT_P2P_PORT_ID: shared_utils.new_port_spec(COMETBFT_P2P_PORT_NUM, shared_utils.TCP_PROTOCOL),
    COMETBFT_GRPC_PORT_ID: shared_utils.new_port_spec(COMETBFT_GRPC_PORT_NUM, shared_utils.TCP_PROTOCOL),
    COMETBFT_REST_PORT_ID: shared_utils.new_port_spec(COMETBFT_REST_PORT_NUM, shared_utils.TCP_PROTOCOL),
    # ENGINE_RPC_PORT_ID: shared_utils.new_port_spec(ENGINE_RPC_PORT_NUM, shared_utils.TCP_PROTOCOL),
    METRICS_PORT_ID: shared_utils.new_port_spec(METRICS_PORT_NUM, shared_utils.TCP_PROTOCOL, wait = None),
}

def get_config(image, engine_dial_url, cl_service_name, entrypoint = [], cmd = [], persistent_peers = "", expose_ports = True, jwt_file = None, kzg_trusted_setup_file = None):
    exposed_ports = {}
    if expose_ports:
        exposed_ports = USED_PORTS

    files = {}
    if jwt_file:
        files["/root/jwt"] = jwt_file
    if kzg_trusted_setup_file:
        files["/root/kzg"] = kzg_trusted_setup_file

    config = ServiceConfig(
        image = image,
        files = files,
        entrypoint = entrypoint,
        cmd = cmd,
        min_cpu = DEFAULT_MIN_CPU,
        max_cpu = DEFAULT_MAX_CPU,
        min_memory = DEFAULT_MIN_MEMORY,
        max_memory = DEFAULT_MAX_MEMORY,
        env_vars = {
            "BEACOND_MONIKER": cl_service_name,
            "BEACOND_NET": "VALUE_2",
            "BEACOND_HOME": "/root/.beacond",
            "BEACOND_CHAIN_ID": "beacon-kurtosis-80086",
            "BEACOND_DEBUG": "false",
            "BEACOND_KEYRING_BACKEND": "test",
            "BEACOND_MINIMUM_GAS_PRICE": "0abgt",
            "BEACOND_ENGINE_DIAL_URL": engine_dial_url,
            "BEACOND_ETH_CHAIN_ID": "80086",
            "BEACOND_PERSISTENT_PEERS": persistent_peers,
            "BEACOND_ENABLE_PROMETHEUS": "true",
            "BEACOND_CONSENSUS_KEY_ALGO": "bls12_381",
        },
        ports = exposed_ports,
    )

    return config

def perform_genesis_ceremony_parallel(plan, validators, jwt_file):
    num_validators = len(validators)

    node_peering_info = []
    beacond_configs = []
    stored_configs = []

    for n in range(num_validators):
        beacond_configs.append("node-beacond-config-{}".format(n))
        stored_configs.append(StoreSpec(src = "/tmp/config{}".format(n), name = beacond_configs[n]))

    stored_configs.append(StoreSpec(src = "/tmp/config_genesis/.beacond/config/genesis.json", name = "cosmos-genesis-final"))

    multiple_gentx_file = plan.upload_files(
        src = "./scripts/multiple-gentx.sh",
        name = "multiple-gentx",
        description = "Uploading multiple-gentx script",
    )

    multiple_gentx_env_vars = node.get_genesis_env_vars("cl-validator-beaconkit-0")
    multiple_gentx_env_vars["NUM_VALS"] = str(num_validators)

    plan.print(multiple_gentx_env_vars)
    plan.print(stored_configs)

    plan.run_sh(
        run = "chmod +x /app/scripts/multiple-gentx.sh && /app/scripts/multiple-gentx.sh",
        image = validators[0].cl_image,
        files = {
            "/app/scripts": "multiple-gentx",
            "/root/eth_genesis": "genesis_file",
        },
        env_vars = multiple_gentx_env_vars,
        store = stored_configs,
        wait = "300s",
        description = "Collecting beacond genesis files",
    )

def perform_genesis_ceremony(plan, validators, jwt_file):
    num_validators = len(validators)

    node_peering_info = []
    beacond_configs = []

    # Generate gentx from all but last validator node
    for n in range(num_validators - 1):
        sh_cmd = "{} && {}".format(node.get_init_sh(), node.get_add_validator_sh())

        node_beacond_config = "node-beacond-config-{}".format(n)
        cl_service_name = "cl-validator-beaconkit-{}".format(n)
        beacond_configs.append(node_beacond_config)
        plan.run_sh(
            run = sh_cmd,
            image = validators[n].cl_image,
            env_vars = node.get_genesis_env_vars(cl_service_name),
            store = [
                StoreSpec(src = "/root", name = node_beacond_config),
            ],
            description = "Initialize and store config for validator {}".format(n),
        )

    final_config_folders = {}
    mv_all_gentx_cmd = ""
    for x, beacond_config in enumerate(beacond_configs):
        final_config_folders["/tmp/{}".format(beacond_config)] = beacond_config
        if x < len(beacond_configs) - 1:
            mv_all_gentx_cmd += ("mv /tmp/{}/.beacond/config/gentx/gen* /root/.beacond/config/gentx/ && ".format(beacond_config))
        else:
            mv_all_gentx_cmd += ("mv /tmp/{}/.beacond/config/gentx/gen* /root/.beacond/config/gentx/".format(beacond_config))

    # Final run will collect all gentx from all previous nodes to create final genesis
    final_config_folder = "node-beacond-config-{}".format(num_validators - 1)
    cl_service_name = "cl-validator-beaconkit-{}".format(num_validators - 1)

    last_cmd = "{} && {}".format(mv_all_gentx_cmd, node.get_collect_validator_sh()) if num_validators > 1 else node.get_collect_validator_sh()
    final_sh_cmd = "{} && {} && {} && {} && {}".format(
        node.get_init_sh(),
        node.get_add_validator_sh(),
        "cp -R /root /tmp/{}".format(final_config_folder),  # Store final gentx to the side for easy file artifact storage later
        node.get_execution_payload_sh(),
        last_cmd,
    )

    # Add eth genesis file to final config
    final_config_folders["/root/eth_genesis"] = "genesis_file"

    # Run final gentx generation
    sh_cmd = final_sh_cmd
    plan.run_sh(
        run = sh_cmd,
        image = validators[num_validators - 1].cl_image,
        env_vars = node.get_genesis_env_vars(cl_service_name),
        files = final_config_folders,
        store = [
            StoreSpec(src = "/tmp/{}".format(final_config_folder), name = final_config_folder),
            StoreSpec(src = "/root/.beacond/config/genesis.json", name = "cosmos-genesis-final"),
        ],
        description = "Initialize and store final node's config && final genesis file",
    )

def get_persistent_peers(plan, peers):
    persistent_peers = peers[:]
    for i in range(len(persistent_peers)):
        peer_cl_service_name = "cl-seed-beaconkit-{}".format(i)
        peer_service = plan.get_service(peer_cl_service_name)
        persistent_peers[i] = persistent_peers[i] + "@" + peer_service.ip_address + ":26656"
    return ",".join(persistent_peers)

def create_node(plan, cl_image, peers, paired_el_client_name, jwt_file = None, kzg_trusted_setup_file = None, index = 0):
    cl_service_name = "cl-validator-beaconkit-{}".format(index)
    beacond_config = create_node_config(plan, cl_image, peers, paired_el_client_name, "validator", jwt_file, kzg_trusted_setup_file, index)

    return plan.add_service(
        name = cl_service_name,
        config = beacond_config,
    )

def init_consensus_nodes():
    genesis_file = "{}/config/genesis.json".format("$BEACOND_HOME")

    # Check if genesis file exists, if not then initialize the beacond
    init_node = "if [ ! -f {} ]; then /usr/bin/beacond init --chain-id {} {} --home {} --beacon-kit.accept-tos; fi".format(genesis_file, "$BEACOND_CHAIN_ID", "$BEACOND_MONIKER", "$BEACOND_HOME")
    add_validator = "/usr/bin/beacond genesis add-validator --home {} --beacon-kit.accept-tos".format("$BEACOND_HOME")
    collect_gentx = "/usr/bin/beacond genesis collect-validators --home {}".format("$BEACOND_HOME")
    return "{} && {} && {}".format(init_node, add_validator, collect_gentx)

def create_node_config(plan, cl_image, peers, paired_el_client_name, node_type, jwt_file = None, kzg_trusted_setup_file = None, index = 0):
    cl_service_name = "cl-{}-beaconkit-{}".format(node_type, index)
    engine_dial_url = "http://{}:{}".format(paired_el_client_name, execution.ENGINE_RPC_PORT_NUM)

    persistent_peers = get_persistent_peers(plan, peers)

    cmd = "{} && {}".format(init_consensus_nodes(), node.start(persistent_peers, False))
    if node_type == "validator":
        cmd = node.start(persistent_peers, False)
    elif node_type == "seed":
        cmd = "{} && {}".format(init_consensus_nodes(), node.start(persistent_peers, True))

    beacond_config = get_config(
        cl_image,
        engine_dial_url,
        cl_service_name,
        entrypoint = ["bash", "-c"],
        cmd = [cmd],
        persistent_peers = persistent_peers,
        jwt_file = jwt_file,
        kzg_trusted_setup_file = kzg_trusted_setup_file,
    )

    if node_type == "validator":
        # Add back in the node's config data and overwrite genesis.json with final genesis file
        beacond_config.files["/root"] = Directory(
            artifact_names = ["node-beacond-config-{}".format(index)],
        )

    beacond_config.files["/root/.tmp_genesis"] = Directory(artifact_names = ["cosmos-genesis-final"])

    plan.print(beacond_config)

    return beacond_config

def get_peer_info(plan, cl_service_name):
    peer_result = bash.exec_on_service(plan, cl_service_name, "/usr/bin/beacond comet show-node-id --home $BEACOND_HOME | tr -d '\n'")
    return peer_result["output"]

def dial_unsafe_peers(plan, seed_service_name, peers):
    peers_list = []
    for cl_service_name, peer_info in peers.items():
        p2p_addr = "\"{}@{}:26656\"".format(peer_info, plan.get_service(cl_service_name).ip_address)
        peers_list.append(p2p_addr)

    # Split peers_list into groups of 20
    peer_groups = [peers_list[i:i + 20] for i in range(0, len(peers_list), 20)]
    for group in peer_groups:
        peer_string = ",".join(group)
        endpoint = "/dial_peers?peers=%5B{}%5D&persistent=false".format(peer_string)
        curl_command = ["curl", "-X", "GET", "http://localhost:{}{}".format(COMETBFT_RPC_PORT_NUM, endpoint)]
        exec_recipe = ExecRecipe(
            command=curl_command,
        )
        plan.exec(
            service_name=seed_service_name,
            recipe=exec_recipe,
            description="Adding peers to seed node",
        )
