---
title: (CKS) Trivy, container imaj güvenlik açığı taramak
excerpt: Kubernetes ortamında kullanılan imajların güvenlik açıklarını kontrol etmek

date: 2023-01-27
last_modified_at: 2023-01-27

categories:
  - Kubernetes
  - Certified-Kubernetes-Security-(CKS)
tags: 
  - [CKS,trivy,kubernetes,pod,container,imaj,CVE,güvenlik açığı]

toc: true
toc_sticky: true
---

![](https://raw.githubusercontent.com/sercangezer/sercangezer.github.io/main/images/2023/trivy-ile-container-image-guvenlik-acigi-taramak-01.png)

`Trivy`: Kapsamlı ve çok yönlü bir güvenlik açığı tarayıcısıdır. Certified Kubernetes Security (CKS) sınavında `v0.19` versionu kullanılıp sadece `imaj güvenlik taraması` gerçekleştirmemiz yeterli.

Daha fazla yetenekleri için [**AquaSecurity Trivy resmi sitesini**](https://aquasecurity.github.io/trivy) inceleyebilirsiniz.

# Kurulum

Öncelikle birden fazla kurulum çeşidi vardır. Sınavda işletim sistemi üzerine paket kurulu olarak geliyor. Biz de o seneryoyu gerçekleştireceğiz.

🔥 [_Diğer kurulum çeşitleri_](https://aquasecurity.github.io/trivy/v0.19.2/getting-started/installation/)

Ben Rocky Linux üzerinde kurulumlar yapacağım.

```bash
sudo rpm -ivh https://github.com/aquasecurity/trivy/releases/download/v0.19.2/trivy_0.19.2_Linux-64bit.rpm
```

Kurduğumuz versiyonu kontrol edelim.
```bash
trivy --version

#Output
Version: 0.19.2
```

# Kullanım

Öncelikle örnek deployment 'ımızı çalıştıralım.

```bash
cat << EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: trivy-ornek-deployment
  labels:
    app: trivy
spec:
  replicas: 1
  selector:
    matchLabels:
      app: trivy
  template:
    metadata:
      labels:
        app: trivy
    spec:
      containers:
      - name: nginx
        image: nginx:1.14.2
        ports:
        - containerPort: 80
      - name: ruby
        image: ruby:2.4.0
      - name: alpine
        image: alpine:latest
EOF
```

Deployment ımızda kullanılan imajlara bir göz atalım.

```bash
kubectl describe deployments.apps trivy-ornek-deployment | grep -i image:

#Çıktı
    Image:        nginx:1.14.2
    Image:        ruby:2.4.0
    Image:        alpine:latest
```

Kullanılan imajların bütün güvenlik açıklarını taratmak için;

```bash
trivy image nginx:1.14.2

trivy image ruby:2.4.0

trivy image alpine:latest
```

Kullanılan imajların derecesine göre  güvenlik açıklarını taratmak için;

```bash
# nginx:1.14.2 sürümünde HIGH seviyesindeki güvenlik açıklarını listeler
trivy image --severity HIGH nginx:1.14.2

# ruby:2.4.0 sürümünün HIGH ve CRITICAL güvenlik açıklarını listeler
trivy image --severity HIGH,CRITICAL ruby:2.4.0

# alpine:latest sürümünde sadece OS (işletim sistemine) ait açıkları listeler
trivy image --vuln-type os alpine:latest
```