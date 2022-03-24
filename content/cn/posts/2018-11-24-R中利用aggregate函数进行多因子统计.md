---
title: R中利用aggregate函数进行多因子统计
author: Liang
date: '2018-11-24'
slug: R中利用aggregate函数进行多因子统计
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
## 1.介绍
R中aggregate函数的功能强大，它首先将数据进行分组（按行），然后对每一组数据进行函数统计，最后把结果组合成一个比较nice的表格返回。简单说有点类似sql语言中的group by，可以按照要求把数据打组聚合，然后对聚合以后的数据进行加和、求平均等各种操作。

## 2.详解
通过 mtcars 数据集的操作对这个函数进行简单了解。mtcars 是不同类型汽车道路测试的数据框类型数据：
```
str(mtcars)
'data.frame':	32 obs. of  11 variables:
 $ mpg : num  21 21 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 ...
 $ cyl : num  6 6 4 6 8 6 8 4 4 6 ...
 $ disp: num  160 160 108 258 360 ...
 $ hp  : num  110 110 93 110 175 105 245 62 95 123 ...
 $ drat: num  3.9 3.9 3.85 3.08 3.15 2.76 3.21 3.69 3.92 3.92 ...
 $ wt  : num  2.62 2.88 2.32 3.21 3.44 ...
 $ qsec: num  16.5 17 18.6 19.4 17 ...
 $ vs  : num  0 0 1 1 0 1 0 1 1 1 ...
 $ am  : num  1 1 1 0 0 0 0 0 0 0 ...
 $ gear: num  4 4 4 3 3 3 3 4 4 4 ...
 $ carb: num  4 4 1 1 2 1 4 2 2 4 ...
```
用attach函数把mtcars的列变量名称加入到变量搜索范围内，然后使用aggregate函数按cyl（汽缸数）进行分类计算平均值：
```
attach(mtcars)
aggregate(mtcars, by=list(cyl), FUN=mean)
```
![结果图](https://upload-images.jianshu.io/upload_images/3014937-ee093a2e9804496d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
by参数也可以包含多个类型的因子，得到的就是每个不同因子组合的统计结果：
```
aggregate(mtcars, by=list(cyl, gear), FUN=mean)
```
![结果图](https://upload-images.jianshu.io/upload_images/3014937-da18d9e11b7ba16a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 3.总结
在处理重复重复数据的时候，aggregate函数非常好用，在我最近的数据处理的过程中经常运用。
