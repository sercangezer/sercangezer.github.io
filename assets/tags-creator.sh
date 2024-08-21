#!/bin/bash

tags_array=("/etc/fstab" "AWX" "AWX Credential Type" "AllowPrivilegeEscalation" "Ansible" "Auditing" "Bash" "Bash Script" "CI/CD" "CKS" "CPU Limits" "CPU Request" "CVE" "Centos 7" "Container" "Container Security Context" "Continious Delivery" "Continious Integration" "DevOps" "Disk Yönetimi" "Distributed Block Storage" "Dockerfile" "Dosya Sistemi" "Falco" "Freezing" "GIT" "Github" "Github API" "Github Organizasyon" "Github Repo" "Gvisor" "Güvenlik açığı" "HELM" "Helm" "HostOnly Network" "IP range" "Image" "Imaj" "Immutable" "Immutable Container" "Immutable Pod" "Jekyll" "Jenkins" "K8s" "Kafka" "Kernel" "Klavye dili" "Kubeapiserver" "Kubelet" "Kubernetes" "Kubernetes tool" "Kubeview" "Lens" "Lens resource map eklentisi" "Linux" "Linux Terminal" "Logging" "Longhorn" "Memory Limits" "Memory Request" "MinTtlsMinVersion" "Network Interface" "Nexus Repository" "Opensource" "PS1" "Pod" "Policy" "Private Registry" "Privileged" "Proxmox" "RAID" "Rancher" "ReadOnlyRootFilesystem" "Redhat based" "Ruby" "Runc" "Runsc" "Runtimeclass" "SELinux" "SELinux disable" "SSHFS" "SSL sertifikası" "Sanal Makine" "Selfsigned certificate" "Skopeo" "Sonatype Nexus Repository" "Source Control" "Tlsciphersuites" "Tlsminversion" "TlsCipherSuites" "Trivy" "VBoxManage" "Vagrant" "Vagrant Provider" "Vagrantfile" "Veri bütünlüğü" "VirtualBox" "Windterm" "Zone AntiAffinity" "docker" "docker compose" "dockercompose" "k3s" "localectl" "openssl" "qemuimg" "rbenv" "setxkbmap" "sha256sum" "vagrantdisksize")

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