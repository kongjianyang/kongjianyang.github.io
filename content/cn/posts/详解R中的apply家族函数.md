---
title: 详解R中的apply家族函数
author: Liang
date: '2018-11-24'
slug: 详解R中的apply家族函数
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
R语言中提供了一系列apply()的函数，为数据分析中Split-Apply-Combine的策略提供了简洁方便的实现，这些函数的基本工作流程都是首先将数据按照某种规则划分（split）为较小的几部分，然后对各个部分应用（apply）某些操作，再将结果整合（combine）起来。关于Split-Apply-Combine策略的详细内容，可以参考Hadley Wickham的The Split-Apply-Combine Strategy for Data Analysis一文。

apply()家族主要有以下7类函数：
```
base::apply             Apply Functions Over Array Margins
base::by                Apply a Function to a Data Frame Split by Factors
base::eapply            Apply a Function Over Values in an Environment
base::lapply            Apply a Function over a List or Vector
base::mapply            Apply a Function to Multiple List or Vector Arguments
base::rapply            Recursively Apply a Function to a List
base::tapply            Apply a Function Over a Ragged Array
```
## 1. apply()函数
```
# create a matrix of 10 rows x 2 columns
m <- matrix(c(1:10, 11:20), nrow = 10, ncol = 2)
# mean of the rows
apply(m, 1, mean)
 [1]  6  7  8  9 10 11 12 13 14 15
# mean of the columns
apply(m, 2, mean)
[1]  5.5 15.5
# divide all values by 2
apply(m, 1:2, function(x) x/2)
      [,1] [,2]
 [1,]  0.5  5.5
 [2,]  1.0  6.0
 [3,]  1.5  6.5
 [4,]  2.0  7.0
 [5,]  2.5  7.5
 [6,]  3.0  8.0
 [7,]  3.5  8.5
 [8,]  4.0  9.0
 [9,]  4.5  9.5
[10,]  5.0 10.0

```
## 2. by()函数
by函数是对于数据框按照因子分割然后执行某函数(Apply a Function to a Data Frame Split by Factors)

```
attach(iris)
head(iris)
  Sepal.Length Sepal.Width Petal.Length Petal.Width Species
1          5.1         3.5          1.4         0.2  setosa
2          4.9         3.0          1.4         0.2  setosa
3          4.7         3.2          1.3         0.2  setosa
4          4.6         3.1          1.5         0.2  setosa
5          5.0         3.6          1.4         0.2  setosa
6          5.4         3.9          1.7         0.4  setosa
 
# get the mean of the first 4 variables, by species
by(iris[, 1:4], Species, colMeans)
Species: setosa
Sepal.Length  Sepal.Width Petal.Length  Petal.Width 
       5.006        3.428        1.462        0.246 
------------------------------------------------------------ 
Species: versicolor
Sepal.Length  Sepal.Width Petal.Length  Petal.Width 
       5.936        2.770        4.260        1.326 
------------------------------------------------------------ 
Species: virginica
Sepal.Length  Sepal.Width Petal.Length  Petal.Width 
       6.588        2.974        5.552        2.026
```

## 3. eapply()函数

eapply函数很少用，它针对的对象是不同环境中的变量计算，返回的结果是一个list.
```
# a new environment
e <- new.env()
# two environment variables, a and b
e$a <- 1:10
e$b <- 11:20
# mean of the variables
eapply(e, mean)
$b
[1] 15.5
 
$a
[1] 5.5
```
正常情况我们不会创造自己的环境，但是很多的R包会使用新的环境。

## 4. lapply()函数
lapply()中的“l”代表list，它接受list作为输入，并将指定的操作应用于列表中的所有元素。在list上逐个元素调用FUN。可以用于dataframe上，因为dataframe是一种特殊形式的list
```
# create a list with 2 elements
l <- list(a = 1:10, b = 11:20)
# the mean of the values in each element
lapply(l, mean)
$a
[1] 5.5
 
$b
[1] 15.5
 
# the sum of the values in each element
lapply(l, sum)
$a
[1] 55
 
$b
[1] 155
```

