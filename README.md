kubernetes-bare-metal
=========

Installe un cluster kubernetes avec kubeadm

Pré-requis
------------

Python : voir requirements.yaml : `pip install -r requirements.yaml`

Inventaire:

  * Groupe kubernetes_masters : Contiens tous les hosts dont le role sera des masters kubernetes.
  * Groupe kubernetes_workers : Contiens tous les hosts dont le role sera des workers kubernetes


Variables
--------------

| variable | scope | description | defaut |
| --- | --- | --- | --- |
| centos.kubernetes.repo | role | Adresse du repository rpm kubernetes pour centos | https://packages.cloud.google.com/yum/repos/ |
| kubernetes_version | role | version de kubernetes a installer | 1.19.2 |
| node_name | host | nom du noeud kubernetes, doit etre unique | voir documentation kubeadm |
| flannel_image | role | nom du repo/image de flannel | quay.io/coreos/flannel |
| flannel_version | role | version de flannel a installer | v0.13.0 |
| kubernetes_cluster_name | role | Nom du cluster kubernetes | kubernetes |
| kubernetes_pod_subnet | role | Sous réseau pour le cni | 10.244.0.0/16 |
| kubernetes_control_plane_endpoint | role | Adresse du loadbalancer (ou de l'apiServer si un seul master) servant les noeuds masters (dns ou ip uniquement) | ansible_fqdn du premier master |
| kubernetes_control_plane_port | role | Port du loadbalancer (ou de l'apiServer si un seul master) du controlPlane | 6443 |
| kubernetes_image_repository | role | repository des images k8s | k8s.gcr.io |
| kubernetes_api_server_advertise_address | host | adresse d'affichage de l'apiServer (exemple: 172.16.10.10 ) | ansible_default_ipv4.address |
| kubernetes_api_server_port | role | port d'écoute de l'apiServer | 6443 |
| kubernetes_cloud_provider | role | cloud provider a utiliser | N/A |
| k8s_kubeconfig | role | nom du fichier local de configuration kubernetes ( récupéré depuis le serveur ) | {{role_path}}/files/admin.conf |

Playbook Exemple
----------------

```
- hosts: all
  remote_user: root
  roles:
    - kubernetes-bare-metal
  vars:
    kubernetes_control_plane_endpoint: master.k8s.loc
    kubernetes_cluster_name: dev
    k8s_version: 1.19.2
```

Tests
-----

Les tests utilisent molecule + libvirt + kvm distant + testinfra pour s'exexuter, permettant ainsi la création de clusters multi-noeuds et la validation des paramètres systeme.

Installer les pré-requis : `pip install -r requirements-tests.yaml`
Installer vagrant : https://www.vagrantup.com/downloads
Installer le plugin vagrant-libvirt : `vagrant plugin install vagrant-libvirt`

__Bugs notables de molecule/libvirt :__

  * [issue #921](https://github.com/vagrant-libvirt/vagrant-libvirt/issues/921#issuecomment-464334757) : nécessite sur certains os de modifier le plugin
  * Le port-forward créé par vagrant n'est pas utilisé par molecule, l'accès se fait directement par l'adresse de management de la VM, il faut pour cela la router et dé-filtrer via iptables le flux du network nat sur le host kvm
    * Contournement possible en utilisant l'option ProxyCommand d'OpenSSH

__Execution des tests avec testInfra:__

Avec libvirt en local, aucun problème particulier, cependant pour l'accès aux VMs avec un libvirt distant, si le réseau n'est pas routé, il est possible d'utiliser une config ssh :

```
Host bastion
  Hostname 10.0.0.40
  IdentityFile ~/.ssh/id_rsa
  User libvirt-user

Host 192.168.121.*
  ProxyJump bastion
```

License
-------

BSD
