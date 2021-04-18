"""Role testing files using testinfra."""


def test_kubeadm_package(host):
    kubeadm = host.package("kubeadm")
    assert kubeadm.is_installed
    assert kubeadm.version.startswith("1.21")
