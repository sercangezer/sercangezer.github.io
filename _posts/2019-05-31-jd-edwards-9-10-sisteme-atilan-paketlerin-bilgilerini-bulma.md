---
layout      : post
title       : "JDE 910 sisteme atılan paket bilgilerini bulma"
description : "JDE'de full package ve update package bilgilerini bulma"
tags        : [JD Edwards EnterpriseOne, SQL]
---

# Sorun
Sistem yöneticisinden izinsiz olarak canlı (production) ortama atılan paketin sorumlusunu bulmak.

# Çözüm

JD Edwards 9.10 sürümünde **build edilmiş bütün paketler**e ait bilgi **F98826** tablosunda tutulmaktadır. [_F98826 Tablo bilgileri_](http://www.jdetables.com/?schema=910&system=H96B&table=F98826
)

Tek yapmamız gereken tablo içinde işimize yarayacak şekilde filtrelemek.


```sql
-- Tablodaki bütün verileri çekmek için
SELECT * FROM SY910.F98826

-- Lazım olan columns
UPJDEPKGNM - Package Name - Paket Adı
UPPATHCD - Code - Path - Ortam kodu (Production için PD910, Test için PY910 gibi)
UPJOBN	- Work Station ID - Paket atım işlemini yapan bilgisayar
UPUSER	- User ID - Paket atım işlemini yapan kullanıcı
UPDEPLDATE	-Effective Date	 - Atılma tarihi (Julian Date olarak)
UPDEPLTIME	- Effective Time - Atılma saati (22:11:33 = 221133 şeklinde)

-- Sisteme bütün paket atanlar sondan başa sıralı olarak
SELECT UPDEPLDATE, UPDEPLTIME, UPJDEPKGNM, UPPATHCD, UPUSER, UPJOBN FROM SY910.F98826 
ORDER BY UPDEPLDATE desc, UPDEPLTIME desc

-- Canlı ortamda(PD910) SGEZER kullanıcısı dışında paket atanlar 
-- NOT: jde_to_tarih, şirketimizdeki yazılımcılar tarafından geliştirilmiş bir fonksiyon. Burada size julian date formatında çıktı verecektir.
SELECT jde_to_tarih(UPDEPLDATE), UPDEPLTIME, UPJDEPKGNM, UPPATHCD, UPUSER, UPJOBN FROM SY910.F98826 
where UPUSER <>'SGEZER' AND UPPATHCD ='PD910'
ORDER BY UPDEPLDATE desc, UPDEPLTIME desc 
```












