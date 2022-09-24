---
title: matplotlib-finance查找库位置并从GitHub安装库
author: Liang
date: '2018-11-24'
slug: matplotlib-finance查找库位置并从GitHub安装库
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
# 1. 问题
尝试用[python](http://www.classnotes.cn/tag/python/ "python")做个股票绘图软件，要用到finance库，于是开始导入：
```
import matplotlib.finance as mpf
```
结果执行的时候直接报错：
```
ImportError: No module named finance
```
开始还没有安装模块，就专门装了个 finance 模块，使用 import finance 导入，错误倒是没有了，但是 finance 中没有想要的函数，根本无法导出股票数据。去查看 matplotlib 的文档说明，在matplotlib2.2.2的API中有这么一段话：

>The `matplotlib.finance`, `mpl_toolkits.exceltools` and `mpl_toolkits.gtktools` modules have been removed. `matplotlib.finance` remains available at [https://github.com/matplotlib/mpl_finance](https://github.com/matplotlib/mpl_finance).

finance这个模块竟然被删除了！！！并且就是从2.2.2版本开始

# 2. 解决

查找matplotlib安装位置
```
import matplotlib
print matplotlib.__file__
```
进入到该位置下从GitHub下载库
```
git clone git@github.com:matplotlib/mpl_finance.git
#安装
python setup.py install
```
安装好之后需要重启Jupyter notebook。
加载库
```
import mpl_finance as mpf
```
