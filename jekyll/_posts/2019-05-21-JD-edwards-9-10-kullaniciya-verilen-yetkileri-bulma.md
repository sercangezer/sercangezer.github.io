---
layout      : post
updated     : "2019-05-21@12:23"
author      : "Sercan GEZER"
email       : "sercangezer.tr@gmail.com"
title       : "JD Edwards 9.10 kullanıcıya verilen yetkileri(role) bulma"
description : "Oracle JD Edwards 9.10 da kullanıcıya verilen yetkileri(role) bulmak için kullanılan sql komutu"
tags        : [JDE, Oracle SQL, JD-Edwards, SQL]
---

JD Edwards 9.10 sürümünde kullanıcıya atanmış yetkileri(role) `F95921` tablosunda tutmaktadır(_SY910.F95921_). 

Aşağıdaki sql kodu yardımıyla belirlediğimiz kullanıcına atadığımız yetkiyi çıktı olarak alabiliriz.

```sql
SELECT RLFRROLE FROM SY910.F95921 
WHERE RLTOROLE='SGEZER'
```

`SGEZER` olan kısmı bulmak istediğiniz kullanıcının adı ile değiştirmeniz gerekmektedir.

