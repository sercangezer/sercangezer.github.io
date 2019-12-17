---
layout      : post
updated     : "2019-06-01@12:23"
author      : "Sercan GEZER"
email       : "sercangezer.tr@gmail.com"
title       : "Windows server üzerinde istatistik alma"
description : "Windows server üzerinde çalıştığı andan beri bazı istatistikleri almamızı sağlayan net stats komutu"
tags        : [Windows Server]
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

