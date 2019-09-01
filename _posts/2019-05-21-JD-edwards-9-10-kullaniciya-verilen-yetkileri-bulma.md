---
layout: post
title: JD Edwards 9.10 kullanıcıya verilen yetkileri(role) bulma
description: "Oracle JD Edwards 9.10 da kullanıcıya verilen yetkileri(role) bulmak için kullanılan sql komutu"
author: Sercan GEZER
category: JD Edwards
tags: JDE Oracle SQL JD-Edwards
finished: true
---

JD Edwards 9.10 sürümünde kullanıcıya atanmış yetkileri(role) `F95921` tablosunda tutmaktadır(_SY910.F95921_). 

Aşağıdaki sql kodu yardımıyla belirlediğimiz kullanıcına atadığımız yetkiyi çıktı olarak alabiliriz.

```sql
SELECT RLFRROLE FROM SY910.F95921 
WHERE RLTOROLE='SGEZER'
```

`SGEZER` olan kısmı bulmak istediğiniz kullanıcının adı ile değiştirmeniz gerekmektedir.

