---
title: xargs命令与管道的区别
author: Liang
date: '2018-11-24'
slug: xargs命令与管道的区别
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
**xargs**是一条[Unix](https://zh.wikipedia.org/wiki/Unix "Unix")和[类Unix](https://zh.wikipedia.org/wiki/%E7%B1%BBUnix "类Unix")[操作系统](https://zh.wikipedia.org/wiki/%E6%93%8D%E4%BD%9C%E7%B3%BB%E7%BB%9F "操作系统")的常用命令。它的作用是将参数列表转换成小块分段传递给其他命令，以避免参数列表过长的问题。

下面两个例子解释xargs命令与管道之间的区别
```
echo 'main' | cat
# main
```
这条命令中cat会从其标准输入中读取内容并处理，也就是会输出 'main' 字符串。echo命令将其标准输出的内容 'main' 通过管道定向到 cat 的标准输入中
```
echo '--help' | xargs cat
#cat: illegal option -- -
#usage: cat [-benstuv] [file ...]
```
上述的命令类似
```
cat --help
```

可以看到 echo '--help' | cat   该命令输出的是echo的内容，也就是说将echo的内容当作cat处理的文件内容了，实际上就是echo命令的输出通过管道定向到cat的输入了。然后cat从其标准输入中读取待处理的文本内容。这等价于在test.txt文件中有一行字符 '--help' 然后运行  cat test.txt 的效果。

而 echo '--help' | xargs cat 等价于 cat --help 什么意思呢，就是xargs将其接受的字符串 --help 做成cat的一个命令参数来运行cat命令，同样  echo 'test.c test.cpp' | xargs cat 等价于 cat test.c test.cpp 此时会将test.c和test.cpp的内容都显示出来。
