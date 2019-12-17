---
layout      : post
updated     : "2019-05-21@12:23"
author      : "Sercan GEZER"
email       : "sercangezer.tr@gmail.com"
title       : "/bin/tar: Argument list too long hatası"
description : "Linux ortamında sayıca çok fazla olan dosyaları arşivlemeye çalıştığımızda aldığımız hata"
tags        : [Linux, Bash, tar, arşivleme]
---

Linux dağıtımlarında genelde sıkıştırmaya çalıştırdığımız klasörün içinde 30.000'den fazla dosya bulunuyorsa `\bin\tar: Argument list too long` uyarısı ile karşılaşıyoruz. `Find` komutu kullanarak arşivleme işlemini başarıyla gerçekleştiriyoruz.

```bash
#Klasörün içindeki dosya adlarını bir dosyaya yazdırıyoruz.
find . -iname "*.txt" -print > /tmp/dosya-adlari

# tar komutuna sıkıştıracağı dosyaların adlarını gönderiyoruz --files-from parametresi ile
tar -cvzf  sikistirilanlar.tar.gz --files-from /tmp/dosya-adlari
```

