DOCKER_REGISTRY_MIRROR=http://10.0.4.40:5000
QUAY_REGISTRY_MIRROR=10.0.4.40:5002
K8S_REGISTRY_MIRROR=10.0.4.40:5001
INSECURE_REGISTRIES=["10.0.4.40:5000","10.0.4.40:5001","10.0.4.40:5002"]
CENTOS_BASE_MIRROR=http://10.0.4.40:8081/repository/centos-base/centos
DEBIAN_BASE_MIRROR=http://10.0.4.40:8081/repository/debian-proxy
DOCKER_YUM_MIRROR=http://10.0.4.40:8081/repository/docker-yum
DOCKER_APT_MIRROR=http://10.0.4.40:8081/repository/docker-debian
K8S_YUM_MIRROR=http://10.0.4.40:8081/repository/kube-yum/
K8S_APT_MIRROR=http://10.0.4.40:8081/repository/kubernetes-deb
CRIO_BASE_URL=http://10.0.4.40:8081/repository/download-opensuse/
CONTAINERD_REGISTRY_MIRRORS='[{"name":"10.0.4.40:5000","endpoint":["http://10.0.4.40:5000"]},{"name":"10.0.4.40:5001","endpoint":["http://10.0.4.40:5001"]},{"name":"10.0.4.40:5002","endpoint":["http://10.0.4.40:5002"]},{"name":"docker.io","endpoint":["http://10.0.4.40:5000"]}]'
CONTAINERD_REGISTRY_CONFIGS=[{"name":"10.0.4.40:5000","tls":{"insecure_skip_verify":true}}]
CRIO_REGISTRIES=[{"prefix":"10.0.4.40:5000","insecure":true,"location":"10.0.4.40:5000"},{"prefix":"10.0.4.40:5001","insecure":true,"location":"10.0.4.40:5001"},{"prefix":"10.0.4.40:5002","insecure":true,"location":"10.0.4.40:5002"},{"prefix":"quay.io","insecure":true,"blocked":false,"location":"10.0.4.40:5002"},{"prefix":"k8s.gcr.io","insecure":true,"location":"10.0.4.40:5001"},{"prefix":"docker.io","insecure":true,"location":"10.0.4.40:5000"}]
REMOTE_HOST=true
PROVIDER_ARGS=['host="kvm"', 'username="libvirt-user"']
SSH_CONFIG=ssh_config_ugi
SSH_ARGS=-o ProxyCommand="ssh -W %h:%p -q -l libvirt-user kvm"
