---
title: R中利用unite函数进行列合并
author: Liang
date: '2018-11-24'
slug: R中利用unite函数进行列合并
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
## 1. 介绍
unite函数是tidyr包中的一个非常实用的函数，和separate函数相对应，可以对于数据框进行按照格式的列合并。

## 2.用法
下面实用例子介绍unite函数的用法：
```
library(tidyr)
name1 <- c("Bob","Mary","Jane","Kim")
birth <- c("1990-1","1980-2","1995-5","1996-4")
df <- data.frame(name1, birth)
```
构造一个名为```df```的数据框，```df```结构如下：
![df结构](https://upload-images.jianshu.io/upload_images/3014937-385169a589c71593.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

下面我们想将birth列和name1列以```-```进行合并，可以使用```unite```函数了，
```unite```语法如下：

```
unite(data, col, ..., sep = "_", remove = TRUE)
```
利用该语法，我们将```name1```和```birth```列按照```-```进行合并，合并结果存到新的列```name-birth```中，并保留原始的列。
```
unite(df,"name-birth",c("name1","birth"), sep="-", remove = F)
```
合并的结果如下：
![合并后的df结构](https://upload-images.jianshu.io/upload_images/3014937-a8df5b0831f44eec.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
## 3.总结
tidyr包中有很多类似的功能强大的函数，这只是用来进行列合并的其中一列，当然会有很多其他的方法，会在之后详解
