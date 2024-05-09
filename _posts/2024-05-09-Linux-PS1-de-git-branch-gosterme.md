---
layout: post
title: "Linux PS1 de GIT branch gösterme"
description: "Linux işletim sistemlerinde BASH PS1 de GIT branch gösterme"
summary: "Linux işletim sistemlerinde BASH PS1 de GIT branch gösterme"
tags: 
  - Bash
  - Linux
  - PS1
minute: 1
---


Esenlikler,

Düz `BASH` kullanan biri olarak github repository klasörlerine girdiğimizde hangi branch de olduğunu PS1 ile görmemizi sağlayan küçük bir kod bloğu kullanıyorum. 

İnternet aleminde kalıcı olması amacıyla not ediyorum.

❗ [`Git`](https://git-scm.com/) yüklü olması gerekiyor.

* `.bashrc` dosyasının en başına aşağıdaki kodu ekleyelim.

```bash
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
```

* `export PS1=` değişkenine aşağıdaki tanımı eklemeniz gerekiyor.

```bash
\$(parse_git_branch) 
```

* Kendi `PS1` değişkenimi paylaşıyorum.

```bash
export PS1="\[\e[01;33m\]\u\[\e[m\]@\[\e[0;1;92m\]\h\[\e[m\]\[\e[01;35m\][\$(hostname -I | awk '{print \$1}')]\[\e[0m\]:\[\e[01;36m\]\$PWD\[\e[m\]\[\e[91m\]\$(parse_git_branch) \[\e[01;31m\]\\$> \[\e[m\]"

# sercangezer@TTK[192.168.1.68]:/GIT/sercangezer.com.tr(main) $>
```

Esen kalın ...

