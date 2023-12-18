---
layout: post
title: spesifik Vagrantfile ile çalışmak
description: Development ortamlarında spesifik Vagrantfile ile çalışmak
summary:  Geliştirme ortamlarında spesifik Vagrantfile ile çalışmak
tags: 
  - Vagrant
  - Vagrantfile
minute: 1
---



![](../images/2023/20231218-spesifik-vagrantfile-kullanmak.png)

Esenlikler,

Geliştirme ortamlarını hızlıca ayağa kaldırmak için kullandığımız güzel bir uygulamadır [`Vagrant`](https://www.vagrantup.com/). Sunucuları ayağa kaldırabilmemiz için tabii ki de bir `Vagrantfile` konfigürasyon dosyamız mevcut.

Genelde böyle uygulamalarda `-f` parametresi ile istediğimiz konfigürasyon dosyasından uygulamayı çalıştırabiliyoruz fakat `Vagrant` sadece `Vagrantfile` adındaki konfigürasyon dosyasını okuyor.

Bunu aşmak için basit bir yöntem var. Kullanmak istediğimiz dosyayı değişkene atıyoruz. Şöyle ki;

```bash
VAGRANT_VAGRANTFILE=/home/sercangezer/benim-vagrantfile-m vagrant up
```

Esen kalın ...