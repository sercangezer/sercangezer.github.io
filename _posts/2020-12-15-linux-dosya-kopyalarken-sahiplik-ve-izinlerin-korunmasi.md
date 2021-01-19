---
layout: post
title: "Dosya kopyalarken sahiplik ve izinlerin korunması"
comments: true
description: "Linux ortamında cp komutu ile dosya kopyalarken sahiplik ve izinlerin korunması"
keywords: "linux, bash, cp, ownership, mode, preserve"
---

Esenlikler,

Linux ortamında bir dosya kopyaladığımız zaman; hedef klasörde aktif kullanıcıya ait **izinler (mode, permissions), sahiplik (ownership)** ve **tarih damgası(timestamp)** bilgilerini kullanarak dosyayı oluşturur.

#### Örnek: 
Aşağıdaki `linux` kullanıcısına ait `örnek02.txt` dosyası mevcuttur.
```bash
[oracle@sercangezer-ol7 ]$ ll
-rwxrwxrwx. 1 linux  linux  0 Dec 15 13:23 ornek02.txt
```
`ornek02.txt` dosyasını `oracle` kullanıcısı ile parametresiz olarak `kopya02.txt` olarak kopyalıyoruz.
```bash
[oracle@sercangezer-ol7 ]$ cp ornek02.txt kopya02.txt
[oracle@sercangezer-ol7 ]$ ll #dosya listeleme
-rwxrwxr-x. 1 oracle oracle 0 Dec 15 13:48 kopya02.txt
-rwxrwxrwx. 1 linux  linux  0 Dec 15 13:23 ornek02.txt
```
Görüldüğü gibi `kopya02.txt` dosyasının sahibi **oracle**, izinleri **-rwxrwxr-x**  ve tarih damgası değişti.

<div class="divider"></div>

Bunun önüne geçebilmek için; **`cp --preserve`** ile birlikte kullanıyoruz.

> `cp --preserve` komutunu kullanabilmemiz aktif kullanıcımızda  **root** yetkisi olması gerekmektedir.

```bash
--preserve[=mode, ownership, timestamp]
# varsayılan olarak mode,ownership,timestamp argümanlarını alıyor.
```
#### Kullanımı:

İlk hali;
```bash
[oracle@sercangezer-ol7]$ ll
-rwxrwxrwx. 1 linux linux 0 Dec 15 13:23 ornek02.txt
```

izinlerini koruyarak (_--preserve=mode_);
```bash
[oracle@sercangezer-ol7 ]$ sudo cp --preserve=mode ornek02.txt ornek02_mode.txt
[oracle@sercangezer-ol7 ]$ ll
-rwxrwxrwx. 1 root  root  0 Dec 15 14:47 ornek02_mode.txt
-rwxrwxrwx. 1 linux linux 0 Dec 15 13:23 ornek02.txt
```

sahipliğini koruyarak (_--preserve=ownership_);
```bash
[oracle@sercangezer-ol7 ]$ sudo cp --preserve=ownership ornek02.txt ornek02_ownership.txt
[oracle@sercangezer-ol7 ]$ ll
-rwxrwxrwx. 1 linux linux 0 Dec 15 14:49 ornek02_ownership.txt
-rwxrwxrwx. 1 linux linux 0 Dec 15 13:23 ornek02.txt
```

tarih damgasını korayarak (_--preserve=timestamp_);
```bash
[oracle@sercangezer-ol7 ]$ sudo cp --preserve=timestamp ornek02.txt ornek02_mode.txt
[oracle@sercangezer-ol7 ]$ ll
-rwxr-xr-x. 1 root  root  0 Dec 15 13:23 ornek02_timestamp.txt
-rwxrwxrwx. 1 linux linux 0 Dec 15 13:23 ornek02.txt

```

dilerseniz birden fazla argümanda girebiliyoruz. Tarih damgasını ve kullanıcısını koruyarak kopyalayalım. (_--preserve=ownership,timestamp_)
```bash
[oracle@sercangezer-ol7 ]$ sudo cp --preserve=ownership,timestamp ornek02.txt ornek02_timestamp_ownership.txt
[oracle@sercangezer-ol7 ]$ ll
-rwxrwxrwx. 1 linux linux 0 Dec 15 13:23 ornek02_timestamp_ownership.txt
-rwxrwxrwx. 1 linux linux 0 Dec 15 13:23 ornek02.txt
```

<!--
<div class="video-container"><iframe src="#" frameborder="0" allowfullscreen></iframe>
</div>
-->

Saygılarımla,<br/>
Sağlıklı günler dilerim.