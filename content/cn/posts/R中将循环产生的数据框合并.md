---
title: R中将循环产生的数据框合并
author: Liang
date: '2018-11-24'
slug: R中将循环产生的数据框合并
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
##1.问题
今天利用R写循环的时候出现了一个问题，循环内会产生多个数据框，希望将这多个数据库合并并生产一个最终的数据框，最后利用了list和do.call()功能进行了实现。

##2.解决
例如假设我们有如下三个数据框
```
df1 <- data.frame(cell=c(1,2,3),val=c(345,123,466))
df2 <- data.frame(cell=c(67,3,2),val=c(234,234,56))
df3 <- data.frame(cell=c(3,67,23),val=c(23,8,34))
```
现在我们希望将这三个数据框进行合并：
首先创建一个空list，利用get()将所有数据框写入，形成一个2维的list，然后利用do.call()进行合并。
```
l <- list()
for(i in 1:3){
  df.now <- get(paste0("df",i))
  l[[i]] <- df.now
}

do.call(rbind,l)
```

经过评论提醒，还有一种方法可能会显得更加易于理解些，即先形成一个空的data.frame，然后直接利用rbind将变量数据框合并到最终的数据框中。

```{r}
l <- data.frame()
for(i in 1:3){
df.now <- get(paste0("df",i))
l <- rbind(l, df.now)
}
```

两种方法最后得到的结果都是：

```
    cell val
1    1 345
2    2 123
3    3 466
4   67 234
5    3 234
6    2  56
7    3  23
8   67   8
9   23  34
```
##3.总结

这虽然是个小的track，但是在数据处理的时候有时会显得非常有用。
