---
layout: post
title: Windows server üzerinde istatistik alma
description: "Windows server üzerinde çalıştığı andan beri bazı istatistikleri almamızı sağlayan net stats komutu"
author: Sercan GEZER
category: Windows Server
tags: Windows-Server
finished: true
---

# Sorun

Windows sunucularımızda belli bir sebep yüzünden raporlar hataya düşmeye başlamıştı. İlk olarak aklımıza sunucumuzun internet bağlantısında kopmalarından dolayı olduğunu düşündük. `Ping` komutu pek işimizi görmedi açıkcası..

# Çözüm

Bunun için **net** komutu parametreleriyle birlikte işimizi rahatlıkla gördü..

```bash
net stats server
```

```bash
net stats workstations
```
![net stats](http://sercangezer.github.io/images/net-stats.png)