## 5. sapply()函数
sapply()中的代表simplify， 其与lapply()的不同之处在于sapply()会尝试对结果进行简化，使用sapply()替代lapply()重复前面例子的操作：
```
# create a list with 2 elements
l <- list(a = 1:10, b = 11:20)
# mean of values using sapply
sapply(l, mean)
#a    b 
#5.5 15.5 
l.mean <- sapply(l, mean)
# what type of object was returned?
class(l.mean)
#[1] "numeric"
# it's a numeric vector, so we can get element "a" like this
l.mean[['a']]
#[1] 5.5
```
sapply()自动将结果转换为了character的vector。具体来说，如果apply的结果是一个所有元素长度都为1的list，sapply()会将结果转换为vector；如果apply的结果是一个所有元素长度都相等且大于1的list，sapply()会将结果转换为matrix；如果sapply()无法判断简化规则，则不对结果进行简化，返回list，此时得到的结果和lapply()相同。

## 6. vapply()函数
vapply()与sapply()相似，他可以预先指定的返回值类型。使得得到的结果更加安全。
vapply基本格式是vapply(X, FUN, FUN.VALUE)，其中FUN.VALUE可以写入自己想要的输出格式。
```
l <- list(a = 1:10, b = 11:20)
# fivenum of values using vapply
l.fivenum <- vapply(l, fivenum, c(Min.=0, "1st Qu."=0, Median=0, "3rd Qu."=0, Max.=0))
class(l.fivenum)
[1] "matrix"
# let's see it
l.fivenum
           a    b
Min.     1.0 11.0
1st Qu.  3.0 13.0
Median   5.5 15.5
3rd Qu.  8.0 18.0
Max.    10.0 20.0
```
## 7. replicate()函数
replicate()函数，它可以将某个函数重复运行N次，常常用来生成较复杂的随机数。
```
replicate(10, rnorm(10))
             [,1]        [,2]        [,3]       [,4]        [,5]         [,6]
 [1,]  0.67947001 -1.94649409  0.28144696  0.5872913  2.22715085 -0.275918282
 [2,]  1.17298643 -0.01529898 -1.47314092 -1.3274354 -0.04105249  0.528666264
 [3,]  0.77272662 -2.36122644  0.06397576  1.5870779 -0.33926083  1.121164338
 [4,] -0.42702542 -0.90613885  0.83645668 -0.5462608 -0.87458396 -0.723858258
 [5,] -0.73892937 -0.57486661 -0.04418200 -0.1120936  0.08253614  1.319095242
 [6,]  2.93827883 -0.33363446  0.55405024 -0.4942736  0.66407615 -0.153623614
 [7,]  1.30037496 -0.26207115  0.49818215  1.0774543 -0.28206908  0.825488436
 [8,] -0.04153545 -0.23621632 -1.01192741  0.4364413 -2.28991601 -0.002867193
 [9,]  0.01262547  0.40247248  0.65816829  0.9541927 -1.63770154  0.328180660
[10,]  0.96525278 -0.37850821 -0.85869035 -0.6055622  1.13756753 -0.371977151
             [,7]        [,8]       [,9]       [,10]
 [1,]  0.03928297  0.34990909 -0.3159794  1.08871657
 [2,] -0.79258805 -0.30329668 -1.0902070  0.73356542
 [3,]  0.10673459 -0.02849216  0.8094840  0.06446245
 [4,] -0.84584079 -0.57308461 -1.3570979 -0.89801330
 [5,] -1.50226560 -2.35751419  1.2104163  0.74650696
 [6,] -0.32790991  0.80144695 -0.0071844  0.05742356
 [7,]  1.36719970  2.34148354  0.9148911  0.20451421
 [8,] -0.51112579 -0.53658159  1.5194130 -0.94250069
 [9,]  0.52017814 -1.22252527  0.4519702  0.08779704
[10,]  1.35908918  1.09024342  0.5912627 -0.20709053
```

