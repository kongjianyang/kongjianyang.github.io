---
title: Python下负责数据分析的库
author: Liang
date: '2018-11-25'
slug: Python下负责数据分析的库
categories:
  - 大蟒笔记
tags: []
lastmod: '2018-11-25T13:22:17-05:00'
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

Numpy: 基础的数学计算模块，以矩阵为主,纯数学。

pandas 是基于 NumPy 的一个 Python 数据分析包，主要目的是为了数据分析。它提供了大量高级的数据结构和对数据处理的方法。 pandas 有两个主要的数据结构：Series 和 DataFrame。

Series = 一维数组 + 数据标签（索引） Series相当于数组numpy.array DataFrame是一个表格型的数据结构，是以一个或多个二维块存放的数据表格（层次化索引），DataFrame既有行索引还有列索引，它有一组有序的列，每列既可以是不同类型（数值、字符串、布尔型）的数据，或者可以看做有Series组成的字典。

Series: 一组数组（列表或元组），series除了一组数据外还包括一组索引（即只有行索引），索引可自行定义也可利用Series(),自动生成索引； dataframe: 是表格型数据，既有行索引又有列索引，每列数据可以为不同类型数据（数值、字符串、布尔型值），可利用DataFrame（其他数据，dataframe属性)指定dataframe的属性创建dataframe。

Pandas: 提供了一套名为DataFrame的数据结构，适合统计分析中的表结构,在上层做数据分析。

SciPy: 基于Numpy，提供方法(函数库)直接计算结果，封装了一些高阶抽象和物理模型。比方说做个傅立叶变换，这是纯数学的，用Numpy；做个滤波器，这属于信号处理模型了，在Scipy里找。

简洁的说:

NumPy：N维数组容器

SciPy：科学计算函数库

Pandas：表格容器

非数学研究,建议直接入手pandas,包含基础的Numpy方法。

matplotlib是基于Python语言的开源项目，旨在为Python提供一个数据绘图包。matplotlib是受MATLAB的启发构建的。MATLAB是数据绘图领域广泛使用的语言和工具。MATLAB语言是面向过程的。

Seaborn是基于matplotlib的Python可视化库。 它提供了一个高级界面来绘制有吸引力的统计图形。Seaborn其实是在matplotlib的基础上进行了更高级的API封装，从而使得作图更加容易，不需要经过大量的调整就能使你的图变得精致。但应强调的是，应该把Seaborn视为matplotlib的补充，而不是替代物。

sklearn是一个Python第三方提供的非常强力的机器学习库，它包含了从数据预处理到训练模型的各个方面。
