#!/bin/bash

tags_array=("AWX" "AWX Credential Type" "Analyzing Container Behavior with Falco" "Ansible" "CKS" "CPU Limits" "CPU Request" "CVE" "Centos 7" "Container" "Continious Delivery" "Continious Integration" "DevOps" "Disk Yönetimi" "Dosya Sistemi" "Freezing" "GIT" "Github" "Github API" "Github Organizasyon" "Github Repo" "Jekyll" "Jenkins" "K8s" "Kernel" "Kubernetes" "Kubernetes tool" "Kubeview" "Lens" "Lens resource map eklentisi" "Linux" "Memory Limits" "Memory Request" "Nexus Repository" "Pod" "Policy" "RAID" "Redhat based" "Ruby" "SELinux" "SELinux disable" "Source Control" "Vagrant" "Vagrant Provider" "VirtualBox" "allowPrivilegeEscalation" "auditing" "container" "container security context" "dockerfile" "falco" "gvisor" "güvenlik açığı" "image" "imaj" "immutable" "immutable container" "immutable pod" "kubeapiserver" "kubelet" "logging" "minTtlsMinVersion" "pod" "privileged" "rbenv" "readOnlyRootFilesystem" "runc" "runsc" "runtimeclass" "tlsciphersuites" "tlsminversion" "tlsCipherSuites" "trivy")

rm -rf /e/Git-repositories/sercangezer.github.io/tag/*

for i in "${tags_array[@]}"
do
echo $i
cd /e/Git-repositories/sercangezer.github.io/tag
 mkdir "$i"
cd "/e/Git-repositories/sercangezer.github.io/tag/$i"

cat << EOF > index.html
---
layout: tag
tag: $i
---
EOF
done