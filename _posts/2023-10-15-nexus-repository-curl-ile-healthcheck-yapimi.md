---
layout: post
title: Nexus Repository curl ile healthcheck 
description: Shell script içerisinde Nexus Repository healthcheck
summary:  Nexus Repository curl ile healthcheck
tags: 
  - Linux
  - Nexus Repository
minute: 1
---

Esenlikler,

Shell Script içerisinde programatik olarak curl ile Nexus repository'nin healthcheck yapılmasını sağlayan komut dizisi.

```bash
$> curl -k  'https://nexus.sercangezer.com.tr/service/metrics/ping' -u admin:admin

#OUTPUT
pong
```

Basit bir döngüye alarak, Nexus repository çevrimiçi/online olmasını bekleyebiliriz.

```bash
_NEXUS_ONLINE=`curl -X 'GET' 'http://nexus.sercangezer.com.tr/service/metrics/ping' -u admin:admin`
while [ "$_NEXUS_ONLINE" != "pong" ]
do 
    echo -e "NEXUS  Repository daha online/çevrimiçi değil."
    sleep 10
done
```

❗ SSL/TLS kullanıyorsanız `curl -k` parametresini kullanmanız gerekiyor.
