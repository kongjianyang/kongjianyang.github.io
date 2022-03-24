---
title: R中的数据去重与缺失值处理
author: Liang
date: '2018-11-24'
slug: R中的数据去重与缺失值处理
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
在R语言中，涉及到数据去重与缺失值处理的函数一共有下面这么几个：

- unique

- distinct

- intersect

- union

- duplicated         #布尔判断

- is.na()/!is.na()   #缺/非缺失值

- na.rm=TRUE/FALSE   #移除缺失值

- na.omit(lc)        #忽略缺失值

- complete.cases()   #完整值

unique函数通常用于去重：
```
unique(mydata$B)                  #对含有重复值得向量进行去重
dplyr::distinct(mydata,B)         #对含有重复值字段的数据框去重
```
dplyr中提供了两个函数可以执行交集与补集操作:
```
duplicated(mydata$B)              #返回重复对象的布尔值
mydata[!duplicated(mydata$B),]    #剔除重复值，仅保留唯一值
```
