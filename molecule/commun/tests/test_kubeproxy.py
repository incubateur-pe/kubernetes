"""Role testing files using testinfra."""


def test_metrics_exposed(host):
    assert host.socket("tcp://0.0.0.0:10249").is_listening
