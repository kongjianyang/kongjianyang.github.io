---
title: heatmap-2聚类之后得到行名
author: Liang
date: '2018-11-24'
slug: heatmap-2聚类之后得到行名
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
## 1.问题
heatmap.2是一种绘画热图的gplots包中的一个功能，十分强大，得到一个精美的热图，命令行不超过20行。

有一个不方便的地方是得到这份热图之后希望知道聚类之后的行名以及具体的数值，以备后续的分析。

## 2.解决
查阅之后可以通过以下方法进行解决.
首先制造一个绘图的矩阵
```
y <- matrix(rnorm(50), 10, 5, dimnames=list(paste("g", 1:10, sep=""),
paste("t", 1:5, sep="")))
```
![建造的矩阵](https://upload-images.jianshu.io/upload_images/3014937-4e6187f5899aaa7e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


按行进行聚类
```
hr <- hclust(as.dist(1-cor(t(y), method="pearson")),
method="complete")
```
按列进行聚类
```
hc <- hclust(as.dist(1-cor(y, method="spearman")), method="complete")
```
绘制热图
```
library(gplots)
heatmap.2(y, Rowv=as.dendrogram(hr), Colv=as.dendrogram(hc),
scale="row", density.info="none", trace="none")
```

![heatmap.2绘图范例](https://upload-images.jianshu.io/upload_images/3014937-5da3414fc9957aba.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

得到聚类之后的矩阵结果：
```
y[rev(hr$labels[hr$order]), hc$labels[hc$order]]
```
![聚类后的矩阵结果](https://upload-images.jianshu.io/upload_images/3014937-6edd1309a23e24c1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
