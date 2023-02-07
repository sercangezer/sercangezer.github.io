---
title: (CKS) Kubelet ve Kube-apiserver TLS Version ve Cipher atama
excerpt: Kubernetes Kube-apiserver ve Kubelet için minimum TLS version ve Cipher atama

date: 2023-02-01
last_modified_at: 2023-02-01

categories:
  - Kubernetes
  - Certified-Kubernetes-Security-(CKS)
tags: 
  - [CKS,minTtlsMinVersion,tlsCipherSuites,tls-cipher-suites,tls-min-version,kubelet,kube-apiserver]

toc: true
toc_sticky: true
---


Esenlikler,

Sınavda `Kubelet güvenliğine` dair konu başlığı mevcut. Bu konuya örnek olması amacıyla biz;

* minimum TLS versiyonunun 12
* TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384,TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 cipher ları atayacağız.

# Kubelet 

* Öncelikle kubelet servisinin kullandığı config dosyasını bulalaım.

```bash
ps -aux | grep -i kubelet

# Çıktısı
root       35493  3.7  1.5 1647572 122696 ?      Ssl  08:10   2:59 /usr/bin/kubelet --bootstrap-kubeconfig=/etc/kubernetes/bootstrap-kubelet.conf --kubeconfig=/etc/kubernetes/kubelet.conf --config=/var/lib/kubelet/config.yaml --container-runtime-endpoint=unix:///run/containerd/containerd.sock --pod-infra-container-image=registry.k8s.io/pause:3.9
```

Gördüğünüz gibi **--config** parametresinde dosyanın yolu görünüyor. `--config=/var/lib/kubelet/config.yaml` 

* Önemli bir konfigürasyon dosyası olması sebebiyle yedeğini alalım.

```bash
cp -rvf /var/lib/kubelet/config.yaml ~/
```

* Şimdi bir editör ile `/var/lib/kubelet/config.yaml` dosyamızı açalım ve aşağıdaki parametreleri dosyamızın en altına ekleyelim.

🔥 [_Parametrelerin açıklamalarının bulunduğu resmi döküman_](https://kubernetes.io/docs/reference/config-api/kubelet-config.v1beta1/)

```yaml
tlsMinVersion: VersionTLS12
tlsCipherSuites: ['TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256','TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384','TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256']
```

![](https://raw.githubusercontent.com/sercangezer/sercangezer.github.io/main/images/2023/20230201-kubeletconfig-tls-add.PNG)

* Parametre eklerken bir yazım hatası yapmadıysanız kubelet servisi active olacaktır.

```bash
systemctl status kubelet

# Çıktısı
● kubelet.service - kubelet: The Kubernetes Node Agent
     Loaded: loaded (/usr/lib/systemd/system/kubelet.service; enabled; vendor preset: disabled)
    Drop-In: /usr/lib/systemd/system/kubelet.service.d
             └─10-kubeadm.conf
     Active: active (running) 
```

# Kube-apiserver

* Öncelikle kube-apiserver'ımızın yedeğini alalım.

```bash
cp -rvf /etc/kubernetes/manifests/kube-apiserver.yaml ~/
```

* Şimdi bir editör ile `/etc/kubernetes/manifests/kube-apiserver.yaml` dosyamızı açalım ve aşağıdaki parametreleri dosyamızın en altına ekleyelim.

🔥 [_Parametrelerin açıklamalarının bulunduğu resmi döküman_](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-apiserver/)

```yaml
- --tls-cipher-suites=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384,TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
- --tls-min-version=VersionTLS12
```

![](https://raw.githubusercontent.com/sercangezer/sercangezer.github.io/main/images/2023/20230201-kube-apiserver-tls-add.PNG)

* Parametre eklerken bir yazım hatası yapmadıysanız kube-apiserver podu bir süre sonra ayaklanacaktır.

Ayaklanmaz ise logların hatanızı tespit edebilirsiniz.


