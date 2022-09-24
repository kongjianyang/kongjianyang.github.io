---
title: R为数据框求平均数和标准差并绘图
author: Liang
date: '2018-11-24'
slug: R为数据框求平均数和标准差并绘图
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
## 01. 准备数据
使用**ggplot**自带的**ToothGrowth**数据。导入数据及数据结构如下
```{r}
library(ggplot2)
df <- ToothGrowth
df$dose <- as.factor(df$dose)
head(df)
```
```
##    len supp dose
## 1  4.2   VC  0.5
## 2 11.5   VC  0.5
## 3  7.3   VC  0.5
## 4  5.8   VC  0.5
## 5  6.4   VC  0.5
## 6 10.0   VC  0.5
```
接下来我们利用这个数据绘制带有标准差的直方图。

## 02. 计算函数
首先我们需要做一个函数计算分组计算我们感兴趣变量的平均数及标准差。

```{r}
# function to calculate the mean and standard deviation for each group
# data: a data frame 
# varname: the name of a column containing the variable to be summarized
# groupnames: vector of column names to be used as grouping variable
data_summary <- function(data, varname, groupnames){
  require(plyr)
  summary_func <- function(x, col){
    c(mean = mean(x[[col]], na.rm = T),
      sd = sd(x[[col]], na.rm = T))
  }
  data_sum <- ddply(data, groupnames, .fun = summary_func, varname)
  data_sum <- rename(data_sum, c("mean" = varname))
  return(data_sum)
}
```
测试下新的函数功能
```{r}
df2 <- data_summary(ToothGrowth, varname = "len", groupnames = c("supp", "dose"))
df2$dose <- as.factor(df2$dose)
head(df2)
```
```
##   supp dose   len       sd
## 1   OJ  0.5 13.23 4.459709
## 2   OJ    1 22.70 3.910953
## 3   OJ    2 26.06 2.655058
## 4   VC  0.5  7.98 2.746634
## 5   VC    1 16.77 2.515309
## 6   VC    2 26.14 4.797731
```

## 03. 绘图
使用ggplot2绘图
```
library(ggplot2)
# Default bar plot
p<- ggplot(df2, aes(x=dose, y=len, fill=supp)) + 
  geom_bar(stat="identity", color="black", position=position_dodge()) +
  geom_errorbar(aes(ymin=len-sd, ymax=len+sd), width=.2, position=position_dodge(.9)) 

# Finished bar plot
p+labs(title="Tooth length per dose", x="Dose (mg)", y = "Length")+
   theme_classic() +
   scale_fill_manual(values=c('#999999','#E69F00'))
```

![](https://upload-images.jianshu.io/upload_images/3014937-2551cabcdacda28c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
