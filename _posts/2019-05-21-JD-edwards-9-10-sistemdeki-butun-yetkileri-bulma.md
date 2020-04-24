---
layout      : post
title       : "JD Edwards 9.10 sistemdeki bütün yetkileri(role) bulma"
description : "JDE üzerinde tanımlanan bütün yetkileri bulmak"
tags        : [JD Edwards EnterpriseOne, SQL]
---

JD Edwards 9.10 sürümünde sistemde tanımlanmış bütün yetkiler(role) `F0093` tablosunda tutmaktadır(_SY910.F0093_). 

Aşağıdaki sql kodu yardımıyla belirlediğimiz sistemdeki tanımlanmış yetkileri alfabetik olarak çıktısını alabilirsiniz.

```sql
SELECT DISTINCT LLUSER FROM SY910.F0093 
ORDER BY LLUSER
```


