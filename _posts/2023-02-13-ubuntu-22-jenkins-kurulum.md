---
title: Ubuntu 22.04 Jenkins kurulum
excerpt: Ubuntu 22.04 ortamında Jenkins servis olarak kurulumu

date: 2023-02-13
last_modified_at: 2023-02-13

categories:
  - DevOps
tags: 
  - [DevOps,Jenkins,CI/CD,Continious Integration, Continious Delevery]

toc: true
toc_sticky: true
---


Esenlikler,

DevOps alemininde açık kaynak olarak kullanılan en yaygın CI/CD araçlarından biri olan Jenkins'in Ubuntu 22.04 üzerinde **servis olarak** kurulumunu yapacağız.

# Gereklilikler

**Minimum donanımsal gereklilikler:**

* 256 MB Ram
* 10 GB Disk

**Tavsiye edilen donanımsal gereklilikler:**

* 4 GB+ RAM
* 50 GB+ Disk

**Diğer:**

* İnternet erişimi
* Sudo yetkisi olan bir kullanıcı


# Kurulum

## JDK kurulum

Jenkins in çalışabilmesi için sistemimizde javanın yüklü olması gerekiyor.

```bash
sudo apt update && sudo apt install openjdk-11-jre -y
```

Yüklendiğini kontrol etmek için;

```bash
java -version

#Çıktısı
openjdk version "11.0.12" 2021-07-20
OpenJDK Runtime Environment (build 11.0.12+7-post-Debian-2)
OpenJDK 64-Bit Server VM (build 11.0.12+7-post-Debian-2, mixed mode, sharing)
```

## JENKINS kurulum

* Öncelikle Jenkins'i indireceğimiz repoları sistemimize ekleyelim.

```bash
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
```
```bash
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
```

* Şimdi Jenkins'i yükleyelim.

```bash
sudo apt-get update && sudo apt-get install jenkins -y
```

```bash
sudo systemctl status jenkins

#Çıktı
sercan@gezer:~$ sudo systemctl status jenkins
● jenkins.service - Jenkins Continuous Integration Server
     Loaded: loaded (/lib/systemd/system/jenkins.service; enabled; vendor preset: enabled)
     Active: active (running) since Mon 2023-02-13 06:46:48 UTC; 1min 45s ago
   Main PID: 2674 (java)

```

* Port değiştirmek ve servisi sistem açıldığında başlatmak için aşağıdaki adımları uygulayabilirsiniz.

### Port değiştirmek

Varsayılan olarak `8080` üzerinden erişebilirsiniz. Aşağıdaki parametreyi değiştirerek istediğiniz port üzerinden erişebilirsiniz. Bizim örneğimizde `8080` --> `8081` olarak değiştirilecek.

* Jenkins servisimizi durduruyoruz.

```bash
sudo systemctl stop jenkins.service
```

* Portumuzu `8081` olarak değiştiriyoruz.

```bash
sudo sed -i s+JENKINS_PORT=8080+JENKINS_PORT=8081+g /lib/systemd/system/jenkins.service
```

* Ayar dosyası değiştirdiğimiz için servise yeniden ayar dosyasını okutmamız gerekiyor.

```bash
sudo systemctl daemon-reload
```

* Jenkins servisi aktif ediyoruz.

```bash
sudo systemctl start jenkins.service
```

### Sistem başlangıcında otomatik çalıştırmak için

Ubuntu sistemimiz yeniden başlatıldığında Jenkins'in de çalışır hale gelmesi için servisi aktif etmemiz gerekiyor.

```bash
sudo systemctl enable jenkins.service
```

* Artık Jenkins 'e internet tarayıcımızı kullanarak `8081` portu üzerinden bağlanabiliriz.

``http://IP_ADRESINIZ:8081`

* Açılan ekranda sizden ilk admin şifresi isteyecek onu Ubuntu üzerinden aşağıdaki kodu çalıştırarak elde edebilirsiniz.

```bash
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

#Çıktı
d78a174351ce4c2fb59dbd65b8bed9c4 (Örnektir.)
```

* Daha sonra kullanıcı oluşturup, pluginleri yüklediğinizde kurulumu tamamlamış oluyorsunuz.

## Script dosyası

Aşağıdaki script dosyasını kullanarak kolayca Ubuntu 22.04'e Jenkins kurabilirsiniz.

```bash
#!/bin/bash

echo -e "java-jdk 11 yükleniyor."
sudo sudo apt update && apt install openjdk-11-jre -y

echo -e "\n\n"
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo -e "\n\n"
echo -e "Jenkins repo oluşturuluyor..."
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

echo -e "\n\n"
echo -e "Jenkins yükleniyor.."
sudo apt-get update && sudo apt-get install jenkins -y


echo -e "\n\n"
echo -e "Jenkins durduruluyor..."
sudo systemctl stop jenkins.service

echo -e "\n\n"
echo -e "Jenkins port 8081 olarak değiştiriliyor..."
sudo sed -i s+JENKINS_PORT=8080+JENKINS_PORT=8081+g /lib/systemd/system/jenkins.service

echo -e "\n\n"
echo -e "Ayarlar uygulanıyor."
sudo systemctl daemon-reload

echo -e "\n\n"
echo -e "Jenkins servisi başlatılıyor."
sudo systemctl start jenkins.service

echo -e "\n\n"
echo -e "Jenkins servisinin otomatik başlatılması..."
sudo systemctl enable jenkins.service

# Reset
NC='\033[0m'       # Text Reset
# Bold
BCyan='\033[1;36m'        # Cyan
echo -e "\n\n"

PAROLA=`sudo cat /var/lib/jenkins/secrets/initialAdminPassword`
echo -e "Admin ilk şifremiz: "${BCyan} ${PAROLA} ${NC}
```