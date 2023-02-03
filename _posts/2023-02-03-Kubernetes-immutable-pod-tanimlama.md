---
published: true
layout: post
title: (CKS) Immutable Pod tanımlama
description: Kubernetes ortamda Immutable (Değişmez/Sabit) Pod tanımlama
date: 2023-02-03
tags: [CKS,immutable,immutable pod,immutable container,container security context]
comments: false
---

Esenlikler,

Container Security Context konularından biri de Immutable Container konusu. 

`Immutable` kelimesi basit anlamda değişmez/sabit anlamına gelmekle bizim konumuzda container çalışırken müdahale edilemeyen bir yapıda olması.

# Kubernetes ortamında bir container ın immutable olma şartları;

* Container ların host (ana) makineye erişemediğinden emin ol.

```yaml
securityContext.privileged: false` ~~> Varsayılan olarak `false` gelmektedir.
```

> **privileged:true** olursa container içerisinden host makinesindeki processleri görebilir, erişebilir.

* Container ın içerisinde yetki yükseltmesine izin vermediğinden emin ol. (_root ya da sudo yetkisi olan bir kullanıcıyla oturum açamaması_)


```yaml
container.securityContext.allowPrivilegeEscalation: false
```
* Container ın içerisinde `root` kullanıcısı ve sudo yetkisi ile işlemler yapmasını engellediğine emin ol.

```yaml
container.securityContext.runAsUser: 999
container.securityContext.runAsGroup: 999
```

* Container ın dosya sisteminin (Filesystem) sadece okuma yetkisi atandığından emin ol.

```yaml
container.securityContext.readOnlyRootFilesystem: true
```
  * ❗❗ Eğer `container.securityContext.readOnlyRootFilesystem: true` olarak uygularsak yazılımın kullanacağı cache, log gibi geçici olarak kullanacağı klasörleri empytDir olarak bağlamamız gerekir.

# Uygulama

* Aşağıdaki yaml da bulunan örnek podumuzu immutable hale çevirelim.

```yaml
cat << EOF | kubectl apply -f - 
apiVersion: v1
kind: Pod
metadata:
  name: immutable-olcak-pod
spec:
  containers:
  - name: nginx
    image: nginx:latest
    securityContext:
      privileged: true
      allowPrivilegeEscalation: true
      runAsUser: 0
      runAsGroup: 0
      readOnlyRootFilesystem: false
EOF
```

* İmmutable container a çevrilmiş hali.;

```yaml
cat << EOF | kubectl apply -f - 
apiVersion: v1
kind: Pod
metadata:
  name: immutable-olan-pod
spec:
  containers:
  - name: nginx
    image: nginx:latest
    securityContext:
      privileged: false # Silebiliriz ve ya false yapmalıyız..
      allowPrivilegeEscalation: false # Silebiliriz ve ya false yapmalıyız.
      runAsUser: 999 # Silebiliriz ve ya başka kullanıcı id yapmalıyız.
      runAsGroup: 999 # Silebiliriz ve ya başka grup id yapmalıyız.
      readOnlyRootFilesystem: false # True olarak yapmalıyız.
    startupProbe: #removes the bash shell
          exec:
            command:
            - rm
            - /bin/bash
    # Geçici olarak yazma ve çalıştırma yapacak klasörleri mount ettik.
    volumeMounts:
    - name: cache
      mountPath: /var/cache/nginx
    - name: run
      mountPath: /var/run
  volumes:
  - name: cache
    emptyDir: {}
  - name: run
    emptyDir: {}  
EOF
```

