# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## 0.0.02
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
