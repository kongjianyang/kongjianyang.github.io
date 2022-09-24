---
title: shell编程-bash-shell的数值计算
author: Liang
date: '2018-11-24'
slug: shell编程-bash-shell的数值计算
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
## 1. 数据计算基础
使用man 或者info查看shell bash的判断命令test，Shell中的 test 命令用于检查某个条件是否成立，它可以进行数值、字符和文件三个方面的测试。

```
man test 
info test 
```
可以使用type查看一个命令是否是shell内置的函数，例如
 ```
$ type type
type is a shell builti

$ type awk
awk is /usr/bin/awk
```
从结果可知： let 是 Shell 内置命令，awk是外部命令，在 /usr/bin 目录下

expr命令是一个手工命令行计数器，用于在UNIX/LINUX下求表达式变量的值，一般用于整数值，也可用于字符串。
```
$ expr 5 % 2
1
```
bc 命令是任意精度计算器语言，通常在linux下当计算器用。它类似基本的计算器, 使用这个计算器可以做基本的数学运算。
```
$ bc
bc 1.06
Copyright 1991-1994, 1997, 1998, 2000 Free Software Foundation, Inc.
This is free software with ABSOLUTELY NO WARRANTY.
For details type `warranty'.
3^2
9
```
let 命令是 BASH 中用于计算的工具，用于执行一个或多个表达式，变量计算中不需要加上 $ 来表示变量。如果表达式中包含了空格或其他特殊字符，则必须引起来。
```
$ let a=1+1; echo $a
2
```

## 2. 求模求幂
```
$ expr 5 % 2
1

$ let i=5%2
$ echo $i
1

$ echo 5 % 2 | bc
1

$ ((i=5%2))
$ echo $i
1

$ let i=5**2
$ echo $i
25

$ ((i=5**2))
$ echo $i

25
$ echo "5^2" | bc
25
```

## 3. 浮点数计算
let 和 expr 都无法进行浮点运算，但是 bc 和 awk 可以。
```
$ echo "scale=3; 1/13"  | bc
.076

$ echo "1 13" | awk '{printf("%0.3f\n",$1/$2)}'
0.077
```
bc 在进行浮点运算时需指定精度，否则默认为 0，即进行浮点运算时，默认结果只保留整数。而 awk 在控制小数位数时非常灵活，仅仅通过 printf 的格式控制就可以实现。

## 4. 获取随机数
环境变量 RANDOM 产生从 0 到 32767 的随机数，而 awk 的 rand() 函数可以产生 0 到 1 之间的随机数。
```
$ echo $RANDOM
81

$ echo "" | awk '{srand(); printf("%f", rand());}'
0.237788
```
说明： srand() 在无参数时，采用当前时间作为 rand() 随机数产生器的一个 seed 。

随机产生一个从 0 到 255 之间的数字
```
$ expr $RANDOM / 128
208

$ echo "" | awk '{srand(); printf("%d\n", rand()*255);}'
104
```

## 5. 获取一系列数
使用seq命令
```
$ for i in {1..12}; do echo -n "$i "; done
1 2 3 4 5 6 7 8 9 10 11 12 %
```
