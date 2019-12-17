---
layout      : post
updated     : "2019-05-21@12:24"
author      : "Sercan GEZER"
email       : "sercangezer.tr@gmail.com"
title       : "JD Edwards 9.10 sistemdeki bütün yetkileri(role) bulma"
description : "Oracle JD Edwards 9.10 da sistemde tanımlanan bütün yetkileri(role) bulmak için kullanılan sql komutu"
tags        : [JDE, Oracle SQL, JD-Edwards, SQL]
---

JD Edwards 9.10 sürümünde sistemde tanımlanmış bütün yetkiler(role) `F0093` tablosunda tutmaktadır(_SY910.F0093_). 

Aşağıdaki sql kodu yardımıyla belirlediğimiz sistemdeki tanımlanmış yetkileri alfabetik olarak çıktısını alabilirsiniz.

```sql
SELECT DISTINCT LLUSER FROM SY910.F0093 
ORDER BY LLUSER
```


