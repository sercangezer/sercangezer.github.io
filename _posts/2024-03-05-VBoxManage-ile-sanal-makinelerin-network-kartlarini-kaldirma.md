---
layout: post
title: "VBoxManage ile VirtualBox üzerindeki sanal makinelerin bütün network kartlarını silme"
description: "VBoxManage ile VirtualBox üzerindeki sanal makinelerin bütün network kartlarını silme"
summary: "VBoxManage ile VirtualBox üzerindeki sanal makinelerin bütün network kartlarını silme"
tags: 
  - VirtualBox
  - VBoxManage
  - "Network Interface"
minute: 1
---

Esenlikler,

Vagrantfile ile oluşturduğum makinelere Bridge network vermekle uğraşmak istemezken **VirtualBox üzerindeki sanal makinelerin network kartlarını script ile nasıl kaldırırım?** a geldim ve aşağıdaki script bu ameleliği üzerimizden alıyor.

```bash
# Sanal makine adları
vm_names=("master" "worker01" "worker02")

# Her bir sanal makine için tüm network interfacelerini silme işlemi
for vm_name in "${vm_names[@]}"
do
    # Host-only interfaceleri kaldırma
    hostonly_interfaces=$(VBoxManage showvminfo "$vm_name" --machinereadable | grep -oP 'hostonlyadapter\d+=' | grep -oP '\d+')
    for hostonly_interface in $hostonly_interfaces
    do
        VBoxManage modifyvm "$vm_name" --nic$hostonly_interface none
    done
    echo "Sanal makine '$vm_name' için hostonly network interfaceleri başarıyla silindi."



    # bridge interfaceleri kaldırma
    bridge_interfaces=$(VBoxManage showvminfo "$vm_name" --machinereadable | grep -oP 'bridgeadapter\d+=' | grep -oP '\d+')
    for bridge_interface in $bridge_interfaces
    do
        VBoxManage modifyvm "$vm_name" --nic$bridge_interface none
    done
    echo "Sanal makine '$vm_name' için bridge network interfaceleri başarıyla silindi."

     # NAT interfaceleri kaldırma
    nat_interfaces=$(VBoxManage showvminfo "$vm_name" --machinereadable | grep -oP 'natnet\d+=' | grep -oP '\d+')
    for nat_interface in $nat_interfaces
    do
        VBoxManage modifyvm "$vm_name" --nic$nat_interface none
    done
    echo "Sanal makine '$vm_name' için NAT network interfaceleri başarıyla silindi." 
done
```

Esen kalın ...