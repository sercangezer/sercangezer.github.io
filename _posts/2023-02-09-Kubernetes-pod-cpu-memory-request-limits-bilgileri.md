---
title: Çalışan Podların CPU/Memory Request ve Limit bilgilerini görmek
excerpt: Kubernetes ortamda çalışan Pod ve container ların CPU/Memory Request ve Limit bilgilerini ekrana yazdırmak

date: 2023-02-09
last_modified_at: 2023-02-09

categories:
  - Kubernetes
tags: 
  - [Kubernetes,K8s,Pod,Container,CPU Request,Memory Request,CPU Limits,Memory Limits]

toc: true
toc_sticky: true
---


Esenlikler,

Kubernetes ortamda kaynak yönetimi yapmak istediğimizde baktığımız alanlardan biri de `CPU ve Memorylere tanımlanmış olan Request ve Limits bilgileri`dir.

Kısaca;

## CPU/Memory Request nedir?
Container ın ayağa kalkması için sistemden ayrılmış olan CPU/Memory miktarı

## CPU/Memory Limits nedir?
 Container ın kullanım sırasında ulaşacağa maksimum CPU/Memory miktarı, bu limiti aştığı zaman yeniden başlatılacaktır.

## Yolu (Path)

```yaml
spec.containers.resources.requests.cpu
spec.containers.resources.requests.memory
spec.containers.resources.limits.cpu
spec.containers.resources.limits.memory
```

## Kullanabileceğimiz Komutlar

Aşağıdaki komutları kullanarak aktif olan pod lar üzerindeki bilgileri çekebiliriz.

**--all-namespaces** ibaresini **-n NAMESPACE_ADI** olarak değiştirirseniz sadece istemiş olduğunuz namespace'de çalışan podların bilgilerini getirecektir.
{: .notice--info}

### CPU Requests
```bash
kubectl get po --all-namespaces \
 -o=jsonpath="{range .items[*]}{.metadata.namespace}:{.metadata.name}{'\n'}{range .spec.containers[*]}  {.name}:{.resources.requests.cpu}{'\n'}{end}{'\n'}{end}"
```

### CPU Limits
```bash
kubectl get po --all-namespaces \
 -o=jsonpath="{range .items[*]}{.metadata.namespace}:{.metadata.name}{'\n'}{range .spec.containers[*]}  {.name}:{.resources.limits.cpu}{'\n'}{end}{'\n'}{end}"
```

### Memory Requests
```bash
kubectl get po --all-namespaces \
 -o=jsonpath="{range .items[*]}{.metadata.namespace}:{.metadata.name}{'\n'}{range .spec.containers[*]}  {.name}:{.resources.requests.memory}{'\n'}{end}{'\n'}{end}"
```

### Memory Limits
```bash
kubectl get po --all-namespaces \
 -o=jsonpath="{range .items[*]}{.metadata.namespace}:{.metadata.name}{'\n'}{range .spec.containers[*]}  {.name}:{.resources.limits.memory}{'\n'}{end}{'\n'}{end}"
```

Saygılarımla,
Sağlıklı günler dilerim.