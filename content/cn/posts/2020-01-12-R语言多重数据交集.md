---
title: "R语言多重数据交集"
date: 2020-01-12T13:42:27-05:00
author: KJY
slug: multiple_intersects
draft: false
toc: true
categories:
  - test
tags:
  - article

---

一个简单的例子讲解怎么做多重数据的交集



首先创造一个嵌套的list

```{r}
l <- list(A=c("one", "two", "three", "four"), B=c("one", "two"), C=c("two", "four", "five", "six"), D=c("six", "seven"))

crossprod(table(stack(l)))
```

```
l

$A
[1] "one"   "two"   "three" "four" 

$B
[1] "one" "two"

$C
[1] "two"  "four" "five" "six" 

$D
[1] "six"   "seven"
```





```
crossprod(table(stack(l)))

#的到结果

   ind
ind A B C D
  A 4 2 2 0
  B 2 2 1 0
  C 2 1 4 1
  D 0 0 1 2
```

开始解释这些命令

首先是stack命令，将潜逃列表变平

```
> stack(l)
   values ind
1     one   A
2     two   A
3   three   A
4    four   A
5     one   B
6     two   B
7     two   C
8    four   C
9    five   C
10    six   C
11    six   D
12  seven   D
```

Stacking vectors concatenates multiple vectors into a single vector along with a factor indicating where each observation originated. Unstacking reverses this operation.

![stack and unstack function in R - DataScience Made Simple](https://www.datasciencemadesimple.com/wp-content/uploads/2020/07/stack-and-unstack-function-in-R-1.png?ezimgfmt=rs:303x295/rscb1/ng:webp/ngcb1)

然后使用table命令就比较好理解



```
table(stack(l))
       ind
values  A B C D
  five  0 0 1 0
  four  1 0 1 0
  one   1 1 0 0
  seven 0 0 0 1
  six   0 0 1 1
  three 1 0 0 0
  two   1 1 1 0
```

最后加上crossprod是一个妙用

crossprod本来是计算矩阵内积的

