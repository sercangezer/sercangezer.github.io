---
layout: post
title: "`sha256sum` ile dosyaların veri bütünlüğünü kontrol etme"
description: "Linux ortamlarda `sha256sum` ile dosya ve klasörlerin veri bütünlüğünü kontrol edin."
summary: "Linux ortamlarda `sha256sum` ile dosya ve klasörlerin veri bütünlüğünü kontrol edin."
tags: 
  - sha256sum
  - Veri bütünlüğü
minute: 1
---

Esenlikler,

Lokalimizde çalışan HELM Chart ları bir müşterimize USB ile verdiğimizde kendi ortamlarında deploy edildiğinde uygulamanın çalışmadığı iletildi. Kendimiz tekrar USB ile götürüp deploy ettiğimizde uygulama ayağa kalktı..

Bir daha böyle bir sorunla karşılaşmamak adına bir yöntem bulmamız gerekiyordu. O da `sha256sum` ..


* Çalışma ortamınız linux ise `sha256sum` kurulu olarak geliyor. 

* Kontrol edeceğimiz klasörün içine giriş aşağıdaki komutu çalıştırıyoruz.

```bash
find . -type f -exec sha256sum {} + > `date "+%Y%m%d_%H%M"`_checksums.sha256
```

  * Oluşturduğumuz dosyaya baktığımızda `sha256` - `Dosya adı` şeklinde verilerin olduğunu görüyoruz.

  ```bash
  .
  .
  .
  b18bcb13bd1e1f51d7081e2bb1841d046835a37c8bea72a942c737f1870ec011  ./config/menus/version.ipxe
  09d592c451a350dc946f20b8a0c4d0d5667a90e986de39df3b572076bd11396c  ./config/menus/vmware.ipxe
  93f4530175d1cea921fd35c7fd4603c76c3c383aa4ed35d8f0df66a8eafd3b4a  ./config/menus/vyos.ipxe
  6d88517ed96750b94daaa0abd86220e0fa2585fb6b7731f30b8f1e8c9e481bd4  ./config/menus/zeninstall.ipxe
  a5893dc6065a1e18bdfc41cc5bd1820ec4f8262206ecb68b9221204da8d16faa  ./config/endpoints.yml
  fd09ddf4b8ed7383c711bbab444292447d46b63d53bcd8ca2359a76cfbfea2e2  ./config/menuversion.txt
  05d989781bee5ddae40d901612a22893d670dcb53805798412e64183689817e7  ./checksums.sha256
  31c33d36a65bf822d7d8679a9785e252aac4b339a494cc5f6c56d9346028e1f3  ./docker-compose.yaml
  3f9eadd4320dfe2155c14c2b4cad5c21f138e2db82fa14b24015944bc20ab46f  ./20240210_1849_checksums.sha256
  ```

❗❗ **docker-compose.yaml** dosyasında değişiklik yapıyorum ve kontrol ediyorum.

```bash
sha256sum -c 20240210_1849_checksums.sha256
```

* Çıktı da görebileceğiniz gibi bir çıktı ile değişmiş olan dosyaları görebiliyoruz.

```bash
.
.
.
./config/menus/vmware.ipxe: OK
./config/menus/vyos.ipxe: OK
./config/menus/zeninstall.ipxe: OK
./config/endpoints.yml: OK
./config/menuversion.txt: OK
./docker-compose.yaml: FAILED ❗
./20240210_1849_checksums.sha256: FAILED ❗
sha256sum: WARNING: 2 computed checksums did NOT match ❗
```

Artık elinizde hatanın sizden kaynaklanmadığına dair bir kanıtınız var.

Esen kalın ...