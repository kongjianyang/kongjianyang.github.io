---
title: Linux下批量修改文件名
author: Liang
date: '2018-11-24'
slug: Linux下批量修改文件名
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
# 方法一：Rename函数
Linux下修改文件名有mv和rename。其中mv命令只能对单个文件重命名，这是mv命令和rename命令的在重命名方面的根本区别。

linux的rename命令有两个版本，一个是c语言版本的，一个是perl语言版本的，判断方法：
输入man rename 看到第一行是： 
RENAME(1) Linux Programmer’s Manual RENAME(1)
这个就是C语言版本的
而如果出现：
RENAME(1) Perl Programmers Reference Guide RENAME(1) 则是Perl版本的了

C语言版本格式：rename 原字符串 新字符串 文件名
Perl语言版本格式：rename 's/原字符串/新字符串/' 文件名

rename支持正则表达式
 
例子：
 

字母的替换`rename "s/AA/aa/" *  //`把文件名中的AA替换成aa
修改文件的后缀`rename "s//.html//.php/" *     //`把.html 后缀的改成 .php后缀
批量添加文件后缀`rename "s/$//.txt/" * //`把所有的文件名都以txt结尾
批量删除文件名`rename "s//.txt//" * //`把所有以.txt结尾的文件名的.txt删掉

# 方法二：mv函数

1. 在文件夹shell下创建文件10个文件
```
touch tmp_{1..10}.txt
```
2. 找到含有“_“”的文件夹。
```
find ./ -name "*_*"   
```
3. 读取id, 用mv改名，$为自己理解为赋值后的id，格式为while； do； done
```
find ./ -name "*_*" | while read id; do mv $id ${id/_/-}; done
```
