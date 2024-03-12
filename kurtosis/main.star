el_cl_genesis_data_generator = import_module(
    "github.com/kurtosis-tech/ethereum-package/src/prelaunch_data_generator/el_cl_genesis/el_cl_genesis_generator.star",
)

execution = import_module("./src/nodes/execution/execution.star")
execution_types = import_module("./src/nodes/execution/types.star")
beacond = import_module("./src/nodes/consensus/beacond/launcher.star")
networks = import_module("./src/networks/networks.star")
port_spec_lib = import_module("./src/lib/port_spec.star")
nodes = import_module("./src/nodes/nodes.star")
nginx = import_module("./src/services/nginx/nginx.star")
prometheus = import_module("./src/observability/prometheus/prometheus.star")
grafana = import_module("./src/observability/grafana/grafana.star")
loki = import_module("./src/observability/loki/loki.star")

def run(plan, validators, full_nodes = [], rpc_endpoints = [], additional_services = []):
    """
    Initiates the execution plan with the specified number of validators and arguments.

    Args:
      plan: The execution plan to be run.
      args: Additional arguments to configure the plan. Defaults to an empty dictionary.
    """

    validators = nodes.parse_nodes_from_dict(validators)
    full_nodes = nodes.parse_nodes_from_dict(full_nodes)
    num_validators = len(validators)

    # 1. Initialize EVM genesis data
    evm_genesis_data = networks.get_genesis_data(plan)

    node_modules = {}
    for node in validators:
        if node.el_type not in node_modules.keys():
            node_path = "./src/nodes/execution/{}/config.star".format(node.el_type)
            node_module = import_module(node_path)
            node_modules[node.el_type] = node_module

    # 2. Upload jwt
    jwt_file = execution.upload_global_files(plan, node_modules)

    # 3. Perform genesis ceremony
    node_peering_info = beacond.perform_genesis_ceremony(plan, validators, jwt_file)

    el_enode_addrs = []
    node_services = []


    # 4. Start network validators
    for n, validator in enumerate(validators):
        el_client = execution.create_node(plan, node_modules, validator, "validator", n, el_enode_addrs)
        el_enode_addrs.append(el_client["enode_addr"])

        node_services.append({
            "service": el_client['service'],
            "metrics_path": node_module.METRICS_PATH,
            "type": node.el_type,
            "index": n,
        })


        # 4b. Launch CL
        beacond_service = beacond.create_node(plan, validator.cl_image, node_peering_info[:n], el_client["name"], jwt_file, n)

        node_services.append({
            "service": beacond_service,
            "metrics_path": beacond.METRICS_PATH,
            "type": "beacond",
            "index": n,
        })

    # 5. Start full nodes (rpcs)
    full_node_configs = {}
    for n, full in enumerate(full_nodes):
        el_client = execution.create_node(plan, node_modules, full, "full", n, el_enode_addrs)
        el_enode_addrs.append(el_client["enode_addr"])

        # 4b. Launch CL
        cl_service_name = "cl-full-beaconkit-{}".format(n)
        full_node_config = beacond.create_full_node_config(plan, full.cl_image, node_peering_info, el_client["name"], jwt_file, n)
        full_node_configs[cl_service_name] = full_node_config

    if full_node_configs != {}:
        plan.add_services(
            configs = full_node_configs,
        )

    # 6. Start RPCs
    rpc_configs = {}
    for n, rpc in enumerate(rpc_endpoints):
        nginx.get_config(plan, rpc["services"])







    if "prometheus" in additional_services:
        prometheus_url = prometheus.start(plan, node_services)

        if "grafana" in additional_services:
            grafana.start(plan, prometheus_url)

    if "loki" in additional_services:
        loki.upload_global_files(plan)
        loki.start(plan)
