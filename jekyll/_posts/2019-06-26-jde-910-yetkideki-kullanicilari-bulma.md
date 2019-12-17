---
layout      : post
updated     : "2019-05-21@12:23"
author      : "Sercan GEZER"
email       : "sercangezer.tr@gmail.com"
title       : "JD Edwards 9.10 yetkideki kullanıcıları bulma"
description : "JD Edwards 9.10 sistemdeki bir yetkinin hangi kullanıcılara verildiğini bulmamızı sağlayan SQL"
tags        : [JDE, Oracle SQL, JD-Edwards, SQL, Veritabanı, Database]
---

Sistem üzerindeki yetki bilgileri **F95921** tablosu içerisinde tutulmaktadır.

Tablonun içeriğine göz atmak için;

```sql
SELECT * FROM SY910.F95921
```
Bize gerekli olan sütunlar;

* **RLFRROLE** : Sistemdeki rolün kodu
* **RLTOROLE** : Sistemdeki kullanıcının adı

```sql
SELECT RLFRROLE as "ROL", RLTOROLE as "JDE KULLANICI ADI"  FROM SY910.F95921  
WHERE RLFRROLE = '28MCU'
ORDER BY RLTOROLE ASC
```
> **28MCU** rolünde bulunan kullanıcıların hangilerini olduğunu alfabetik olarak sırala