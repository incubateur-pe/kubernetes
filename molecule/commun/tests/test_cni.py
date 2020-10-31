"""Role testing files using testinfra."""

def test_flannel_interfaces(host):
    flannel = host.interface("flannel.1")
    assert flannel.exists
    assert flannel.addresses[0].startswith('10.244.')

def test_flannel_config(host):
    config = host.file("/etc/cni/net.d/10-flannel.conflist")
    assert config.exists
    assert config.user == "root"
    assert config.group == "root"
    assert config.mode == 0o644
