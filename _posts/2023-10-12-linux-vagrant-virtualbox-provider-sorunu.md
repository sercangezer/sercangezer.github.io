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