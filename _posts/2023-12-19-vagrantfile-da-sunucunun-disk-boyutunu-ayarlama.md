---
layout: post
title: Vagrantfile'da sunucunun disk boyutunu ayarlama
description: Hashicorp Vagrantfile sunucunun disk boyutunu atama
summary:  Vagrantfile sunucunun disk boyutunu ayarlama
tags: 
  - Vagrant
  - Vagrantfile
  - vagrant-disksize
  - Disk Yönetimi
  - VirtualBox
minute: 1
---



![](../images/2023/20231219-vagrantfile-da-sunucunun-disk-boyutunu-ayarlama.png)

Esenlikler,

[`Vagrant`](https://www.vagrantup.com/), geliştirme ortamlarını hızlıca ayağa kaldırmak için kullandığımız güzel bir ürün. Vagrantfile ile bir sunucu ayağa kaldırdığımızda `40GB` bir disk boyutu ile ayaklandırıyor.

Bundan 7 yıl önce bu sorun için bir plugin yazılmış hayırsever bir arkadaş tarafından. Bknz: [**github/vagrant-disksize**](https://github.com/sprotheroe/vagrant-disksize) 

### Kurulum

* `vagrant-disksize` eklentisini sistemimize yükleyelim.

```bash
vagrant plugin install vagrant-disksize
```

* `Vagrantfile` dosyamızdaki `config` kısmına aşağıdaki parametreyi ekliyoruz.

```bash
  config.vm.define "sercangezer" do |sercangezer|
    sercangezer.vm.box = "ubuntu/jammy64"
    sercangezer.disksize.size = '100GB' #Diskin 100GB olmasını istiyoruz.
```

* Çıktısı

```bash
==> sercangezer: Resized disk: old 40960 MB, req 102400 MB, new 102400 MB
==> sercangezer: You may need to resize the filesystem from within the guest.
```

#### Dipnot

* Eklenti yükleme işini de Vagrantfile'a bırakmak için Vagrantfile'ın üst kısmına aşağıdaki kod bloğunu ekleyebilirsiniz.

```ruby
required_plugins = ["vagrant-disksize"]
plugins_to_install = required_plugins.select { |plugin| not Vagrant.has_plugin? plugin }
if not plugins_to_install.empty?
  puts "Yüklenen eklenti: #{plugins_to_install.join(' ')}"
  if system "vagrant plugin install #{plugins_to_install.join(' ')}"
    exec "vagrant #{ARGV.join(' ')}"
  else
    abort "Eklenti yüklenemedi, manuel yüklemeyi deneyebilirsin."
  end
end
```

Esen kalın ...