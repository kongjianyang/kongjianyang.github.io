---
title: Linux下递归查找某文件并移动
author: Liang
date: '2018-11-24'
slug: Linux下递归查找某文件并移动
categories:
  - Linux技巧
tags: []
lastmod: '2018-11-24T22:51:22-04:00'
keywords: []
description: ''
comment: no
toc: no
autoCollapseToc: no
postMetaInFooter: no
hiddenFromHomePage: no
contentCopyright: no
reward: no
mathjax: no
mathjaxEnableSingleDollar: no
mathjaxEnableAutoNumber: no
hideHeaderAndFooter: no
flowchartDiagrams:
  enable: no
  options: ''
sequenceDiagrams:
  enable: no
  options: ''
---
Linux下递归查找某类型文件可以使用find命令，例如我想查找所有的.sh文件，可以使用一下命令

```
find . -name "*.sh"
```

而如果我们希望移动所有这类型的文件到指定文件夹，在zsh下可以使用

```
cp **/*.sh sh_file
```
