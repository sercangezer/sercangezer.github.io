---
layout: post
title: Linux VirtualBox üzerinde Host-Only network için IP aralığı sorunu
description: Linux VirtualBox üzerinde Host-Only network için IP aralığı sorunu
summary:  The IP address configured for the host-only network is not within the allowed ranges
tags: 
  - VirtualBox
  - Sanal Makine
  - Host-Only Network
  - IP range
minute: 1
---



![](../images/2023/20231117-linux-virtualbox-host-only-network-ip-range-sorunu.png)

Esenlikler,

Develop ortamlarımızın vazgeçilmez Type-II sanallaştırma uygulaması [`VirtualBox`](https://www.virtualbox.org/)'ı Linux ortamlarda `Host-Only Network` ile birlikte kullandığımızda sadece makinelere `192.168.56.0/24` aralığında IP vermemize izin veriyor.

* Sanal makinemize `192.168.100.51` gibi bir IP vermek istediğimizde aşağıdaki gibi bir hatayla karşılaşıyoruz.

```bash
The IP address configured for the host-only network is not within the
allowed ranges. Please update the address used to be within the allowed
ranges and run the command again.

  Address: 192.168.100.51
  Ranges: 192.168.56.0/21

Valid ranges can be modified in the /etc/vbox/networks.conf file. For
more information including valid format see:

  https://www.virtualbox.org/manual/ch06.html#network_hostonly

```

* Bunu aşabilmek ve istediğimiz IP'de sunucu oluşturabilmemiz için `/etc/vbox/networks.conf` dosyasını aşağıdaki satırla değiştirmemiz gerekiyor.

```bash
cat << EOF | sudo tee /etc/vbox/networks.conf
* 0.0.0.0/0 ::/0
EOF
```

Artık istediğiniz IP'yi sanal makinelerinize verebilirsiniz.

Esen kalın..