---
layout: post
title: SKOPEO ile Konteynır İmaj ve Repo Yönetimi
description: SKOPEO ile Konteynır İmaj ve Repo Yönetimi
summary:  SKOPEO ile Konteynır İmaj ve Repo Yönetimi
tags: 
  - Kubernetes
  - Nexus Repository
  - Skopeo
minute: 1
---



![](../images/2023/20231127-skopeo-ile-konteynir-repo-ve-imajlari-yonetme.png)

Esenlikler,

# SKOPEO

[`Skopeo`](https://github.com/containers/skopeo),  root hakkı gerektirmeden ve bir daemon’a ihtiyaç duymadan container image’larınızı bir repository’den başka bir repository’e taşımanızı sağlayan bir araç.


{% include admonition.html type="note" title="Örnek" body="<b>📌 NEXUS ADRESİMİZ: nexus.sercangezer.com.tr:30990</b>" %}


* `skopeo` yüklenmesi [_(Diğer Dağıtımlar için kurulum rehberi)_](https://github.com/containers/skopeo/blob/main/install.md)

```bash
sudo apt-get update
sudo apt-get -y install skopeo
```

* Private Nexus repomuza login olma söz dizimi

```bash
$ skopeo login --tls-verify=false -u admin -p admin nexus.sercangezer.com.tr:30990
```

* Bir imajı indirmeden direkt olarak repodan repoya yükleme
  *  quay.io --> nexus.sercangezer.com.tr

```bash
skopeo copy docker://quay.io/skopeo/stable:latest docker://nexus.sercangezer.com.tr:30990/sg-docker-internal/skopeo:latest --dest-tls-verify=false --dest-creds admin:admin
```

* Bir imajı direkt olarak tar olarak almak

```bash
skopeo copy docker://busybox:1.35.0 docker-archive:busybox-1_3_5.tar:busybox:1.35.0
```

* Bir imajın özelliklerini görebilmek için

```bash
skopeo inspect --tls-verify=false  docker://nexus.sercangezer.com.tr:30990/sg-docker-internal/skopeo
```

* Bir imajın direkt olarak version tag larını listeler

```bash
skopeo list-tags --tls-verify=false docker://nexus.sercangezer.com.tr:30990/sg-docker-internal/skopeo
``` 

* Bir imajın bütün versiyonlarını local (bilgisayar) klasöre çekme

```bash
skopeo sync --src docker --dest dir nexus.sercangezer.com.tr:30990/sg-docker-internal/busybox /home/scope/repo-sync --src-tls-verify=false
```

* Daha önce indirilmiş local (bilgisayar) klasörde bulunan imajları repoya aktarma

```bash
skopeo sync --src dir --dest docker /home/scope/repo-sync nexus.sercangezer.com.tr:30990/sg-docker-internal/ --dest-tls-verify=false --dest-creds admin:admin
```

* Komple repo adı da dahil olarak imajları çeker

```bash
skopeo sync --src docker --dest dir --scoped nexus.sercangezer.com.tr:30990/sg-docker-internal/busybox /home/scope/repo-scopeed --src-tls-verify=false
```

```bash
k8s-master::sysAdmin::~/repo-scopeed::
$ tree .
.
└── nexus.sercangezer.com.tr:30990
    └── sg-docker-internal
        ├── busybox:1.34.0
        │   ├── 35dacafcdad5b63e0de9524c4be6bf7af78a493318b489840965b955ee4d7e60
        │   ├── 8336f9f1d0946781f428a155536995f0d8a31209d65997e2a379a23e7a441b78
        │   ├── manifest.json
        │   └── version
        ├── busybox:1.35.0
        │   ├── 48af2784ec85ce2b8194c39b667bad46c5aac55704236a98777fe9c5bb98d241
        │   ├── db2e1e3b46c0af1ae524f68073dccd02b5b10a0388a7b3a3f1617ee996376c34
        │   ├── manifest.json
        │   └── version
        ├── busybox:1.36.0
        │   ├── a58ecd4f0c864650a4286c3c2d49c7219a3f2fc8d7a0bf478aa9834acfe14ae7
        │   ├── af2c3e96bcf1a80da1d9b57ec0adc29f73f773a4a115344b7e06aec982157a33
        │   ├── manifest.json
        │   └── version
        └── busybox:latest
            ├── 3f4d90098f5b5a6f6a76e9d217da85aa39b2081e30fa1f7d287138d6e7bf0ad7
            ├── a416a98b71e224a31ee99cff8e16063554498227d2b696152a9c3e0aa65e5824
            ├── manifest.json
            └── version

6 directories, 16 files

```

Esen kalın ...