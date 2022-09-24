---
title: 为Jupyter-Notebook添加目录
author: Liang
date: '2018-11-24'
slug: 为Jupyter-Notebook添加目录
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
从R的RMarkdown转到Python的Jupyter Notebook的时候会发现一个问题. 使用RStudio生成RMarkdown的时候, 可以添加目录(Table of Contents, TOC).  在RStudio添加一个目录, 目录里面的内容根据RMarkdown每一个标题自动生成. 这样只需要点击目录里面相应的内容, 就可以很快的跳到RMarkdown对应的地方，非常有效率。但是很可惜的是, 默认Jupyter Notebook是没有生成目录这个功能的。但是我们可以通过Jupyter Notebook extensions开启这个功能。

## 2. 解决

第一步, 安装 Jupyter Notebook

这个是必须的. 如果还没安装的话, 建议安装 [anaconda](http://link.zhihu.com/?target=https%3A//www.continuum.io/downloads)

第二步, 安装Jupyter Notebook extensions

```
conda install -c conda-forge jupyter_contrib_nbextensions
```

第三步, 开启toc2插件

运行Jupyter Notebook, 在打开的Notebook界面里, 你会发现多了一个Nbextensions,点击这个tab, 会有如下界面

![](http://upload-images.jianshu.io/upload_images/3014937-afa984e03d8b6ede.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

勾选Table of Contents (有的版本是toc2). 然后创建或者打开一个Jupter Notebook

第四步, 生成目录

在Notebook上面选项中,多了一个生成目录图标, 如下图中最右边的图标.![](http://upload-images.jianshu.io/upload_images/3014937-f50d55a8d1af7ff1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

点击这个图标就会生成一个目录. 在Notebook里添加标题(也就是用###生成的Markdown内容)会自动添加到目录里面. 在目录上面, 有个小的n图标, 这表示自动对每个标题编号, 点击这个图标可以打开或者关闭这个功能。

## 3. 总结
Rmarkdown和Jupyter notebook用来做轻量级的编程都是非常好的，他们彼此之间的相似点也非常多，这两个工具某种程度上也降低了R和Python语言学习门槛，可以花更多的时间在这两个工具上。
