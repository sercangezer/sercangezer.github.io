---
layout: post
title: Nexus Repository programatik olarak dosya yükleme
description: Shell script içerisinde Nexus Repository dosya upload etme
summary:  Nexus Repository curl ile dosya yükleme
tags: 
  - Linux
  - Nexus OSS Repository
minute: 1
---

Esenlikler,

Shell Script içerisinde programatik olarak curl ile Nexus repolarına dosya yükleyebiliyoruz.

```bash
# Değişkenleri tanımlıyoruz.
export _NEXUS_REGISTRY_USER=admin
export _NEXUS_REGISTRY_PASSWORD=admin
export _NEXUS_GENERAL_REPOSITORY_URL=https://nexus.sercangezer.com.tr

# Komutun söz dizimi
curl -k -v -u <NEXUS_KULLANICI_ADI>:<NEXUS_KULLANICI_PAROLASI> --upload-file <YÜKLENECEK_DOSYANIN_FULL_PATHI> <NEXUS_REPOSITORY_URL>/<YUKLENECEK_DOSYA_ADI>

# curl ile gönderiyoruz.
curl -k -v -u $_NEXUS_REGISTRY_USER:$_NEXUS_REGISTRY_PASSWORD --upload-file /nfs-server/sg-setup.tar.gz $_NEXUS_GENERAL_REPOSITORY_URL/repository/sg-raw-files/sg-setup/sg-setup.tar.gz
```
