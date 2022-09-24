---
title: 服务器端使用Jupyter-Hub及相关配置
author: Liang
date: '2018-11-24'
slug: 服务器端使用Jupyter-Hub及相关配置
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
加载anaconda模块
```
module load anaconda/5.0.0-py36
```
创建自己的环境
```
conda create -n py36 python=3.6 ipython ipykernel
```
查看当前环境
```
conda info --envs
```
激活环境
```
source activate py36
```
安装nb_conda以在Jupyter notebook中调用不同的环境
```
conda install nb_conda
```
启动Jupyter notebook
```
jupyter notebook
```
终端运行jupyter notebook后打开了jupyter的网页，关闭jupyter的网页后同时按下ctrl和C键退出终端jupyter notebook。
k
完成之后返回原始环境
```
source deactivate py36
```
