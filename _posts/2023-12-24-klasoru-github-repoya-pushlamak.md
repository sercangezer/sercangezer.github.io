---
layout: post
title: Belirtilen klasörü Github repoya yeni bir branch olarak göndermek
description: Herhangi bir klasörü github repoya yeni bir branch olarak pushlamak
summary: Bir klasörü github repoya pushlamak
tags: 
  - Github API
  - Github
  - Github Repo
  - Bash Script
minute: 1
---

Esenlikler,

Farklı projelerde ve farklı makinelerde kod ve konfigürasyon senkronizasyonu sağlamak adına github ve branch yapısını kullanıyorum. Elle teker teker github komutları girmektense bunu bash script e çevirdim. Belki benim gibi sizin de ihtiyacı olabilir.

#### Gereklilikler

* Reponuz için okuma-yazma izni verilmiş SSH-KEY
* `sudo` yetkisi olan bir kullanıcı
* Script içerisindeki değişkenlerin tanımlanması

```bash
#!/bin/bash

# +-------------------------------------------------------------------+
# | Author: Sercan GEZER                                              |
# | Email: sercan.gezer.TR@gmail.com                                  |
# +-------------------------------------------------------------------+
#

if (( $EUID != 0 )); then
    echo -e "\n Lütfen SUDO komutu ile scripti tekrar çalıştırın !!\n"
    exit
fi

# Push lanacak klasör
PUSHED_FOLDER="/home/sercangezer/ornek-klasor"
# Push lanacak github reposu
GITHUB_REPO="git@github.com:sercangezer/sercangezer-workspace.git"
# Push lanacak branch adı
BRANCH_NAME="sercangezer-newbranch"
# Push commit mesajı
COMMIT_MESSAGE="Bu klasör scriptle push lanmıştır."
# SSH Anahtarını Tanımla
SSH_KEY="-----BEGIN OPENSSH PRIVATE KEY-----
.
.
.
.
-----END OPENSSH PRIVATE KEY-----
"

# Klasörde 100 MB'dan büyük dosyaları kontrol et
BIG_FILES=$(find $PUSHED_FOLDER -type f -size +100M)

if [ -n "$BIG_FILES" ]; then
	echo "Uyarı: FREE GITHUB 100MB'dan büyük dosya kabul etmiyor."
    echo "Uyarı: Aşağıdaki dosyalar 100 MB'dan büyük:"
    echo "$BIG_FILES"
    exit 1
fi

# Git kullanıcı adı ve e-posta adresini kontrol et
GIT_USER_EMAIL=$(git config --global user.email)
GIT_USER_NAME=$(git config --global user.name)

if [ -z "$GIT_USER_EMAIL" ] || [ -z "$GIT_USER_NAME" ]; then
    echo "Hata: Git kullanıcı adı ve/veya e-posta adresi ayarlanmamış."
    echo "Hata: git config --global user.email 'example@example.org' ile atayabilirsin."
    echo "Hata: git config --global user.name 'ISIMSIZ' ile atayabilirsin."
    exit 1
fi

# Geçici bir dizinde SSH anahtarını sakla
SSH_DIR=$(mktemp -d)
echo "$SSH_KEY" > "$SSH_DIR/ssh_key"
chmod 600 "$SSH_DIR/ssh_key"

# SSH Anahtarını kullanarak bağlanmak için Git ve SSH ayarlarını yap
export GIT_SSH_COMMAND="ssh -i $SSH_DIR/ssh_key -o IdentitiesOnly=yes"

# Git reposuna git
cd $PUSHED_FOLDER
sudo rm -rf .git

# Yerel git deposunu başlat
git init

# Uzak depoyu ekle
git remote add origin $GITHUB_REPO

# Yeni bir branch oluştur ve değişiklikleri ekle
git checkout -b $BRANCH_NAME
git add .

# Commit yap ve push et
git commit -m "$COMMIT_MESSAGE"
git push -u origin $BRANCH_NAME

# SSH Anahtarını ve geçici dizini temizle
sudo rm -rf .git
rm -rf "$SSH_DIR"
```

* çalıştırmak için;

```bash
sudo bash script-name.sh
```

Esen kalın ...