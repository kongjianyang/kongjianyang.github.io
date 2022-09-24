---
title: R数据框选中某列之后不降为成列表
author: Liang
date: '2018-11-24'
slug: R数据框选中某列之后不降为成列表
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
# 1. 问题
数据处理中一个令人头疼的事情是选中数据框中的某列时经常会被降维成列表而不是保持原来数据框的结构，如下：
```{r}
student <- data.frame(ID=c(11,12,13),Name=c("Devin","Edward","Wenli"),Gender=c("M","M","F"))
student
```
![数据框](https://upload-images.jianshu.io/upload_images/3014937-316c1b956cd56903.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

当我们想得到name这一行的时候会采用以下方法
```{r}
name1 <- student$Name
name2 <- student[,2]
str(name1)
str(name2)
#Factor w/ 3 levels "Devin","Edward",..: 1 2 3
#Factor w/ 3 levels "Devin","Edward",..: 1 2 3
```
可以看到数据都是factor类型的，没有保持为数据框，而这是不方面的

#2. 解决
我们可以利用以下两种方式避免这种情况的发生

```{r}
name3 <- student[,2,drop = FALSE]
name4 <- student["Name"]
str(name3)
str(name4)
#'data.frame':	3 obs. of  1 variable:
#$ Name: Factor w/ 3 levels "Devin","Edward",..: 1 2 3
#'data.frame':	3 obs. of  1 variable:
#$ Name: Factor w/ 3 levels "Devin","Edward",..: 1 2 3
```
其中注意双中括号和单双括号的区别
```{r}
name5 <- student[["Name"]]
str(name5)
#Factor w/ 3 levels "Devin","Edward",..: 1 2 3
```
双中括号类似于$功能了。







