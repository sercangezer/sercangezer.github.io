---
title: Failed to load SeLinux policy, Freezing hatası ve çözümü
excerpt: Redhat based dağıtımlarda Failed to load SeLinux policy, Freezing hatası ve çözümü

date: 2023-02-08
last_modified_at: 2023-02-08

categories:
  - Linux
  - Linux Sorun Giderme (Troubleshooting)
tags: 
  - [Linux,Redhat based,SELinux,Policy,Freezing,Kernel,Centos 7,SELinux disable]

toc: true
toc_sticky: true
---

Esenlikler,

Centos 7 kurulu sanal makinemi yeniden başlattığımda uzun bir süre bekledikten sonra açılmadığını fark ettim. Konsol a geçtiğim zaman `Failed to load SELinux policy, Freezing.` hatası alıp kesildiğini gördüm.

![](https://raw.githubusercontent.com/sercangezer/sercangezer.github.io/main/images/2023/20230208-Centos7-failed-to-load-selinux-policy-freezing01.png)

Biraz araştırmadan sonra SELinux tarafından kaynaklandığı yönünde bir çıkarımım oldu. Neyse ki daha önce başka kişilerin başına gelmiş bu sorun.

# Çözüm

* Sistemimizi yeniden başlatıyoruz.
* Kernel listesine geldiğimiz zaman `e` harfine basıyoruz.

![](https://raw.githubusercontent.com/sercangezer/sercangezer.github.io/main/images/2023/20230208-Centos7-failed-to-load-selinux-policy-freezing-kernel-list.png)

* Açılan editör ekranında işaretli yere `selinux=0` ibaresini ekliyoruz.

![](https://raw.githubusercontent.com/sercangezer/sercangezer.github.io/main/images/2023/20230208-Centos7-failed-to-load-selinux-policy-freezing-selinux-0.png)

* Daha sonra `CTRL + X` ile değişikliği uyguluyoruz ve sistemimiz yeniden başlıyor.

❗❗ Yukarıda yaptığımız değişiklik sistemimizi yeniden başlattığımız zaman siliniyor. Bu sebeple SELinux'ü disable a çekmemiz gerekiyor.

* Aşağıdaki kod ile SELinux direkt olarak disable edebiliriz.

```bash
sudo sed -i s/^SELINUX=.*$/SELINUX=disabled/ /etc/selinux/config
```

* Değişikliğin uygulanması için sistemimizi yeniden başlatmalıyız.

```bash
sudo reboot now
```

Saygılarımla,
Sağlıklı günler dilerim.