---
title: windows下的Linux子系统安装conda和jupyterlab
author: Liang
date: '2018-11-24'
slug: windows下Linux子系统安装conda和jupyterlab
categories:
  - 大蟒笔记
tags: []
lastmod: '2018-11-24T21:11:41-05:00'
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

# 1.安装conda

升级系统

```
sudo apt-get update -y && sudo apt-get upgrade -y
```

下载anaconda
```
wget https://repo.anaconda.com/archive/Anaconda3-5.0.1-Linux-x86_64.sh
```

安装anaconda
```
bash Anaconda3-5.0.1-Linux-x86_64.sh
```
按照安装教程进行下去

激活安装
```
source ~/.bashrc
```

查看安装
```
conda list
```

# 2.安装jupyterlab

```
conda install -c conda-forge jupyterlab
```

# 3.使用Jupyterlab
```
jupyter lab
```