"""Role testing files using testinfra."""

def test_iptables_service_package(host):
    iptablesService = host.package("iptables-services")
    assert iptablesService.is_installed

def test_iptables_rules(host):
    if host.service("docker").is_running:
        assert '-A DOCKER-USER -j ACCEPT' in host.iptables.rules(chain='DOCKER-USER')
    else:
        assert '-P FORWARD ACCEPT' in host.iptables.rules()
