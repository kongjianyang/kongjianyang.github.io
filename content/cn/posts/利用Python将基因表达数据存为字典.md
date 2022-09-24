---
title: 利用Python将基因表达数据存为字典
author: Liang
date: '2018-11-24'
slug: 利用Python将基因表达数据存为字典
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
## 1. 问题
我们的基因表达数据如下表所示
```
 cond1  cond2   cond3
gene1  1.57   2.52   12.05
gene2  0.01   8.90   31.20   
gene3  57.05  12.14  50.76
```
我们希望能够利用Python将这个基因表达文件存为一个dictionary，这样我们能很容易的通过基因名和样品名得到基因的表达量，我们还可以筛选表达量大于某个值的所有基因和样品， 如下：
```
myDict[('gene1','cond1')] = 1.57
myDict[('gene1','cond2')] = 2.52
myDict[('gene1','cond3')] = 12.05
myDict[('gene2','cond1')] = 0.01
...
```

## 2. Python解决
利用Python的逻辑是首先将基因名和样品名存为一个元祖，然后将此元祖作为字典里面的key，将基因表达量作为字典里面的value。
```
data = open(input_file, 'rU')
l = data.readline().rstrip("\r\n")
conds = l.split("\t")
conds.pop(0)
d = dict()
for l in data:
    l = l.rstrip("\r\n")
    vals = l.split("\t")
    gene = vals[0]
    vals.pop(0)
    valIdx = 0
    for val in vals:
        cond = conds[valIdx]
        d[(gene, cond)] = float(val)
        valIdx += 1
## 额外部分，想得到基因表达量大于12的基因和样品
value12={k:v for k,v in d.items() if v>12}
for items in value12.keys():
    print (str(items) +'\t' + str(value12[items]))
```
## 3. 总结
解决这个问题的做法比较多，这不是唯一的方法，甚至利用R解决可能会更加简洁。但是这种方法利用了比较多的Python中的基础知识，值得学习和借鉴。
