# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## 1.0.5
### Changes
- Set kubernetes default version to 1.21.0

### Fixed
- Apt key on debian os is now fetched from google cloud

## 1.0.4
### Changes
- Update calico to v3.18.1


## 1.0.3
### Changes
- Update calico to v3.17.3

### Fixed
- client_ca pem file access rights
- copy all custom ca certificates when multiple masters

## 1.0.2
### Added
 - ability to change ip autodetect method

## 1.0.1
### Added
- Ability to define a metrics bind address for kube-proxy
- Ability to define a bind address for kube-controller-manager
- Ability to define a bind address for kube-scheduler
- Ability to define a cgroup driver
- When custom AC is defined, use it to generate cert and key for kube-controller-manager
- When custom AC is defined, use it to generate cert and key for kube-scheduler
- Supports kubernetes version 1.20.0
- Tested with cri-o

### Changes
- update calico to v3.17.0
- update metrics-server to v0.4.1

### Fixed
- set cgroup according to host implementation

## 0.0.5
### Changes
- Tests with containerd on debian

## 0.0.4
### Added
- containerd compatibility

## 0.0.3
### Added
- Verify yum gpg key by default
- Ability to disable yum gpg keys in case a corporate proxy prevents getting them
- Debian distributions are now supported and tested on debian buster

### Changes
- Iptables rules aren't managed anymore by this role
- Lowered csr appoval for kubelet verbosity
- BREAKING : Flattened structure centos.kubernetes.repo to kubernetes_yum_repo variable
- BREAKING : Renamed kubernetes_pki vars for translation


## 0.0.2
### Added
- Ability to use a custom CA chain

### Fixed
- Cordon doesn't fail anymore when pods use local storage


## 0.0.1
### Added
- Supports kubernetes version 1.19.2
- Supports kubernetes version 1.19.3
- Calico cni deployment
- Flannel cni deployment
- metrics-server deployment
- kubelet tls bootstrap
- ipvs configuration for kube-proxy
- Client x509 authentification configuration
- Custom cluster AC configuration

### Changes
- BREAKING: rename k8s_kubeconfig var to kubernetes_kubeconfig_file

### Fixed
