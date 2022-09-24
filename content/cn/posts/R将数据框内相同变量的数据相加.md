---
title: R将数据框内相同变量的数据相加
author: Liang
date: '2018-11-24'
slug: R将数据框内相同变量的数据相加
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
## 1. 问题
有的时候从原始数据读入到R中的数据会有很多的重复数据，并没有进行数据合并，对于后续的处理中会造成麻烦，因为R处理这种数据的时候会只取用第一次出现的结果。处理这个问题有很多方法，记录如下。

## 2. 解决
首先建立一个数据框，用来测试我们的方法：
```
bevs <- data.frame(cbind(name = c("Bill", "Llib"), drink = c("coffee", "tea", "cocoa", "water"), cost = seq(1:8)))
bevs$cost <- as.integer(bevs$cost)
bevs
```
![bevs数据结构](https://upload-images.jianshu.io/upload_images/3014937-7fd0a4878c21f301.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

下面利用```plyr ```包里面的```count ```函数进行相加
```
library(plyr)
count(bevs, "name")
```
![name出现的次数](https://upload-images.jianshu.io/upload_images/3014937-00277791eedfa909.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
同时统计两列，结果如下：
```
count(bevs, c("name", "drink"))
```
![name和drink统计](https://upload-images.jianshu.io/upload_images/3014937-0775e365a5c5385d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

如果想知道Bill和Llib在不同drink上花费的钱是多少呢？可以使用 ```aggregate```函数。

```
aggregate(cost ~ name + drink, data = bevs, sum)
```
![统计name和drink下的cost](https://upload-images.jianshu.io/upload_images/3014937-8f0535305747d8df.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
统计Bill和Llib的总花费
```
aggregate(cost ~ name, data = bevs, sum)
```
![name的cost](https://upload-images.jianshu.io/upload_images/3014937-45ba1d54bea6201b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 3. 总结
总结而言，利用```count```和```aggregate```可以很方便的帮助我们整理数据，将重复出现的变量归到一起进行计算。
