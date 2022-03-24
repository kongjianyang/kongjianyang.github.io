---
title: linux下ls的一些操作
author: Liang
date: '2018-11-24'
slug: linux下ls的一些操作
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
只显示隐藏文件夹
```
ls -d .* # -d：仅显示目录名，而不显示目录下的内容列表。显示符号链接文件本身，而不显示其所指向的目录列表；
```

按照文件大小排序
```
ls -lS #从大到小
ls -lSr #从小到大
```

寻找指定时间文件并移动
```
find ./ -mmin -60 | xargs -I {} cp {} ../
```
