---
title: conda下多版本Python切换和配置
author: Liang
date: '2018-11-24'
slug: conda下多版本Python切换和配置
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
##1.问题
学习Python是目前十分火热的一个领域，但是Python3和Python2之间的切换和选择经常使人烦恼，多版本的Python之间经常会有冲突。解决这一问题的一个好的途径是安装anaconda进行环境和版本控制。

##2.教程
检测安装的conda版本，在终端输入命令：
```
conda --version
```
Conda会返回你安装Anaconda软件的版本。

升级当前版本conda，输入命令：
```
conda update conda
```
更新conda到最新版本之后，利用conda进行环境管理

创建一个新环境：
```
conda create -n python3
```
激活新环境：
```
source activate python3
```
列出所有的环境：
```
conda info --envs
```
会列出所有的环境，当前环境前面有*符号

切换环境：
```
source activate base
```
返回原环境：
```
source deactivate
```
给新环境安装Python3：
```
conda create -n python3 python=3
```
检查环境内的Python版本：
```
python --version
```
检查环境内的包：
```
conda list
```
查找一个包是否能够安装：
```
conda search beautifulsoup4
```
告知安装环境的名字并安装这个包：
```
conda install --name base beautifulsoup4
```
移除安装的包，必须告知移除包的环境：
```
conda remove -n base beautifulsoup4
```
移除一个环境：
```
conda remove -n python3 --all
```
##3.总结
以上是使用conda的一些基本命令，使用conda可以帮助我们很好的管理Python及其依赖的包的环境。
