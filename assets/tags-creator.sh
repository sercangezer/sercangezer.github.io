#!/bin/bash

tags_array=("AWX" "AWX Credential Type" "AllowPrivilegeEscalation" "Ansible" "Auditing" "CKS" "CPU Limits" "CPU Request" "CVE" "Centos 7" "Container" "Container Security Context" "Continious Delivery" "Continious Integration" "DevOps" "Disk Yönetimi" "Distributed Block Storage" "Dockerfile" "Dosya Sistemi" "Falco" "Freezing" "GIT" "Github" "Github API" "Github Organizasyon" "Github Repo" "Gvisor" "Güvenlik açığı" "Helm" "HostOnly Network" "IP range" "Image" "Imaj" "Immutable" "Immutable Container" "Immutable Pod" "Jekyll" "Jenkins" "K8s" "Kernel" "Kubeapiserver" "Kubelet" "Kubernetes" "Kubernetes tool" "Kubeview" "Lens" "Lens resource map eklentisi" "Linux" "Logging" "Longhorn" "Memory Limits" "Memory Request" "MinTtlsMinVersion" "Nexus Repository" "Pod" "Policy" "Privileged" "Proxmox" "RAID" "Rancher" "ReadOnlyRootFilesystem" "Redhat based" "Ruby" "Runc" "Runsc" "Runtimeclass" "SELinux" "SELinux disable" "SSL sertifikası" "Sanal Makine" "Selfsigned certificate" "Source Control" "Tlsciphersuites" "Tlsminversion" "TlsCipherSuites" "Trivy" "Vagrant" "Vagrant Provider" "VirtualBox" "Zone AntiAffinity" "openssl" "qemuimg" "rbenv")

rm -rf /GIT/sercangezer.github.io/tag/*

for i in "${tags_array[@]}"
do
echo $i
cd /GIT/sercangezer.github.io/tag
 mkdir "$i"
cd "/GIT/sercangezer.github.io/tag/$i"

cat << EOF > index.html
---
layout: tag
tag: $i
---
EOF
done