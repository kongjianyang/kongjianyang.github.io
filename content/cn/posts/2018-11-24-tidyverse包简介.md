---
title: tidyverse包简介
author: Liang
date: '2018-11-24'
slug: tidyverse包简介
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
tidyverse包是对一些具有相同思想，且可以一同工作的R包的收集。
载入tidyverse包的时候提醒哪些包是一同载入的，哪些包是有冲突的。
```
> library(tidyverse)
── Attaching packages ─────────────────────────────────────── tidyverse 1.2.1 ──
✔ ggplot2 2.2.1     ✔ purrr   0.2.5
✔ tibble  1.4.2     ✔ dplyr   0.7.6
✔ tidyr   0.8.1     ✔ stringr 1.3.1
✔ readr   1.1.1     ✔ forcats 0.3.0
── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
✖ dplyr::filter() masks stats::filter()
✖ dplyr::lag()    masks stats::lag()
```
这些包按照功能可以分为数据导入、数据整理、数据转换、可视化、建模、编程。

# 1. 数据导入
- readr：read_csv(); read_tsv(); read_delim(); read_fwf(); read_table(); - read_log();
- readxl：read_xls(); read_xlsx();
- haven：打开SAS 、SPSS、Stata等外部数据

这里要提一下，read.table()是R自带的，而read_table()是readr包有的。

# 2. 数据整理
- tibble: 对data.frame的改进，一种数据格式
- tidyr:清洗数据 gather(); spread();

Tibble是数据框的一种形式，但是比数据框更整洁，结构更加紧凑，可以理解为tidy table之意。可以通过转置函数as_tibble()来将data.frame格式的数据转化为tibble格式的数据。tibble数据输出到console上只会显示前10行，和所有列，这和data.frame不同。

spread函数

分散函数是将变量中的值拆分成新的变量，这个过程概括为就是将为成「列」的值，进行拆分，并指定其他列作为「值」，组合成「键-值」对的形式

## spread函数

```
#spread函数语法
spread(data, key= , value=, )
#以table2数据集为例子
table2 #查看数据集
table2 %>% 
  spread(key = 'type', value = 'count')
```
将type列的值拆分作为「键」，count列的值则作为每个键下的「值」，进而将变量值进行拆分。

## gather函数

```
#gather函数语法
gather(data, set_colums, key= , value=, ...)

# 以tidyverse包中的table4a数据为例
table4a #查看数据集
table4a %>% 
  gather(`1999`, `2000`, 
  key = 'year', value = 'cases')
```

# 3. 数据转换
- dplyr:处理数据 mutate();select(); filter(); summarise();arrange();
- lubridate：处理时间数据
- stringr：处理字符串类型
- forcats：处理因子变量（factors）

dplyr包必须掌握的一些基础且常用的功能：

>变量筛选函数 select
记录筛选函数 filter
排序函数 arrange
变形（计算）函数 mutate
汇总函数 summarize
分组函数 group_by
多步操作连接符 %>%
随机抽样函数 sample_n,sample_frac

# 4. 数据可视化
- ggplot2

# 5. 编程
- magrittr：管道运算符
- purrr：通过提供一些完整连贯用于函数和向量的工具集，增强R的函数编程。

## magrittr常见功能
### 5.1 %>% 从左向右顺序操作

```
x %>% f 等于 f(x)
x %>% f(y) 等于 f(x, y)
x %>% f %>% g %>% h 等于 h(g(f(x)))
x %>% f(y, .) 等于 f(y, x)
x %>% f(y, z = .) 等于 f(y, z = x)
```

### 5.2 %T>% 向左操作符

```
rnorm(200) %>%
matrix(ncol = 2) %T>%
plot %>% # plot的结果我们不需要，%T>%帮助我们把左边的结果传给plot后保留下来再传给colSums。
colSums
```
![image](http://upload-images.jianshu.io/upload_images/3014937-05353577cb9f17f3.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 5.3 %$% 解释操作符
%$% 的作用是把左侧数据的属性名传给右侧，让右侧的调用函数直接通过名字，就可以获取左侧的数据。比如，我们获得一个data.frame类型的数据集，通过使用 %$%，在右侧的函数中可以直接使用列名操作数据。
 ```
> set.seed(1)
> data.frame(x=1:10,y=rnorm(10),z=letters[1:10]) %$% .[which(x>5),]
    x          y z
6   6 -0.8204684 f
7   7  0.4874291 g
8   8  0.7383247 h
9   9  0.5757814 i
10 10 -0.3053884 j
```
同时这不能被%>%所实现

### 5.4 %<>% 复合赋值操作符
%<>%复合赋值操作符， 功能与 %>% 基本是一样的，对了一项额外的操作，就是把结果写到左侧对象

```
> set.seed(1)
> x<-rnorm(100) %<>% abs %>% sort %>% head(10)
> x
```
注意 %<>% 必须要用在第一个管道的对象处，才能完成赋值的操作
