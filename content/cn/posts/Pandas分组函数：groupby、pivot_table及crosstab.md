---
title: Pandas分组函数：groupby、pivot_table及crosstab
author: Liang
date: '2018-11-24'
slug: Pandas分组函数：groupby、pivot_table及crosstab
categories:
  - 大蟒笔记
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
## 1. 起因
利用python的pandas库进行数据分组分析十分便捷，其中应用最多的方法包括：groupby、pivot_table及crosstab，以下分别进行介绍。

## 2. 详解
首先构造数据
```
import numpy as np
import pandas as pd
df = pd.DataFrame({'key1':['a','a','b','b','a'],'key2':['one','two','one','two','one'],'data1':np.random.randn(5),'data2':np.random.randn(5)}) 
```

![df数据结构](https://upload-images.jianshu.io/upload_images/3014937-11ff3c5d648d57f9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 2.1 group函数
分组groupby Pandas中最为常用和有效的分组函数。

1）按列分组

注意以下使用groupby()函数生成的group1是一个中间分组变量，为GroupBy类型。

```
group1 = df.groupby('key1')  
```

```
group2 = df.groupby(['key1','key2'])  
```

使用推导式[x for x in group1]可显示分组内容。

```
[x for x in group1]
```

```
[('a',       data1     data2 key1 key2
  0  1.830651  0.407903    a  one
  1 -0.973132 -0.056084    a  two
  4 -1.069184  0.043338    a  one), ('b',       data1     data2 key1 key2
  2 -0.477718 -1.488174    b  one
  3 -0.227680 -0.825671    b  two)]
```
在分组group1、group2上可以应用size()、sum()、count()等统计函数，能分别统计分组数量、不同列的分组和、不同列的分组数量。

```
group1.size()  
```
```
key1
a    3
b    2
dtype: int64
```

```
group1.sum() 
```

![](https://upload-images.jianshu.io/upload_images/3014937-adea589538eba249.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
对于分组的某一列或者多个列，应用agg(func)可以对分组后的数据应用func函数。例如：用group1['data1'].agg('mean')对分组后的’data1’列求均值。当然也可以推广到同时作用于多个列和使用多个函数上。

```
group1['data1'].agg(['mean','sum'])  
```
![](https://upload-images.jianshu.io/upload_images/3014937-70c021a78edf61fb.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


### 2.2 透视表pivot_table

pivot_table可以产生类似于excel数据透视表的结果，相当的直观。其中参数index指定“行”键，columns指定“列”键。

```
pd.pivot_table(df, index = 'key1', columns= 'key2')
```

![](https://upload-images.jianshu.io/upload_images/3014937-cea0b1f52aee88ed.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 2.3 交叉表crosstab
交叉表crosstab 可以按照指定的行和列统计分组频数，用起来非常方便；当然同样的功能也可采用groupby实现。

```
pd.crosstab(df.key1,df.key2, margins=True)
```

![](https://upload-images.jianshu.io/upload_images/3014937-127517add57dbc49.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 3. 总结

最近在学习《利用Python进行数据分析》，会把遇到的问题和学习到的知识写出来，希望不要弃坑。







