---
title: R中的sweep函数
author: Liang
date: '2018-11-24'
slug: R中的sweep函数
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
### 函数的用途

base包中sweep()函数是处理统计量的工具。所以一般结合apply()函数来使用，一般我们需要将apply()统计出来的统计量要代回原数据集去对应操作的时候就需要用到sweep()。

> 扫除、清除也是sweep单词的本义。

### 函数的参数

```source-r
sweep(x, MARGIN, STATS, FUN = "-", check.margin = TRUE, ...)
```

*   x:即要处理的原数据集
*   MARGIN：对行或列，或者数列的其他维度进行操作
*   STATS：需要对原数据集操作用到的统计量
*   FUN：操作需要用到的四则运算，默认为减法"-"，当然可以修改成"+","*","/"即加、乘、除
*   check.margin:是否需要检查维度是否适宜的问题，默认为TRUE。
*   ……

### 实例分析
1、比如我们需要将原数据集所有数据都减去各列的平均数，所以我们需要用apply()计算出每列的平均数，然后用sweep()完成。

```{r}
require(stats)  # for mean
head(attitude, 10)
```

```
##    rating complaints privileges learning raises critical advance
## 1      43         51         30       39     61       92      45
## 2      63         64         51       54     63       73      47
## 3      71         70         68       69     76       86      48
## 4      61         63         45       47     54       84      35
## 5      81         78         56       66     71       83      47
## 6      43         55         49       44     54       49      34
## 7      58         67         42       56     66       68      35
## 8      71         75         50       55     70       66      41
## 9      72         82         72       67     71       83      31
## 10     67         61         45       47     62       80      41
```

```{r}
mean.att <- apply(attitude, 2, mean)
mean.att
```

```
##     rating complaints privileges   learning     raises   critical 
##      64.63      66.60      53.13      56.37      64.63      74.77 
##    advance 
##      42.93
```
所有数据都减去各列的平均数
```{r}
head(sweep(data.matrix(attitude), 2, mean.att, FUN = "-"), 10) 
```

```
##        rating complaints privileges learning  raises critical advance
##  [1,] -21.633      -15.6    -23.133 -17.3667  -3.633   17.233   2.067
##  [2,]  -1.633       -2.6     -2.133  -2.3667  -1.633   -1.767   4.067
##  [3,]   6.367        3.4     14.867  12.6333  11.367   11.233   5.067
##  [4,]  -3.633       -3.6     -8.133  -9.3667 -10.633    9.233  -7.933
##  [5,]  16.367       11.4      2.867   9.6333   6.367    8.233   4.067
##  [6,] -21.633      -11.6     -4.133 -12.3667 -10.633  -25.767  -8.933
##  [7,]  -6.633        0.4    -11.133  -0.3667   1.367   -6.767  -7.933
##  [8,]   6.367        8.4     -3.133  -1.3667   5.367   -8.767  -1.933
##  [9,]   7.367       15.4     18.867  10.6333   6.367    8.233 -11.933
## [10,]   2.367       -5.6     -8.133  -9.3667  -2.633    5.233  -1.933
```
sweep函数和apply函数相似，但是sweep主要用于array的一些分类计算，而apply更多的是矩阵计算，data.frame也行。array是高于2维的数据
