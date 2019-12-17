---
layout      : post
updated     : "2019-05-21@12:27"
author      : "Sercan GEZER"
email       : "sercangezer.tr@gmail.com"
title       : "JD Edwards 9.10 yetki(role) ve kullanıcı sayıları"
description : "Oracle JD Edwards 9.10 da sistemde tanımladığınız yetki(role) ve o yetkiler(role) verilmiş kullanıcı sayıları"
tags        : [JDE, Oracle SQL, JD-Edwards, SQL, Veritabanı, Database]
---



`F95921` ve `F0093` tablosu birleştirerek, yetki adları ve o yetkiye atanan kullanıcı sayılarını liste halinde alabiliriz.

> Aşağıdaki kod sadece en az 1 kullanıcı atanmış yetkileri listeler.

```sql
SELECT DISTINCT (RLFRROLE) AS "Yetki (Role)",
                Count (DISTINCT RLTOROLE) AS "Kullanici Sayisi" 
FROM   SY910.F95921
WHERE  RLFRROLE IN (SELECT DISTINCT LLUSER
                    FROM   SY910.F0093)
GROUP  BY RLFRROLE
ORDER  BY RLFRROLE 
```
