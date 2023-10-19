---
layout: post
title: Linux ortamlarda rbenv ile farklı ruby versiyonları kullanma
description: Linux ortamlarda rbenv ile farklı ruby versiyonları kullanma
summary:  Linux ortamlarda rbenv ile farklı ruby versiyonları kullanma
tags: 
  - Linux
  - Ruby
  - rbenv
  - Jekyll
minute: 1
---

![](../images/2023/20231017-linux-rbenv-kurulum-ve-konfigurasyon.png)

Esenlikler,

Bu blogu [`Jekyll`](https://jekyllrb.com/) ile [`github-pages`](https://pages.github.com/) üzerinden host ediyorum. Bir modül denemek için ruby nin farklı bir versiyonu yüklü olması gerekiyormuş. Komple ruby silip o versiyonu yüklemek yerine [`rbenv`](https://github.com/rbenv/rbenv) ile herhangi bir şey silmeden istediğimiz ruby versiyonu yükleyip, onu kullanabiliyoruz.

Ben Linux dağıtımı olan RedHat tabanlı Fedora 38 üzerinde bu kurulumu gerçekleştireceğim.

* `rbenv` yazılımı yükleyelim.

```bash
sudo dnf install rbenv -y
```

* `rbenv` konfigürasyonları direkt alabilmek için `~/.bashrc` dosyamıza PATH giriyoruz.

```bash
# .bashrc dosyamızı açıyoruz.
vi ~/.bashrc

# En altına aşağıdaki konfigürasyonu ekleyip, :wq ile kaydediyoruz.
export PATH="$HOME/.rbenv/shims:$PATH"
eval "$(rbenv init -)"

# Ayarların aktif ediyoruz.
source ~/.bashrc
```

* Kurabileceğimiz sürümleri görüntüleyelim.

```bash
# Kurabileceğimiz stabil ruby sürümleri
rbenv install -l

# Kurabileceğimiz ruby sürümleri
rbenv install -L
```

* `2.6.10` sürümünü kurmak istiyorum.

```bash
# Ruby 2.6.10 versiyonunu kuralım
rbenv install 2.6.10
```

* Sistemimizdeki versiyonları listelediğimizde artık `2.6.10` ruby versiyonunu da görebileceğiz.

```bash
rbenv install 2.6.10

# Çıktısı
* system (set by /home/sercangezer/.rbenv/version)
  2.6.10
  2.7.5
```

* Artık sistemimizdeki ruby versiyonunu 2.6.10 olarak değiştirelim.

  * Önce versiyonumuzu bir kontrol edelim.

  ```bash
  ruby --version

  #Çıktısı
  ruby 3.2.2 (2023-03-30 revision e51014f9c0) [x86_64-linux]
  ```

```bash
# Ruby versiyonunu 2.6.10 a çekme
rbenv global 2.6.10
```

* Versiyonları kontrol edelim.


```bash
# Ruby versiyonu kontrol edelim.
ruby --version

# Çıktısı
ruby 2.6.10p210 (2022-04-12 revision 67958) [x86_64-linux]

# gem versiyonunu kontrol edelim.
gem env home

#Çıktısı
/home/sercangezer/.rbenv/versions/2.6.10/lib/ruby/gems/2.6.0
```

* Tekrar sistemde varsayılan olan sürüme dönmek için;

```bash
rbenv global system
rbenv local --unset
```

Esen kalın ...