---
title: (CKS) RuntimeClass atamak
excerpt: Kubernetes ortamda Pod'a RuntimeClass atamak

date: 2023-01-27
last_modified_at: 2023-01-27

categories:
  - Kubernetes
  - Certified-Kubernetes-Security-(CKS)
tags: 
  - [CKS, kubernetes, pod, container, runtimeclass, gvisor, runsc, runc]

toc: true
toc_sticky: true
---


Esenlikler,

**RuntimeClass**lar basit anlamda, bir sanal makinenin içerisinde çalışan ve kendine ait izole kernel'i olan container'lar olrak düşünebiliriz. Host (Ana) makinenin kerneline erişim sağlayamaz.

## Runtime kontrol etmek

Sisteminizde kullanılan runtimeClass'ı görmek için;
```bash
crictl(docker) info | grep -i defaultRuntimeName

#Output
"defaultRuntimeName": "runc",
```
## Kullanabileceğimiz runtime'lar

Diğer runtime'ları kullanabilmek için öncelikle sisteme yükleyip gerekli konfigürasyonları yapmak gerekiyor. Kullanabileceğiniz bazı runtime'lar;
* [**gVisor**](https://gvisor.dev/docs/user_guide/install/)
* [**crun**](https://github.com/containers/crun)
* [**kata**](https://github.com/kata-containers/kata-containers)

## RuntimeClass objesi oluşturmak

[**Kubernetes resmi dökümanlarında**](https://kubernetes.io/docs/concepts/containers/runtime-class/#2-create-the-corresponding-runtimeclass-resources) verilmiş olan yaml'ı alarak düzenliyoruz.

```yaml
apiVersion: node.k8s.io/v1
kind: RuntimeClass
metadata:
  # RuntimeClass objesi namespace almaz.
  # RuntimeClass'ımızın ismi
  name: myclass 
# CRI ayarında girilen konfigürasyon
handler: myconfiguration 
```

**Crun** için;
```yaml
apiVersion: node.k8s.io/v1
kind: RuntimeClass
metadata:
  name: crun
handler: crun
```
**gVisor** için;
```yaml
apiVersion: node.k8s.io/v1
kind: RuntimeClass
metadata:
  name: gvisor
handler: runsc
```
**Kata-container** için;
```yaml
apiVersion: node.k8s.io/v1
kind: RuntimeClass
metadata:
  name: kata
handler: kata
```

## Pod'a runtimeClass eklemek

Herhangi bir pod'umuza `spec.runtimeClassName` özelliğini ekleyerek, izole ediyoruz. `gVisor` runtime 'ını ele alırsak;

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  runtimeClassName: gvisor #Eklenen
  containers:
  - name: nginx
    image: nginx
```

## Kontrol etmek

Podun çalıştığı makineyeye giderek
```bash
ps -aux | grep -i runc

#Output
#Nginx podunu göremeyeceğiz.

ps -aux | grep -i runsc

#Output
#Nginx podunu göreceğiz.
```

[_[İngilizce]Kubernetes Dökümantasyonu - RuntimeClass_](https://kubernetes.io/docs/concepts/containers/runtime-class/)