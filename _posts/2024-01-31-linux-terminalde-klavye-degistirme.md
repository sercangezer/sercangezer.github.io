---
layout: post
title: Linux terminalden klavye dili değiştirme
description: Linux ortamlarda setxkbmap ve localectl ile klavye dil değiştirme
summary: Linux ortamlarda setxkbmap ve localectl ile klavye dil değiştirme
tags: 
  - setxkbmap
  - localectl
  - Linux
  - "Klavye dili"
minute: 1
---

Esenlikler,

Bir sunucuya SSH attınız ve ya vCenter üzerinden konsol ile sunucuya eriştiğiniz. Hoop klavye dili `İngilizce` ..

Neyse ki çözümü basit.

* Eğer bir kullanıcı arayüzü(X11,GNOME,KDE vs ) varsa;

```bash
setxkbmap tr
``` 

* Minimal tarzda kurulmuşsa;

```bash
localectl set-keymap tr
```


Esen kalın ...