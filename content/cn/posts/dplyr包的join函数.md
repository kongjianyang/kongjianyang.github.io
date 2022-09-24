---
title: dplyr包的join函数
author: Liang
date: '2018-11-24'
slug: dplyr包的join函数
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
dplyr中有非常多非常有用的功能，例如filter()，arrange()，select()，mutate()，group_by()。但是这篇教程是谈join函数。

join函数在dplyr包中是个系列函数。 join函数：
```
join(x, y, by = NULL, copy = FALSE, ...)
```
- x,y 为合并的数据框，不要求x,y中排序列唯一
- by 为排序依据，默认值Null时按名字相同的量匹配,此时,要求必须有相同列名的列
- join为系列函数，包括inner_join、left_join、semi_join和anti_join函数

### full_join()
full_join连接后的记录数等于”共有的记录数+a独有的记录数+b独有的记录数“，结果可以理解为a、b的并集。

### inner_join
inner_join连接后的记录数等于”共有的记录数“， 也就是5，结果可以理解为a、b的交集，R语言中的merge函数也可以实现。

### left_join
left_join连接后的记录数等于”a的记录数“，当然，a是需要放在第一个参数。

### right_join
right_join连接后的记录数等于”b的记录数“。

