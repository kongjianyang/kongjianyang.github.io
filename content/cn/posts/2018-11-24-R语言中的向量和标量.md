---
title: R语言中的向量和标量
author: Liang
date: '2018-11-24'
slug: R语言中的向量和标量
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
R语言中最基本的数据类型是向量，与C语言家族不同，R语言中，单个数据(标量)没有单独的数据类型，它只是向量的一种特例，标量以单元素向量的形式出现。标量是只含一个元素的向量，例如f <- 3、g <- "US"和h <- TRUE。它们用于保存常量。向量化指的是对于向量中的每一个元素应用函数。

在R中，数字被当成一元向量，因为数据类型中没有标量。R中的向量索引从1开始。

向量的主要性质包括：1）向量是同质的，即向量中所有元素具有相同的模式；2）向量可以按照位置索引；3）向量可以按照多重位置索引，返回一个子向量；4）向量的元素可以被命名。

R语言表面上没有标量的类型，因为标量可以看做是含有一个元素的向量，逻辑运算符对标量和向量有着不同的形式。

![](https://upload-images.jianshu.io/upload_images/3014937-c428af5776172b7c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