## 8. mapply()函数
mapply是多变量版的sapply，参数(...)部分可以接收多个数据，mapply将FUN应用于这些数据的第一个元素组成的数组，然后是第二个元素组成的数组，以此类推。要求多个数据的长度相同，或者是整数倍关系。返回值是vector或matrix，取决于FUN返回值是一个还是多个。
```
mapply(sum, list(a=1,b=2,c=3), list(a=10,b=20,d=30))
 a  b  c 
11 22 33 
mapply(function(x,y) x^y, c(1:5), c(1:5))
[1]    1    4   27  256 3125
mapply(function(x,y) c(x+y, x^y), c(1:5), c(1:5))
     [,1] [,2] [,3] [,4] [,5]
[1,]    2    4    6    8   10
[2,]    1    4   27  256 3125
```
## 9.rapply()函数
Description: “rapply is a recursive version of lapply.”
apply是递归版的lappy。基本原理是对list作遍历，如果其中有的元素仍然是list，则继续遍历；对于每个非list类型的元素，如果其类型是classes参数指定的类型之一，则调用FUN。classes="ANY"表示匹配所有类型。
```
# let's start with our usual simple list example
l <- list(a = 1:10, b = 11:20)
# log2 of each value in the list
rapply(l, log2)
      a1       a2       a3       a4       a5       a6       a7       a8 
0.000000 1.000000 1.584963 2.000000 2.321928 2.584963 2.807355 3.000000 
      a9      a10       b1       b2       b3       b4       b5       b6 
3.169925 3.321928 3.459432 3.584963 3.700440 3.807355 3.906891 4.000000 
      b7       b8       b9      b10 
4.087463 4.169925 4.247928 4.321928
# log2 of each value in each list
rapply(l, log2, how = "list")
$a
 [1] 0.000000 1.000000 1.584963 2.000000 2.321928 2.584963 2.807355 3.000000
 [9] 3.169925 3.321928
 
$b
 [1] 3.459432 3.584963 3.700440 3.807355 3.906891 4.000000 4.087463 4.169925
 [9] 4.247928 4.321928
 
# what if the function is the mean?
rapply(l, mean)
   a    b 
 5.5 15.5
 
rapply(l, mean, how = "list")
$a
[1] 5.5
 
$b
[1] 15.5
```
## 10. tapply()函数
```
tapply(array, indices, margin, FUN=NULL, ...)
```
按indices中的值分组，把相同值对应下标的array中的元素形成一个集合，应用到FUN。类似于group by indices的操作。如果FUN返回的是一个值，tapply返回vector；若FUN返回多个值，tapply返回list。vector或list的长度和indices中不同值的个数相等。
```
> v <- c(1:5)
> ind <- c('a','a','a','b','b')
> tapply(v, ind)#指示分组的结果，按照ind进行了分组。
[1] 1 1 1 2 2
> tapply(v, ind, sum)#传递了sum函数，按照分组进行了计算。
a b 
6 9 
> tapply(v, ind, fivenum)#五分位数计算
$a
[1] 1.0 1.5 2.0 2.5 3.0

$b
[1] 4.0 4.0 4.5 5.0 5.0
```

```
> m <- matrix(c(1:10), nrow=2)
> m
     [,1] [,2] [,3] [,4] [,5]
[1,]    1    3    5    7    9
[2,]    2    4    6    8   10
> ind <- matrix(c(rep(1,5), rep(2,5)), nrow=2)
> ind
     [,1] [,2] [,3] [,4] [,5]
[1,]    1    1    1    2    2
[2,]    1    1    2    2    2
> tapply(m, ind)#按照ind对矩阵m进行了indices。
 [1] 1 1 1 1 1 2 2 2 2 2
> tapply(m, ind, mean)
1 2 
3 8 
> tapply(m, ind, fivenum)
$`1`
[1] 1 2 3 4 5

$`2`
[1]  6  7  8  9 10
```
