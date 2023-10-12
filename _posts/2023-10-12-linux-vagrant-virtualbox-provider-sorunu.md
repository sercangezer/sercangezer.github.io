---
layout: post
title: Linux ortamda Vagrant Virtualbox provider sorunu
description: Fedora Linux ortamda Vagrant Virtualbox provider sorunu
summary:  Fedora Linux ortamda Vagrant Virtualbox provider sorunu
tags: 
  - Linux
  - Vagrant
  - VirtualBox
  - Vagrant Provider
minute: 1
---

Esenlikler,

Linux sunucularda vagrant ile test ortamı oluşturmaya çalıştığımızda `virtualbox provider` ına değil de `libvirt provider` a gitmeye çalışıyorsa aşağıdaki adımları uygulayarak çözüme gidebilirsiniz. 

### HATA
```bash
Bringing machine 'ansibledeney' up with 'libvirt' provider...
==> ansibledeney: Box 'ubuntu/jammy64' could not be found. Attempting to find and install...
    ansibledeney: Box Provider: libvirt
    ansibledeney: Box Version: >= 0
==> ansibledeney: Loading metadata for box 'ubuntu/jammy64'
    ansibledeney: URL: https://vagrantcloud.com/ubuntu/jammy64
The box you're attempting to add doesn't support the provider
you requested. Please find an alternate box or use an alternate
provider. Double-check your requested provider to verify you didn't
simply misspell it.

If you're adding a box from HashiCorp's Vagrant Cloud, make sure the box is
released.

Name: ubuntu/jammy64
Address: https://vagrantcloud.com/ubuntu/jammy64
Requested provider: [:libvirt]

```

* Öncelikle vagrant ın güncel olup olmadığını kontrol edelim ve güncel repodan güncel sürümü çekelim. (Ben Fedora Linux kullanıyorum.)

```bash
sudo dnf install -y dnf-plugins-core
sudo dnf config-manager --add-repo https://rpm.releases.hashicorp.com/fedora/hashicorp.repo
sudo dnf update
```
> ❗ Diğer sürümlere ait repolar: https://developer.hashicorp.com/vagrant/downloads

* `VAGRANT_DEFAULT_PROVIDER` global değişkenini `~/.bashrc` dosyamıza eklememiz gerekiyor.

```bash
echo "export VAGRANT_DEFAULT_PROVIDER=virtualbox" >> ~/.bashrc
source ~/.bashrc
```

* Artık `vagrant up` ile sunucularımızı kaldırabiliriz. 