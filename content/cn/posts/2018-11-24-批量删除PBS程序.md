---
title: 批量删除PBS程序
author: Liang
date: '2018-11-24'
slug: 批量删除PBS程序
categories:
  - 生信修炼
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
假设我们有 7823111到7823118的一系列PBS的程序，现在因为某原因要删除它们。我们可以通过以下命令对其批量删除。

第一个是

```
qdel {17979..18028}
```
第二个，如果所有的PBS程序都是某用户自己提交的，可以使用下面命令
```
qdel -u [user]
```
这两个能很好地进行PBS程序的批量删除。
