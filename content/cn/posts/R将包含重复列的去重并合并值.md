---
title: R将包含重复列的去重并合并值
author: Liang
date: '2018-11-24'
slug: R将包含重复列的去重并合并值
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
假设我们有数据框df如下：
```
Chr start   stop    ref alt Hom/het ID  
chr1    5179574 5183384 ref Del Het 719  
chr1    5179574 5184738 ref Del Het 915  
chr1    5179574 5184738 ref Del Het 951  
chr1    5336806 5358384 ref Del Het 376  
chr1    5347979 5358384 ref Del Het 228  
```

所示ID915和951前面的部分都重复了，现在我们想把它变成如下

```
Chr start   stop    ref alt Hom/het ID  
chr1    5179574 5183384 ref Del Het 719  
chr1    5179574 5184738 ref Del Het 915, 951 
chr1    5336806 5358384 ref Del Het 376  
chr1    5347979 5358384 ref Del Het 228  
```

我们可以根据以下命令进行实现
```
df1 <- aggregate(df[7], df[-7], unique)
# 或者
df2 <- aggregate(df[7], df[-7], FUN = function(X) paste(unique(X), collapse=", "))
```
# 2. 解释
aggregate函数应该是数据处理中常用到的函数，它首先将数据进行分组（按行），然后对每一组数据进行函数统计。简单说有点类似sql语言中的group by，可以按照要求把数据打组聚合，然后对聚合以后的数据进行加和、求平均等各种操作。

>applying a function specified by the FUN parameter to each column of sub-data.frames defined by the by input parameter.



```
aggregate(x ,by,FUN )    
# x：待折叠的数据 by:统计标量   FUN 折叠计算
```
所以上面的命令意味着将除去ID的数据按照行作为统计标量（by）进行ID选择，将选到的ID作为要进行操作的对象输入到FUN中。


