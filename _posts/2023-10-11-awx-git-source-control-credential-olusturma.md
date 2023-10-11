---
layout: post
title: AWX'de Git (Source Control) Credential oluşturma
description: AWX'de Git (Source Control) Credential oluşturma
summary:  AWX'de Git (Source Control) Credential oluşturma
tags: 
  - AWX
  - Source Control
  - Ansible
  - GIT
  - AWX Credential Type
minute: 1
---

Esenlikler,

AWX üzerinde Projects lerde kullanacağımız git repoları için **source control** credential oluşturmamız gerekiyor.

O zaman aksiyona geçelim ...

* Öncelikle Github'a kaydedeceğimiz SSH Keyleri oluşturalım. Bunun için AWX çalışan makinemize bağlanıp, `ssh-keygen` ile private ve public key oluşturuyoruz.

  * `~/.ssh/awx_ssh: ` Bizim private key dosyamız.
  * `~/.ssh/awx_ssh.pub: ` Bizim public key dosyamız. 

```bash
ssh-keygen -t ed25519 -C "EMAIL_ADRESINIZ" -f ~/.ssh/awx_ssh
```

❗❗ `enter passphrase` kısmına gireceğiniz parolayı unutmayınız.!



```bash
ssh-keygen -t ed25519 -C "EMAIL_ADRESINIZ" -f ~/.ssh/awx_ssh

Generating public/private ed25519 key pair.
Enter passphrase (empty for no passphrase): #PAROLANIZ
Enter same passphrase again: #PAROLANIZ
Your identification has been saved in /home/sercangezer/.ssh/awx_ssh
Your public key has been saved in /home/sercangezer/.ssh/awx_ssh.pub
The key fingerprint is:
SHA256:4pCdp5z7bskijlJCYyFesMhJMjFnxkR7rQ6QOYM0804 EMAIL_ADRESINIZ
The key's randomart image is:
+--[ED25519 256]--+
|=@B              |
|OXBo .           |
|@++E. .          |
| Oo. + .         |
|o o.+ + S        |
|. .o + =         |
| o  . =. .       |
|.  .. ..+        |
| ......=o        |
+----[SHA256]-----+

```


* https://github.com/settings/keys adresinden `New SSH Key` diyerek ekrana gelen `TITLE` ve `KEY` kısmını doldurmamız gerekiyor.


* `TITLE: ` SSH-Key i betimleyecek kelimeler girebilirsiniz.
* `KEY: ` Yukarıdaki adımda oluşturduğumuz public keyi yapıştırıyoruz.


```bash
cat ~/.ssh/awx_ssh.pub

#ÇIKTIyı KEY kısmına yapıştırıyoruz ve KAYDEDIYORUZ.
```

* AWX Web UI > Resources > Credentials > Add diyerek yeni bir credential oluşturuyoruz.
  
  * Name
  * Description
  * Organization
  * Credentials Type: **Source Control** olarak seçiyoruz.

* **Source Control** seçtikten sonra yeni alanlar geliyor.
  * `SCM Private Key: ` kısmına **KEY imizi** (`cat ~/.ssh/awx_ssh`) çıktısını yapıştırıyoruz.
  * `Private Key Passphrase: ` ssh key oluştururken kullandığımız PAROLAyı giriyoruz.

* Artık Project altında Git repolarında SSH-Key bağlantınızı kullabilirsiniz.
