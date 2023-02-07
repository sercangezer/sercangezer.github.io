---
title: (CKS) Falco ile konteynır davranışlarını izlemek
excerpt: Kubernetes ortamında çalışan konteynırların Falco ile davranışlarını izlemek

date: 2023-01-30
last_modified_at: 2023-01-30

categories:
  - Kubernetes
  - Certified-Kubernetes-Security-(CKS)
tags: 
  - [CKS,falco,kubernetes,container,Analyzing Container Behavior with Falco]

toc: true
toc_sticky: true
---

![](https://raw.githubusercontent.com/sercangezer/sercangezer.github.io/main/images/2023/20230130-kubernetes-falco-kullanimi-01.PNG)

`Falco`, uygulamalarınızı ve konteynırlarınızı izleyerek çalışma zamanında oluşan tehditleri algılar. Kısaca Kubernetes ortamında tehdit algılama aracı olarak düşünebiliriz.

# Kurulum

Ben Rocky Linux 9 üzerinde kurulum yapacağım. 

🔥 [_Diğer kurulumlar için resmi sayfası_] (https://falco.org/docs/getting-started/installation/#centos-rhel)

1. Yum repository dosyasını sistemimize ekleyiyoruz.
   
```bash
rpm --import https://falco.org/repo/falcosecurity-packages.asc
curl -s -o /etc/yum.repos.d/falcosecurity.repo https://falco.org/repo/falcosecurity-rpm.repo
```

2. Uyumlu kernel headers dosyalarımızı yüklüyoruz.

```bash
yum -y install kernel-devel-$(uname -r)
```

3. Falco'yu yüklüyoruz.

```bash
yum update -y && yum -y install falco

# Çalışmazsa denenebilir;
dnf install --nogpgcheck falco -y
```

4. Çalıştığına emin olmak için kontrol ediyoruz;

```bash
systemctl status falco
```

# Kullanım

* Örnek bir pod oluşturalım.

```bash
cat << EOF | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: falco-ornek-pod
spec:
  containers:
  - name: falco-ornek-konteynir
    image: busybox:1.36.0
    command: ['sh', '-c', 'while true; do cat /etc/shadow; sleep 5; done']
EOF
```

❗ Cluster bir yapı kurmadığım için direkt olarak podu hangi node üzerinde oluşturulduğunu biliyorum. Cluster bir yapınız mevcut ise podun özelliklerine bakarak öğrenebilirsiniz.;

```bash
kubectl describe pod falco-ornek-pod | grep -i Node:

#Çıktı
Node:             cks-master.sercangezer.com.tr/192.168.1.72
```

* Pod'un oluşturulduğu makineye SSH ile bağlanıyoruz.
* Falco'nun kuralları yazdığımız `/etc/falco/falco_rules.local.yaml` dosyasına aşağıdaki örnek kuralımızı ekliyoruz.

```yaml
- rule: spawned_process_in_test_container
  desc: A process was spawned in the falco test container.
  condition: container.name = "falco-ornek-konteynir" and evt.type = execve
  output: "BIZIM ORNEGIMIZ %evt.time,%user.uid,%proc.name,%container.id,%container.name"
  priority: WARNING
```

* Ekledikten sonra falco'nun loglarından kontrol ediyoruz.

```bash
systemctl status falco

#Çıktı
Jan 31 08:33:10 cks-master.sercangezer.com.tr falco[27184]: 08:33:10.199588288: Warning BIZIM ORNEGIMIZ - 08:33:10.199588288,0,cat,adaab7654955,falco-ornek-konteynir
```

```bash
cat /var/log/falco | grep -i falco | grep -i BIZIM
```

![](https://raw.githubusercontent.com/sercangezer/sercangezer.github.io/main/images/2023/20230130-kubernetes-falco-kullanimi-02.PNG)

❗ `/etc/falco_rules.local.yaml` dosyasına yazdığımız kurallar falco servisini yeniden başlatmadan direkt olarak uygular.

❗ `/etc/falco_rules.yaml` dosyasına yazdığımız kuralların uygulanması için falco servisinin yeniden başlatılması gerekmektedir.