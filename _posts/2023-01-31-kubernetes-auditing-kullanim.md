---
layout: post
title: (CKS) Kubernetes Auditing Mekanizması
description: Kubernetes ortamında Auditing Logging mekanizması ile kubernetes güvenliğinin sağlanması
summary: Kubernetes ortamında Auditing Logging mekanizması ile kubernetes güvenliğinin sağlanması
tags: 
  - [CKS,auditing,logging,Kubernetes]
minute: 1
---

Esenlikler,

`Auditing` dediğimiz olay, kubernetes cluster içerisinde sırasıyla güvenlikle ilgili konuları kaydeden bir loglama mekanizmasıdır.

* ne oldu?
* Ne zaman oldu?
* kim başlattı?
* ne üzerine oldu?
* nerede gözlemlendi?
* nereden başlatıldı?
* nereye gidiyordu?

gibi soruların cevaplarını sürekli kaydederek, yönetici geriye dönük istediğini bulabilmesini sağlar.

🔥 [_[İngilizce] Kubernetes Auditing resmi dökümantasyonu_](https://kubernetes.io/docs/tasks/debug/debug-cluster/audit/)

# Kullanım

* Aşağıdaki örnek policy.yaml dosyamızı indirelim. _(Sınavda hazır olarak policy.yaml dosyası veriliyor.)_

```bash
wget https://raw.githubusercontent.com/kubernetes/website/main/content/en/examples/audit/audit-policy.yaml
```
```bash
cp -rvf audit-policy.yaml /etc/kubernetes/audit-policy.yaml #Kubernetes ana dizinine taşıyoruz.
```

* `kube-apiserver.yaml` dosyasına parametre girerek **auditing** aktif etmemiz gerekiyor.

```bash
cd /etc/kubernetes/manifests/ #Kube-apiserver dizinine gidiyoruz
```
```bash
cp -rvf kube-apiserver.yaml ~/ #kube-apiserver.yaml dosyasımızın yedeğini başka bir yere alıyoruz.
```

* Editör ile açarak aşağıdaki parametreleri ekliyoruz.

```yaml
- --audit-policy-file=/etc/kubernetes/audit-policy.yaml #Policy.yaml dosya yolu
- --audit-log-path=/var/log/k8s-audit/k8s-audit.log #Logların yazılacağı log dosya yolu
- --audit-log-maxage=30 #Logların kaç günlük tutulacağı
- --audit-log-maxbackup=10 #Logların tutulacak yedek sayısı
```

![](https://raw.githubusercontent.com/sercangezer/sercangezer.github.io/main/images/2023/20230131-kubernetes-auditing-kubeapiserver-parametre.PNG)

Kube-apiserver'ımızın logları yazacağı ve policy leri okuyacağı dosyaların bulunduğu dizinleri tanıması gerekiyor. Bu sebeple volumeMounts ve Volumes tanımlıyoruz.

```yaml
volumeMounts:
- name: audit-config
  mountPath: /etc/kubernetes/audit-policy.yaml
  readOnly: true
- name: audit-log
  mountPath: /var/log/k8s-audit
  readOnly: false
```

![](https://raw.githubusercontent.com/sercangezer/sercangezer.github.io/main/images/2023/20230131-kubernetes-auditing-volumemounts-ekleme.PNG)

```yaml
volumes:
- name: audit-config
  hostPath:
    path: /etc/kubernetes/audit-policy.yaml
    type: File
- name: audit-log
  hostPath:
    path: /var/log/k8s-audit
    type: DirectoryOrCreate 
```

![](https://raw.githubusercontent.com/sercangezer/sercangezer.github.io/main/images/2023/20230131-kubernetes-auditing-volumes-ekleme.PNG)

* Herhangi bir hata yapmadan ekleme yaptıysanız aşağıdaki komut ile logları görebilirsiniz.

```bash
cat /var/log/k8s-audit/k8s-audit.log
```
 
❗ Eğer hata kube-apiserver.yaml eklerken hata yaparsanız api-server'a bağlanamayacağız için `kubectl get pod` dediğinizde hata alırsınız. Hata alıyorsanız yedek aldığınız orjinal kube-apiserver.yaml getirebilir onu tekrar editleyebilirsiniz.

❗ `/etc/kubernetes/manifest` altındaki statik podları editlerken mutlaka yedek almalısınız.