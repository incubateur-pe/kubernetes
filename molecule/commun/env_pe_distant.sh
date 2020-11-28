DOCKER_REGISTRY_MIRROR=https://docker-dev-virtual.repository.pole-emploi.intra
QUAY_REGISTRY_MIRROR=docker-quay-proxy.repository.pole-emploi.intra
K8S_REGISTRY_MIRROR=docker-k8s-gcr-proxy.repository.pole-emploi.intra
INSECURE_REGISTRIES=["docker-dev-virtual.repository.pole-emploi.intra", "docker-quay-proxy.repository.pole-emploi.intra", "docker-k8s-gcr-proxy.repository.pole-emploi.intra"]
CENTOS_BASE_MIRROR=https://repository.pole-emploi.intra/artifactory/rpm-base-centos-proxy
DEBIAN_BASE_MIRROR=http://artefact-repo.pole-emploi.intra/artifactory/deb.debian.org-Proxy
DOCKER_YUM_MIRROR=http://artefact-repo.pole-emploi.intra/artifactory/DebianDocker-proxy
DOCKER_APT_MIRROR=http://artefact-repo.pole-emploi.intra/artifactory/DebianDocker-proxy
K8S_YUM_MIRROR=https://repository.pole-emploi.intra/artifactory/rpm-kubernetes-proxy/
K8S_APT_MIRROR=http://artefact-repo.pole-emploi.intra/artifactory/DebianKubernetes-Proxy
CONTAINERD_REGISTRY_MIRRORS='[{"name":"docker-dev-virtual.repository.pole-emploi.intra","endpoint":["https://docker-dev-virtual.repository.pole-emploi.intra"],"skip_ssl_verify":true},{"name":"docker-quay-proxy.repository.pole-emploi.intra","endpoint":["https://docker-quay-proxy.repository.pole-emploi.intra"],"skip_ssl_verify":true},{"name":"docker-k8s-gcr-proxy.repository.pole-emploi.intra","endpoint":["https://docker-k8s-gcr-proxy.repository.pole-emploi.intra"],"skip_ssl_verify":true},{"name":"k8s.gcr.io","endpoint":["https://docker-k8s-gcr-proxy.repository.pole-emploi.intra"],"skip_ssl_verify":true},{"name":"docker.io","endpoint":["https://docker-dev-virtual.repository.pole-emploi.intra"]}]'
REMOTE_HOST=true
PROVIDER_ARGS=['host="iugi3000-HP-ProDesk-400-G4-MT.dgasi.pole-emploi.intra"', 'username="libvirt-user"']
SSH_CONFIG=ssh_config_pe
SSH_ARGS=-o ProxyCommand="ssh -W %h:%p -q -l libvirt-user iugi3000-HP-ProDesk-400-G4-MT.dgasi.pole-emploi.intra"
http_proxy
https_proxy
HTTP_PROXY
HTTPS_PROXY
no_proxy
NO_PROXY
