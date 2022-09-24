---
title: Jupyter-Notebook进阶使用教程
author: Liang
date: '2018-11-24'
slug: Jupyter-Notebook进阶使用教程
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
### 1.前略
读博之路上不打算每天都全心全意的投入到老板给的课题中了，晚上八点到十一点学习点新东西。

### 2. 起因
最近打算好好学习下统计学和机器学习方面的知识，我的习惯是学习新内容前需要有好的记录工具，否则就坚持不下去，容易气馁。之前学习R语言的时候爱上了Rstudio和Rmd这种交互式文档语言(interactive language)，但是因为R更多的是用来做统计分析的，功能还是比较薄弱，不能适应复杂的任务，因此需要开辟新的语言进行学习，之前也学习过python，了解其语法，但是没有坚持的原因有两点，其一本科的时候没有项目进行练手，其二是因为没有找到合适自己的IDE。现在重新学习语言，找到了Jupyter Notebook，类似与Rstudio一样可以做到所写即所得。所以开始熟悉怎么使用Jupyter Notebook，将一些技巧记录在此。

### 3.技巧

#### 3.1 配置及打开
安装方法之类的不多讲，安装之后希望在任何地方打开Jupyter的话在Terminal下cd到目标文件夹，键入Jupyter Notebook自然能在你的浏览器下打开Jupyter，则工作目录即为你的目标目录。

希望查看Jupyter的配置文件的话键入`jupyter notebook --generate-config`则能看到配置文件。
#### 3.2 加载本地.py文件
还可以将本地的.py文件load到jupyter的一个cell中
例如有一个test.py文件，需要将其载入到jupyter的一个cell中 
test.py内容如下：
```
import caffe
SolverName = "/root/workspace"
sovler = caffe.AdamSolver(SolverName)
```
在需要导入该段代码的cell中只需要输入如下
```
%load test.py #test.py是当前路径下的一个python文件
```
#### 3.3 作为unix command使用
jupyter的cell还可以作为unix command使用，具体方法为：在unix command前面加入一个感叹号“！”
```
例子： 
查看python版本：!python --version 
运行python文件：!python myfile.py
```
#### 3.4 添加目录功能
还可以为Jupyter Notebook添加目录功能，原始的Jupyter是不支持markdown添加目录功能的，实际上，可以利用[Jupyter notebook extensions](https://github.com/ipython-contrib/jupyter_contrib_nbextensions)去使得这种功能实现，具体方法： 

        `conda install -c conda-forge jupyter_contrib_nbextensions`

打开Jupyter Notebook，在它的（新增的）Nbextensions标签下勾选“Table of Contents(2)” ，关于extensions还有很多其他的功能可以自行查看。

#### 3.5 魔法命令 (magic function)

所有以%开头的方法，都是Jupyter里面的所谓魔术方法(Magic function)，也就是ipython内置的一些方法。需要注意的是，魔术方法有%和%%之分，比如`%timeit`和`%%timeit`。在ipython中有专门的叫法，前者叫line magic后者叫cell magic。顾名思义，前者是专门针对一行的命令，后者针对多行的命令。

通过`%lsmagis`可以查看所有的magic命令，使用?或者??可以查看该命令的信息，后者可以查看源码。如： `%alias?`，会出现该方法的描述。

3.6 Jupyter中使用R
安装IRkernel
```
conda install -c r ipython-notebook r-irkernel
```
