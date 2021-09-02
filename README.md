![pipeline](https://gitlab.com/incubateur-pe/kubernetes-bare-metal/badges/dev/pipeline.svg)

kubernetes-bare-metal
=========

Install a kubernetes cluster with kubeadm
The goal of this role is to provide a way to install a full featured, production ready cluster, in a single role.
This role is usable behind a corporate proxy, and/or through mirrors for accessing packages and images resources, you can use it in a totally cloisoned environment, without any direct access to the internet.

Prerequisites
------------

__Local__:

Python : see requirements.yaml : `pip install -r requirements.yaml`

__Servers__:

  * CRI : the runtime will be detected by kubeadm
  * Swap : No swap should be activated on the servers

__Inventory__:

  * Group kubernetes_masters : Contains all hosts which role will be kubernetes master
  * Group kubernetes_workers : Contains all hosts which role will be kubernetes workers


Variables
--------------

__repositories :__

| variable | scope | description | defaut |
| --- | --- | --- | --- |
| kubernetes_apt_repository | role | Kubernetes apt repository address | https://apt.kubernetes.io |
| kubernetes_apt_key_url | role | Url serving the google cloud public signing key | https://packages.cloud.google.com/apt/doc/apt-key.gpg |
| kubernetes_yum_repo | role | Kubernetes rpm repository address for RHEL | https://packages.cloud.google.com/yum/repos/ |
| kubernetes_yum_enable_gpg | role | Set to false to disable gpg check on yum repo | true |
| kubernetes_yum_repo_key | role | yum repository gpg key (repository) | https://packages.cloud.google.com/yum/doc/yum-key.gpg |
| kubernetes_yum_package_key | role | yum repository gpg key (packages) | https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg |

__kubernetes cluster:__:

| variable | scope | description | defaut |
| --- | --- | --- | --- |
| kubernetes_version | role | Kubernetes version to install or upgrade to | 1.20.0 |
| node_name | host | Kubernetes node name, must be unique | see kubeadm documentation |
| kubernetes_cluster_name | role | Kubernetes cluster name | kubernetes |
| kubernetes_control_plane_endpoint | role | Load balancer (or apiServer if only one master) address serving the master nodes (dns name or ip) | first master's ansible_fqdn |
| kubernetes_control_plane_port | role | Load balancer port (or apiServer if only one master) of the apiServer | 6443 |
| kubernetes_image_repository | role | kubernetes images repository | k8s.gcr.io |
| kubernetes_api_server_advertise_address | host | Advertise address of the api server (example: 172.16.10.10 ) | ansible_default_ipv4.address |
| kubernetes_api_server_port | role | Api server listen port | 6443 |
| kubernetes_kubeconfig_file | role | Kubernetes local configuration file (fetched from the master) | {{ role_path }}/files/admin.conf |
| kubernetes_kube_proxy_metrics_bind_address | role | kube-proxy bind address, necessary to expose metrics for example | see kubeadm documentation |
| kubernetes_kube_controller_manager_bind_address | role | kube-controller-manager bind address | see kubeadm documentation |
| kubernetes_kube_controller_manager_port | role | kube-controller-manager insecure port (deprecated), necessary to expose metrics for example | N/A |
| kubernetes_kube_scheduler_bind_address | role | kube-scheduler bind address | see kubeadm documentation |
| kubernetes_kube_scheduler_port | role | kube-scheduler insecure port (deprecated), to expose metrics for example | N/A |
| kubernetes_cgroup_driver | role | cgroup driver to use for kubelet, default to auto detection by kubeadm | N/A |
| kubernetes_kubeadm_target | role | Playbook host that will be used as a target for all kubeadm/kubectl operations | first master |


__kubernetes networking:__:

| variable | scope | description | defaut |
| --- | --- | --- | --- |
| kubernetes_cni_driver | role | Defines the cni driver to use (currently supported : flannel, calico, antrea) | flannel |
| flannel_image | role | Name of the flannel repository/image | quay.io/coreos/flannel |
| flannel_version | role | Flannel image version to use | v0.13.0 |
| flannel_backend_type | role | Flannel backend to use | vxlan |
| calico_ip_autodetect_method | role | IP_AUTODETECTION_METHOD method value | first-found |
| calico_network_config | role | calico network configuration | see default/main.yml |
| kubernetes_proxy_mode | role | Kube-proxy mode (example: iptables, ipvs...) | ipvs |
| kubernetes_proxy_mode_ipvs_sync_period | role | Max duration between 2 ipvs syncs | 30s |
| kubernetes_proxy_mode_ipvs_min_sync_period | role | Min duration betwwen 2 ipvs syncs | 2s |
| kubernetes_proxy_mode_ipvs_scheduler | role | Ipvs scheduler to use ( rr,lc,dh,sh,sed,nq ) | rr |
| kubernetes_proxy_mode_iptables_sync_period | role | Max duration between 2 iptables syncs | 30s |
| kubernetes_proxy_mode_iptables_min_sync_period | role | Min duration betwwen 2 iptables syncs | 2s |
| kubernetes_pod_subnet | role | Subnet to configure as the podCIDR for the cni | 10.244.0.0/16 |
| kubernetes_service_subnet | role | Services subnet | voir documentation kubeadm |

__certificates :__

| variable | scope | description | defaut |
| --- | --- | --- | --- |
| kubernetes_pki.certificate | role | Pem file to upload and use for the cluster certificate authority | N/A |
| kubernetes_pki.private_key | role | Key file to upload and use for the cluster certificate authority | N/A |
| kubernetes_pki.ca_chain | role | Full CA chain for kube-controller-manager and pods | N/A |
| kubernetes_client_ca_file | role | Pem file to upload and use for the cluster client certificate chain | N/A |

__miscellaneous :__

| variable | scope | description | defaut |
| --- | --- | --- | --- |
| metrics_server_image | role | Repository/image to use for metrics_server | k8s.gcr.io/metrics-server/metrics-server |
| metrics_server_image_version | role | Version of metrics server image to use | v0.4.0 |
| metrics_server_wait_deploy | role | Wait the deployment of metrics-server, useful if you deploy the masters in a separate play | true |
| kubernetes_cloud_provider | role | Cloud provider to use | N/A |
| kubernetes_upgrade_consistency_check | role | Check for cluster nodes versions consistency ( set to false if upgrade is done with 2 plays) | true |
| kubernetes_upgrades_allowed | role | Should the role handle upgrades | true |
| kubernetes_confirm_upgrade | role | If an upgrade is needed, ask for user input before execution | false |
| kubernetes_kubelet_cgroup_slice | role | Cgroup slice to run kubelet  | N/A |

Certificates Management
-----------------------

The variables in the `certificates` section allows configuration of a custom CA for the cluster, for example, an intermediate CA, generated from a corporate internal PKI, which in turn will enable all client workstations to trust the cluster. This impacts the kubeconfig file for example, removing the need for the certificate-authority-data configuration

if you want to enable this behaviour, set `kubernetes_pki.certificate` and `kubernetes_pki.private_key` to the AC files, they will be uploaded to the masters servers and used as the cluster's CA

When a custom CA is provided, non self signed certificates are generated for kube-controller-manager and kube-scheduler

__intermediate ca__:

If the files provided aren't a root CA, you should provide the full ca chain file and set `kubernetes_pki.ca_chain` accordingly.
Also pay attention to the pathlen size of your CA if you plan to generate etcd ca from this CA

Playbook Example
----------------

```yaml
- hosts: all
  remote_user: root
  roles:
    - kubernetes-bare-metal
  vars:
    kubernetes_control_plane_endpoint: master.k8s.loc
    kubernetes_cluster_name: dev
    k8s_version: 1.20.0
```

It remains possible to dissociate masters and workers installation, although the masters must be in the same ansible inventory:

```yaml
- hosts: kubernetes_masters
  remote_user: root
  roles:
    - kubernetes-bare-metal
  vars:
    kubernetes_control_plane_endpoint: master.k8s.loc
    kubernetes_cluster_name: dev
    k8s_version: 1.20.0
    metrics_server_wait_deploy: false # Metrics-server will be waited in the worker play

- hosts: kubernetes_workers
  remote_user: root
  roles:
    - kubernetes-bare-metal
  vars:
    kubernetes_control_plane_endpoint: master.k8s.loc
    kubernetes_cluster_name: dev
    k8s_version: 1.20.0
    kubernetes_upgrade_consistency_check: no # Déactivate versions consistency check as part of the cluster may already be up to date
```

Tests
-----

The tests use molecule + libvirt + kvm distant + testinfra, allowing on the fly multi-nodes clusters creation and system configuration checks

Install prerequisites : `pip install -r requirements-tests.yaml`
Install vagrant : https://www.vagrantup.com/downloads
Install vagrant-libvirt plugin : `vagrant plugin install vagrant-libvirt`

__molecule/libvirt issues:__

  * [issue #921](https://github.com/vagrant-libvirt/vagrant-libvirt/issues/921#issuecomment-464334757) : Requires to edit the plugin on certain os
  * The vagrant port-forward isn't used by molecule, acces is made directly to the VM management interface, so the management network must be routed
    * Workaround: use OpenSSH option ProxyCommand in molecule config

__Tests execution with testInfra:__

With a local KVM/Qemu, everything works fine, although distant vms access on a distant KVM host, if the network isn't routed requires an ssh config like :

```
Host bastion
  Hostname kvm
  IdentityFile ~/.ssh/id_rsa
  User libvirt-user

Host 192.168.121.*
  ProxyJump bastion
```

__Tests execution with docker:__
```
# interactive :
docker run --env-file molecule/commun/env_local_tests.sh -v $(pwd):/sources/kubernetes-bare-metal -w /sources/kubernetes-bare-metal   -v ~/.vagrant.d/boxes/:/root/.vagrant.d/boxes/   -v /var/run/libvirt/libvirt-sock:/var/run/libvirt/libvirt-sock --dns 192.168.121.1 --dns 10.0.4.1 --network host   -it --entrypoint bash ulrichg/molecule-vagrant-libvirt:latest

# lint:
docker run --env-file molecule/commun/env_local_tests.sh -v $(pwd):/sources/kubernetes-bare-metal -w /sources/kubernetes-bare-metal   -v ~/.vagrant.d/boxes/:/root/.vagrant.d/boxes/   -v /var/run/libvirt/libvirt-sock:/var/run/libvirt/libvirt-sock ulrichg/molecule-vagrant-libvirt:latest lint

# default scenario:
docker run --env-file molecule/commun/env_local_tests.sh -v $(pwd):/sources/kubernetes-bare-metal -w /sources/kubernetes-bare-metal   -v ~/.vagrant.d/boxes/:/root/.vagrant.d/boxes/   -v /var/run/libvirt/libvirt-sock:/var/run/libvirt/libvirt-sock --dns 192.168.121.1 --dns 10.0.4.1 --network host  ulrichg/molecule-vagrant-libvirt:latest

# other scenario:
docker run --env-file molecule/commun/env_local_tests.sh -v $(pwd):/sources/kubernetes-bare-metal -w /sources/kubernetes-bare-metal   -v ~/.vagrant.d/boxes/:/root/.vagrant.d/boxes/   -v /var/run/libvirt/libvirt-sock:/var/run/libvirt/libvirt-sock --dns 192.168.121.1 --dns 10.0.4.1 --network host  ulrichg/molecule-vagrant-libvirt:latest test -s cluster1master
```
License
-------

BSD 3-Clause
