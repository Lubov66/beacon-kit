deps = import_module("../packages/deps.star")
contracts = import_module("../packages/contracts.star")
optimism = import_module("../packages/optimism.star")

NAME = "op-proposer"

def launch(plan, image, files, env, l1, proposer_rpc_port, node_rpc_url):
    proposer_cmd = "{} --poll-interval={}s --rpc.port={} --rollup-rpc={} --l2oo-address=$L2ProxyAddress --private-key={} --l1-eth-rpc={}".format(
        NAME,
        env.l1_block_time,
        proposer_rpc_port,
        node_rpc_url,
        env.proposer_pk,
        l1.rpc_url,
    )
    proposer_rpc_url = "http://{}:{}".format(NAME, proposer_rpc_port)
    service = plan.add_service(
        name = NAME,
        config = ServiceConfig(
            image = image,
            entrypoint = ["/bin/sh", "-c"],
            cmd = [
                "{} && L2ProxyAddress=$(jq -r '.L2OutputOracleProxy' {}/deployments/getting-started/l1.json) && {}".format(
                    deps.get(["bash", "jq"]),
                    contracts.PATH,
                    proposer_cmd,
                ),
            ],
            ports = {
                "rpc": PortSpec(number = int(proposer_rpc_port)),
            },
            files = {optimism.PATH: files.optimism},
        ),
    )

    return service.ip_address