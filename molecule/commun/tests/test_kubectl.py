"""Role testing files using testinfra."""
import re


def test_kubectl_package(host):
    kubectl = host.package("kubectl")
    assert kubectl.is_installed
    assert kubectl.version.startswith("1.21")


def test_kubectl_config(host):
    ansible_vars = host.ansible.get_variables()

    if "kubernetes_masters" in ansible_vars['group_names']:
        config = host.file("/root/.kube/config")
        assert config.exists
        assert config.user == "root"
        assert config.group == "root"
        assert config.mode == 0o600
    else:
        config = host.file("/root/.kube/config")
        assert not config.exists


def test_kubectl_connection(host):
    ansible_vars = host.ansible.get_variables()

    if "kubernetes_masters" in ansible_vars['group_names']:
        kubectl = host.run('kubectl version')
        assert kubectl.rc == 0
    else:
        kubectl = host.run('kubectl version')
        assert kubectl.rc == 1


def test_kubectl_client_server_version(host):
    ansible_vars = host.ansible.get_variables()

    if "kubernetes_masters" in ansible_vars['group_names']:
        version_raw = re.sub(r"[CS][a-z]+ Version: ", "",
                             host.run('kubectl version --short').stdout)
        versions = version_raw.split('\n')

        assert versions[0] == versions[1]
