---
layout      : post
title       : "JD Edwards 9.10 kullanıcıya verilen yetkileri(role) bulma"
description : "JDE'de kullanıcıya verilen role'leri bulmak "
tags        : [JD Edwards EnterpriseOne, SQL]
---

JD Edwards 9.10 sürümünde kullanıcıya atanmış yetkileri(role) `F95921` tablosunda tutmaktadır(_SY910.F95921_). 

Aşağıdaki sql kodu yardımıyla belirlediğimiz kullanıcına atadığımız yetkiyi çıktı olarak alabiliriz.

```sql
SELECT RLFRROLE FROM SY910.F95921 
WHERE RLTOROLE='SGEZER'
```

`SGEZER` olan kısmı bulmak istediğiniz kullanıcının adı ile değiştirmeniz gerekmektedir.

