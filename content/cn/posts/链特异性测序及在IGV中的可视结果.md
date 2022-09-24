---
title: 链特异性测序及在IGV中的可视结果
author: Liang
date: '2018-11-24'
slug: 链特异性测序及在IGV中的可视结果
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
与链特异性测序相对的是传统的非链特异性文库。

通过链特异性测序，我们可以清楚的知道得到的 reads 跟转录本是同向的还是反向的。其中常见的链特异性测序的方法是dUTP方法。dUTP方法是先利用随机引物合成RNA的一条cDNA链，在合成第二条链的时候用dUTP代替dTTP，加adaptor后用UDGase处理，将有U的第二条cDNA降解掉。这样最后的insert DNA fragment都是来自于第一条cDNA，也就是dUTP叫fr-firststrand的原因。

## 2. 正反链
DNA 的正链和负链，就是那两条反向互补的链。参考基因组给出的那个链就是所谓的正链（forword），另一条链是反链（reverse）。但是这正反一定不能和正义链（sense strand）反义链（antisense strand）混淆，两条互补的DNA链其中一条携带编码蛋白质信息的链称为正义链，另一条与之互补的称为反义链。

## 3. IGV可视化

IGV可视化read时候有多项可以选
* Read strand
* First-of-pair strand 
图示按照igv 颜色选项中的read strand 方向进行区分，可以看到所有红色read都是在正链方向（注意正链不是正义链），而所有蓝色的read都是负链方向。
![](https://upload-images.jianshu.io/upload_images/3014937-5283508854fe2c5b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

如果这个时候把颜色选项改为按照first of pair of strand来区分，会出现下图的变化。

![链特异性文库的IGV可视化](https://upload-images.jianshu.io/upload_images/3014937-6591d6909ab8bf48.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

如果对非链特异性文库使用的first of pair of strand可视化会出现下面的情况

![非链特异性的IGV可视化](https://upload-images.jianshu.io/upload_images/3014937-2ea435d1a1cf97d4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

可以看到同一个gene相关的read颜色还是混杂的，因为它并不是链特异性文库，所以不能分开first strand和second strand。


