---
layout: post
title: "Docker container ile HOST üzerinde linux komutları çalıştırma"
description: "Docker container ile linux komutları çalıştırma"
summary: "Docker container ile linux komutları çalıştırma"
tags: 
  - docker
  - docker-compose
  - "docker compose"
minute: 1
---

Esenlikler,

Docker compose ile ayağa kaldırılan bir uygulamanın birkaç servisinin belli aralıklarla yeniden başlatmam gereken bir ihtiyaç ortaya çıktı. 

Bir Linux sever olarak direkt cron olarak bir job yazmaya yönelmek istesemde müşteri bunu compose içerisinden yönetilmesini istedi.

`command:` argümanlarını değiştirerek istediğiniz komutları çalıştırabilirsiniz. [^1]

```yaml
version: '3'
services:
  app:
    container_name: app
    image: nginx:alpine
    ports: ["80:80"]
    restart: unless-stopped

  restarter:
    container_name: restarter
    image: docker:cli
    volumes: ["/var/run/docker.sock:/var/run/docker.sock"]
    # direkt docker 
    command: ["/bin/sh", "-c", "while true; do sleep 10; echo $$(date +'%Y-%m-%d %H:%M') - app yeniden başlatıldı.; docker restart app; done"]
    # docker-compose içerisinde
    #command: ["/bin/sh", "-c", "while true; do sleep 10; echo $$(date +'%Y-%m-%d %H:%M') - app yeniden başlatıldı.; docker compose -p uygulamam restart app; done"]
    restart: unless-stopped
```

* Çıktısı

```bash
sercangezer@TTK|192.168.1.221|:/tmp $> docker logs restarter -f
2024-03-07 08:03 - app yeniden başlatıldı.
app
2024-03-07 08:04 - app yeniden başlatıldı.
app
2024-03-07 08:04 - app yeniden başlatıldı.
app
```

Esen kalın ...

[^1]: docker-compose.yaml ([https://gist.github.com/kizzx2/782b500a81ce46b889903b1f80353f21](https://gist.github.com/kizzx2/782b500a81ce46b889903b1f80353f21))