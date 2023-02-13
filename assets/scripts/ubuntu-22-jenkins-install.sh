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