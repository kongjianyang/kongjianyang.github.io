---
title: shell编程-shell编程基础
author: Liang
date: '2018-11-24'
slug: shell编程-shell编程基础
categories:
  - Linux技巧
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
## 1.什么是shell
shell是介于用户和操作系统之间的一个接口，用来接收用户的键盘输入，并分析和执行输入字符串中的命令，然后给用户返回执行结果，于GUI相比，shell因为使用命令行，所以使用起来可能比较复杂，但是使用的资源会比较少，而且拥有批处理的功能。

一图看shell在操作系统中的位置
![image.png](https://upload-images.jianshu.io/upload_images/3014937-059886f9c6c9c5e3.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

使用命令查看当前shell
```
echo $SHELL
#/bin/zsh
ls -l /bin/zsh
#-rwxr-xr-x  1 root  wheel  610224 Sep 21 00:17 /bin/zsh
```
如果你发现当前 Shell 不是 Bash，请用下面的方法替换它：

```
$ bash
$ echo $SHELL  # 确认一下
/bin/bash
```
##2.简单的shell脚本
假设我们设计一个test.sh的脚本，内容如下
```
#!/bin/bash
# test.sh
echo "Hello, World"
```
重点是该文件的第一行，当我们直接运行该脚本文件时，该行告诉操作系统使用用#! 符号之后面的解释器以及相应的参数来解释该脚本文件，通过分析第一行，我们发现对应的解释器是 /bin/bash。

## 3.shell的执行原理
Shell 接收用户输入的脚本名，并进行分析。如果文件被标记为可执行，但不是被编译过的程序，Shell 就认为它是一个 Shell 脚本。 Shell 将读取其中的内容，并加以解释执行。所以，从用户的观点看，执行 Shell 脚本的方式与执行一般的可执行文件的方式相似。

因此，用户开发的 Shell 脚本可以驻留在命令搜索路径的目录之下（通常是 /bin、/usr/bin等），像普通命令一样使用。这样，也就开发出自己的新命令。如果打算反复使用编好的 Shell 脚本，那么采用这种方式就比较方便。
