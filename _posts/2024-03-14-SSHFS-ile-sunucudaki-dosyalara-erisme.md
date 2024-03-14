---
layout: post
title: "SSHFS ile uzak sunucudaki klasörleri baglama"
description: "SSHFS ile NFS gibi ağ üzerinden klasör ve dosyalara erişme"
summary: "SSHFS ile NFS gibi ağ üzerinden klasör ve dosyalara erişme"
tags: 
  - SSHFS
  - Linux
minute: 1
---

Esenlikler,

İş yerindeki bilgisayarıma eve getirdiğimde kendi bilgisayarımdan bu makinedeki dosyalara erişme ihtiyacım oldu.NFS, USB kopyalama gibi meşakatli işlerle dosyaları transfer edebilirdim ama uğraşmak zor geldi açıkcası. Bu çabayı vermemek için; bu işlemleri SSH üzerinden yapan bir client yazmışlar. Bknz: [`sshfs`](https://github.com/libfuse/sshfs).

* Öncelikle gerekli paketleri kuralım. (Ben Fedora39 kullanıyorum.)

```bash
sudo dnf install ntfs-3g fuse sshfs -y
```

❗ Uzak makinede SSH servisi aktif olması gerekiyor.

* Aşağıdaki tarzda bir söz dizimi var.

```bash
sshfs [user]@[hostname}:[directory] mountpoint

# user: kullanıcı adı
# hostname: IP yada FQDN
# directory: Bağlanacağınız sunucudaki klasörün yolu
# mountpoint: Kendi makinenizdeki bağlayacağınız klasör

# Kendi makinemizde erişeceğimiz klasörü oluşturuyoruz.
sudo mkdir -p /work/VMs-ISOs

# Yetki ve sahiplik vermemiz gerekebilir.
sudo chmod 777 -R /work/VMs-ISOs
sudo chown sercangezer:sercangezer -R /work/VMs-ISOs

# SSHFS ile bağlayalım
sshfs -o default_permissions sercangezer@192.168.1.187:/VMs-ISOs /work/VMs-ISOs
```

* Size şifre sorabilir ilk kez bağlanıyorsanız, ardından `df -hT` ile bağlandığını görebiliriz.

```bash
sercangezer@|192.168.1.31|:/home/sercangezer $> df -hT
Filesystem                          Type        Size  Used Avail Use% Mounted on
.
.
sercangezer@192.168.1.187:/VMs-ISOs fuse.sshfs  953G  724G  226G  77% /work/VMs-ISOs
```

* Kalıcı olarak bağlamak istiyorsanız `/etc/fstab` dosyasına yazmamız gerekiyor. (Bunu pek önermiyorum.)

```bash
sercangezer@|192.168.1.31|:/home/sercangezer $> cat /etc/fstab
.
.
sercangezer@192.168.1.187:~/ /work/VMs-ISOs fuse.sshfs noauto,x-systemd.automount,_netdev,reconnect,identityfile=/home/sercangezer/.ssh/id_rsa,allow_other,default_permissions 0 0

```

Artık klasörlere ve dosyalara direkt dosya yöneticisi üzerinden kendi bilgisayarınızdaymış gibi erişebilirsiniz. Tek komutla basit bir çözüm..

Esen kalın ...

