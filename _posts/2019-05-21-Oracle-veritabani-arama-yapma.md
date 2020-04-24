---
layout      : post
title       : "Oracle veritabanında arama yapmak"
description : "Oracle 12c veritabanında tablo ve kolon arama"
tags        : [Oracle DB, SQL]
---



Oracle 12c veritabanında aşağıdaki sorguyu kullanarak tablo ve kolonun veritabanını, tablo adını ve kolonunu bulabiliriz.

* owner: Bulunduğu veritabanı
* table_name: Tablo adı
* column_name: Kolon adı


> Adı "ENG_DSC2" olan kolonun hangi veritabanı ve tabloda olduğunu gösteren sorgu

```sql
SELECT owner, table_name, column_name
FROM dba_tab_columns
WHERE column_name LIKE '%ENG_DSC2%';
```

> Adı "F0093" olan tablonun hangi veritabanında olduğunu gösteren sorgu

```sql
SELECT owner, table_name
FROM dba_tab_columns
WHERE table_name LIKE '%F0093%';
```