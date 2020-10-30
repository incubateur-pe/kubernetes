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
| flannel_version | role | version de flannel a installer | v0.13.0 |
| kubernetes_cluster_name | role | Nom du cluster kubernetes | kubernetes |
| kubernetes_pod_subnet | role | Sous réseau pour le cni | 10.244.0.0/16 |
| kubernetes_control_plane_endpoint | role | Adresse du loadblancer servant les noeuds masters | ansible_fqdn du premier master |
| kubernetes_image_repository | role | repository des images k8s | k8s.gcr.io |
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

Bugs notables de molecule/libvirt :

  * [issue #921](https://github.com/vagrant-libvirt/vagrant-libvirt/issues/921#issuecomment-464334757) : nécessite sur certains os de modifier le plugin
  * Le port-forward créé par vagrant n'est pas utilisé par molecule, l'accès se fait directement par l'adresse de management de la VM, il faut pour cela la router et dé-filtrer via iptables le flux du network nat sur le host kvm
    * Contournement possible en utilisant l'option ProxyCommand d'OpenSSH

License
-------

BSD
