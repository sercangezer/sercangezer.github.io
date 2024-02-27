---
layout: post
title: "`kafka` PORT is deprecated. Please use SCHEMA_REGISTRY_LISTENERS instead. hatası ve çözümü"
description: "HELM chartlarda `kafka` PORT is deprecated. Please use SCHEMA_REGISTRY_LISTENERS instead. hatası ve çözümü"
summary: "HELM chartlarda `kafka` PORT is deprecated. Please use SCHEMA_REGISTRY_LISTENERS instead. hatası ve çözümü"
tags: 
  - HELM
  - Kubernetes
  - Kafka
minute: 1
---

Esenlikler,

Bir projeyi HELM chart lara çevirirken `cp-kafka` (6.2.0) servisinde çok ilginç bir hata ile karşılaştım.

HELM chart oluşturup deploy ettiğimde, kafka loglarında;

```bash
PORT is deprecated. Please use SCHEMA_REGISTRY_LISTENERS instead.
```

hata atıyor. Oysa ki environment olarak configmap içerisinde tanımlı.

## Çözümü

Sadece deployment adını `KAFKA` koymamanız gerekiyor. `kafka1` koyunca sorunsuz olarak çalışıyor..

Esen kalın ...