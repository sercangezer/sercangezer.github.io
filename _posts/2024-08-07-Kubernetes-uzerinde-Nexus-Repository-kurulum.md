---
layout: post
title: "Kubernetes üzerinde Nexus Repository kurulum"
description: "Kubernetes üzerinde hostpath olarak Nexus Repository kurulum"
summary: "Single node Kubernetes üzerinde hostpath olarak Nexus Repository kurulum"
tags: 
  - Kubernetes
  - Sonatype Nexus Repository
  - Private Registry
  - k3s
minute: 1
---

## Video

<div align="center">
<iframe class="youtube-video"  src="https://www.youtube.com/embed/jTb4EzwduHk?si=p3MJmCziQEAy4Zsz" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe></div>

![](../images/2024/20240807-sonatype-nexus-repository-logo.png)


Esenlikler,


Private Registry olarak çok yaygın kullanılan [Sonatype Nexus Repository](https://help.sonatype.com/en/sonatype-product-overview.html) yazılımını k3s üzerine hostPath olarak kuracağız.

❗ [`Github` Kubernetes Manifest dosyaları](https://github.com/sercangezer/sercangezer.github.io/tree/main/YOUTUBE/00-NexusInstallation)

# Kurulum

1. Öncelikle bir kubernetes kurulu sunucunuz olmalı. Ben k3s kurulu bir tek makine (single node) kullanacağım.

❗❗ Master & Worker lı bir multi node cluster ınız varsa hostPath sıkıntı çıkaracaktır. Dinamik provision kullanmanız gerekir.

```bash
vagrant@server-0:~$ k get node -o wide

NAME       STATUS   ROLES                  AGE   VERSION        INTERNAL-IP     EXTERNAL-IP     OS-IMAGE             KERNEL-VERSION      CONTAINER-RUNTIME
server-0   Ready    control-plane,master   15m   v1.29.5+k3s1   192.168.1.170   192.168.1.170   Ubuntu 20.04.6 LTS   5.4.0-169-generic   containerd://1.7.15-k3s1
```

2. `hostPath` ile statik provision yapacağımız için verileri koyacağımız klasörü oluşturup yetki vermemiz gerekiyor.

```bash
# klasör oluşturuyoruz
sudo mkdir -p /nexus-data
# klasörün sahipliğini kullanıcımız ile değiştiriyoruz.
sudo chown vagrant:vagrant -R /nexus-data
# klasöre okuma yazma ve çalıştırma izinleri veriyoruz
sudo chmod -R 777 /nexus-data
```

3. namespace imizi oluşturalım.

```bash
cat << EOF | kubectl apply -f -
apiVersion: v1
kind: Namespace
metadata:
  name: nexus
  labels:
    name: nexus
EOF
```

3. Nexus'a verilerini nereye yazacağını göstereceğimiz PV ve PVC objelerini oluşturalım.

```bash
cat << EOF | kubectl apply -f -
apiVersion: v1
kind: PersistentVolume
metadata:
  name: nexus-pv
  labels:
    pv: nexus-pv
    type: local
spec:
  capacity:
    storage: 30Gi
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  storageClassName: ""
  hostPath:
    path: /nexus-data
  claimRef:
    name: nexus-pvc
    namespace: nexus
--- 
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: nexus-pvc
  namespace: nexus
spec:
  accessModes:
    - ReadWriteOnce
  storageClassName: ""
  resources:
    requests:
      storage: 30Gi
  volumeName: nexus-pv
EOF
```

4. Nexus yazılımımızı deploy edeilim.

```bash
cat << EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nexus
  namespace: nexus
  labels:
    app: nexus
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nexus
  template:
    metadata:
      labels:
        app: nexus
    spec:
      containers:
        - name: nexus
          image: sonatype/nexus3:latest
          env:
          - name: MAX_HEAP
            value: "1000m"
          - name: MIN_HEAP
            value: "500m"
          ports:
            - containerPort: 8081
          volumeMounts:
            - name: nexus-data
              mountPath: /nexus-data
      volumes:
        - name: nexus-data
          persistentVolumeClaim:
            claimName: nexus-pvc
EOF
```

5. Nexus Web arayüzüne erişebilmek ve yeni oluşturacağımız repoların portlarını yazacağımız servis objemiz.

```bash
cat << EOF | kubectl apply -f -
apiVersion: v1
kind: Service
metadata:
  name: nexus-service
  namespace: nexus
spec:
  selector: 
    app: nexus
  type: NodePort  
  ports:
    - name: nexus-web-ui
      port: 8081
      targetPort: 8081
      nodePort: 30880
EOF
```

6. http://NODE_IP:30880 portu üzerinden arayüze erişebilirsiniz.
7. Başlangıçta `admin` kullancısının şifresini aşağıdaki komut çıktısı ile öğrenip değiştirmeniz gerekiyor.

```bash
kubectl exec -n nexus $(kubectl get pods -A -l "app=nexus" -o jsonpath="{.items[0].metadata.name}") -- cat /nexus-data/admin.password

#Output
e65a4996-f05b-4294-96a3-24f8fe2d45a8
```
Esen kalın ...

