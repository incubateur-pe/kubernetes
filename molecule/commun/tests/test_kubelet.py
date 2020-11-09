"""Role testing files using testinfra."""


def test_kubelet_package(host):
    kubelet = host.package("kubelet")
    assert kubelet.is_installed
    assert kubelet.version.startswith("1.19")


def test_kubelet_service(host):
    kubelet = host.service("kubelet")
    assert kubelet.is_running
    assert kubelet.is_enabled
