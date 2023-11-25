---
layout: post
title: (CKS) Dockerfile analizi
description: Dockerfile analizi ile güvenlik açıklarını kapatmak
summary: Dockerfile analizi ile güvenlik açıklarını kapatmak
tags: 
  - [CKS,Dockerfile,Container,Image]
minute: 1
---

Esenlikler,

İmaj güvenliği konusunda güvenliği arttırabilmemizin en güzel yolu; olabildiğince Dockerfile dosyasını sadeleştirmektedir.

# Nasıl Dockerfile sadeleştirebiliriz?

Örnek Dockerfile dosyamız;

```yaml
FROM nginx:latest

USER root

RUN apt-get update && apt-get install -y wget
RUN apt-get update && apt-get install -y curl
RUN apt-get update && apt-get install -y phpadmin
RUN useradd -ms /bin/bash nginx-user
ENV db_password=DockerFileAnalyzer

USER root

ENTRYPOINT ["/docker-entrypoint.sh"]
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

🔥 FROM ile kullanacağımız base 'i `:latest` etiketiyle değil, belirli bir sürümünü kullanmalıyız. `:1.19.15` gibi.

🔥 Dockerfile içerisindeki **en son USER direktifinin** `root` kullanıcısı olmamasına dikkat etmeliyiz.

🔥 Gereksiz yazılımları yüklememeli ve fazladan layer (RUN direktifi) oluşturmamalıyız.

🔥 Veritabanı şfiresi, kullanıcısı gibi hassas bilgileri Dockerfile eklememeli, kubernetes secret ile bu değerleri tanıtmalıyız.

```yaml
FROM nginx:1.19.15

USER root

RUN apt-get update && apt-get install -y wget phpadmin

RUN useradd -ms /bin/bash nginx-user

USER nginx-user

ENTRYPOINT ["/docker-entrypoint.sh"]
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```