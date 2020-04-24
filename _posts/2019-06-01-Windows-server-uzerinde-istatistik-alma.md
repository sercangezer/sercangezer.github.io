---
layout      : post
title       : "Windows server üzerinde istatistik alma"
description : "Windows server üzerinde ağ bazlı istatistikleri almamızı sağlayan komut"
tags        : [Windows Server, Powershell]
---


# Sorun
Windows sunucularımızda belli bir sebep yüzünden raporlar hataya düşmeye başlamıştı. İlk olarak aklımıza sunucumuzun internet bağlantısında kopmalarından dolayı olduğunu düşündük. `Ping` komutu pek işimizi görmedi açıkcası..

# Çözüm

Bunun için **net** komutu parametreleriyle birlikte işimizi rahatlıkla gördü..

```powershell
net stats server
```

```powershell
net stats workstations
```

