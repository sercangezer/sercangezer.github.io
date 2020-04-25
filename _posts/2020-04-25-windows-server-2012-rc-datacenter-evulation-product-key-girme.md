---
layout      : post
title       : "Windows Server 2012 R2 Datacenter aktif etme"
description : "Windows Server 2012 R2 Evulation sürümünü aktif etme"
tags        : [Windows Server]
---

# Sorun

`Windows Server 2012 R2 Datacenter` sürümünü Microsoft'un resmi sitesinden indirip bir sanal makine oluşturdum. Lisans anahtarımız olmasına rağmen bir türlü `Evulation` sürümünde ürün anahtarını kaydettiremedim. 

# Çözüm

* Sunucumuza bağlanıp, komut satırını yönetici olarak çalıştırıyoruz.
* Komut satırında güncel olan windows sürümünü görüntülemek için;

```powershell
dism /online /get-currentedition
```

* Komut satırında geçebileceğimiz sürümü görüntülemek için;

```powershell
dism /online /get-targetedition
```

* Sahip olduğumuz ürün anahtarını aktif etmek için;

```powershell
dism /online /Set-Edition:ServerDataCenter /ProductKey:XXXX-XXXX-XXXX-XXXX-XXXX /AcceptEula
```

* `XXXX-XXXX-XXXX-XXXX-XXXX` belirtilen kısma kendi ürün anahtarımızı girerek komutu çalıştırıyoruz. Tamamlandığında `Y` diyerek sistemimiz yeniden başlıyor. Açıldığında artık full sürüm olarak devam ediyoruz.([Kaynak](https://blog.citrix24.com/upgrade-windows-2012-r2-evaluation-full-version/))