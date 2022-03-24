---
title: 利用ggplot绘制带百分比饼图
author: Liang
date: '2018-11-24'
slug: 利用ggplot绘制带百分比饼图
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
有的时候我们需要利用饼图进行统计结果的占比展示，在R中可以利用ggplot进行绘制，但是ggplot中实际上并没有直接的函数可以绘制饼图，饼图实际上是`geom_bar`的一个变形。下面我们就来看看如何利用ggplot绘制带百分比的饼图。

## 2. 步骤

```
library(dplyr)
library(ggplot2)
library(ggmap) # 为了引用主题theme_nothing，用来消除原始ggplot绘图自带的一切标签
df <- data.frame(value = c(52, 239, 9),
                 Group = c("Positive", "Negative", "Neutral")) %>%
   # factor levels need to be the opposite order of the cumulative sum of the values
   mutate(Group = factor(Group, levels = c("Neutral", "Negative", "Positive")),
          cumulative = cumsum(value),
          midpoint = cumulative - value / 2,
          label = paste0(Group, " ", round(value / sum(value) * 100, 1), "%"))

ggplot(df, aes(x = 1, weight = value, fill = Group)) +
   geom_bar(width = 1, position = "stack") +
   coord_polar(theta = "y") ## 以y轴建立极坐标
   +
   geom_text(aes(x = 1.3, y = midpoint, label = label)) ## 加上百分比标签的位置和数值
   +
   theme_nothing()   
```
绘制得到的图：
![绘制得到的饼图](https://upload-images.jianshu.io/upload_images/3014937-5811bd9a301c948c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 3.总结
利用ggplot能够绘制非常漂亮的饼图，但是一定要注意插入百分比标签的位置。
