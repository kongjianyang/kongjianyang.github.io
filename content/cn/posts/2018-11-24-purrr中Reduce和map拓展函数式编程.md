---
title: purrr中Reduce和map拓展函数式编程
author: Liang
date: '2018-11-24'
slug: purrr中Reduce和map拓展函数式编程
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
purrr 是一个拓展R函数式编程能力的包。在这篇文章中，介绍在purrr中几个非常实用的函数。

purrr已经集成在tidyverse中，所以如果已经安装了tidyverse的话则不需要重复安装了。

# 1. map 家族
## 1.1 map函数
```{r}
library(purrr)
numbers <- list(11, 12, 13, 14)
map(numbers, sqrt)
```
得到的结果如下，返回一个列表
```
[[1]]
[1] 3.316625

[[2]]
[1] 3.464102

[[3]]
[1] 3.605551

[[4]]
[1] 3.741657
```
## 1.2 map_dbl函数
```{r}
map_dbl(numbers, sqrt)
```
返回一个实数原子列表(atomic list)
```
[1] 3.316625 3.464102 3.605551 3.741657
```

## 1.3 map_if函数
map_if函数会对于list进行一个逻辑判断，如果是真则执行命令，否则不执行，保留原值。
```{r}
#创造一个辅助函数，如果为偶数则返回TRUE
is_even <- function(x){
  !as.logical(x %% 2)
}
map_if(numbers, is_even, sqrt)
```
```
[[1]]
[1] 11

[[2]]
[1] 3.464102

[[3]]
[1] 13

[[4]]
[1] 3.741657
```

## 1.4 map_at函数
map_at函数是给定位置向量，然后执行命令。
```{r}
map_at(numbers, c(1,3), sqrt)
```

```
[[1]]
[1] 3.316625

[[2]]
[1] 12

[[3]]
[1] 3.605551

[[4]]
[1] 14
```

## 1.5 map2函数
map_2函数可以输入2个参数，同时将两个列表映射到一个函数中。
```{r}
numbers2 <- list(1, 2, 3, 4)
map2(numbers, numbers2, `+`)
```

```
[[1]]
[1] 12

[[2]]
[1] 14

[[3]]
[1] 16

[[4]]
[1] 18

```
或者我们也可以使用pmap()函数将任意数量的列表映射到任何函数。 
```{r}
x <- list(1, 10, 100)
y <- list(1, 2, 3)
z <- list(5, 50, 500)
pmap(list(x, y, z), sum)
```

```
[[1]]
[1] 7

[[2]]
[1] 62

[[3]]
[1] 603
```

# 2.debug类函数
## 2.1 possibly函数
possibly()函数是即使报错，也要继续执行你的循环，结合map使用可以在loop中不中断循环，当然这种功能也可以使用tryCatch函数。
```{r}
possible_sqrt <- possibly(sqrt, otherwise = NA_real_)
numbers_with_error <- list(1, 2, 3, "spam", 4)
map(numbers_with_error, possible_sqrt)
```

```
[[1]]
[1] 1

[[2]]
[1] 1.414214

[[3]]
[1] 1.732051

[[4]]
[1] NA

[[5]]
[1] 2
```

## 2.2 safely函数
safely函数与possibly函数很相似，但是它会在列表中返回列表。因此元素是结果和伴随错误消息的列表。如果没有错误，则返回NULL。如果有错误，则返回错误信息。个人觉得没有possibly好用。

# 3. 累加操作
## 3.1 reduce函数

```{r}
reduce(numbers, `*`)
```
```
[1] 24024
```
reduce函数非常常用，你可以reduce任何东西。
