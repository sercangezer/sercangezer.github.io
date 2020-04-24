---
layout      : post
title       : "/bin/tar: Argument list too long hatası"
description : "/bin/tar: Argument list too long hatası ve alternatif çözümü"
tags        : Linux Bash TAR
---

Linux dağıtımlarında genelde sıkıştırmaya çalıştırdığımız klasörün içinde 30.000'den fazla dosya bulunuyorsa `\bin\tar: Argument list too long` uyarısı ile karşılaşıyoruz. `Find` komutu kullanarak arşivleme işlemini başarıyla gerçekleştiriyoruz.

```bash
#Klasörün içindeki dosya adlarını bir dosyaya yazdırıyoruz.
find . -iname "*.txt" -print > /tmp/dosya-adlari

# tar komutuna sıkıştıracağı dosyaların adlarını gönderiyoruz --files-from parametresi ile
tar -cvzf  sikistirilanlar.tar.gz --files-from /tmp/dosya-adlari
```

