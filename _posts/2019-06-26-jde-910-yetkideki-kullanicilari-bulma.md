---
layout      : post
title       : "JD Edwards 9.10 yetkideki kullanıcıları bulma"
description : "JDE'de bir yetkinin hangi kullanıcılara verildiğini bulmamızı sağlayan SQL"
tags        : [JD Edwards EnterpriseOne, SQL]
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