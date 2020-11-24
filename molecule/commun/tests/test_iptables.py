"""Role testing files using testinfra."""


def test_iptables_rules(host):
    if host.service("docker").is_running:
        rules = host.iptables.rules(chain='DOCKER-USER')
        assert '-A DOCKER-USER -j ACCEPT' in rules
    else:
        assert '-P FORWARD ACCEPT' in host.iptables.rules()
