---
title: shell编程-bash-shell的布尔运算
author: Liang
date: '2018-11-24'
slug: shell编程-bash-shell的布尔运算
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
在 Bash 里有这样的常量(实际上是两个内置命令，在这里我们姑且这么认为，后面将介绍)，即 true 和 false，一个表示真，一个表示假。对它们可以进行与、或、非运算等常规的逻辑运算。

## 1. 与或非运算

```
$ if true;then echo "YES"; else echo "NO"; fi
YES
$ if false;then echo "YES"; else echo "NO"; fi
NO
```
与运算用&&表示
```
$ if true && true;then echo "YES"; else echo "NO"; fi
YES
$ if true && false;then echo "YES"; else echo "NO"; fi
NO
$ if false && false;then echo "YES"; else echo "NO"; fi
NO
$ if false && true;then echo "YES"; else echo "NO"; fi
NO
```
或运算用||表示
```
$ if true || true;then echo "YES"; else echo "NO"; fi
YES
$ if true || false;then echo "YES"; else echo "NO"; fi
YES
$ if false || true;then echo "YES"; else echo "NO"; fi
YES
$ if false || false;then echo "YES"; else echo "NO"; fi
NO
```
非运算，即取反用!表示
```
$ if ! false;then echo "YES"; else echo "NO"; fi
YES
$ if ! true;then echo "YES"; else echo "NO"; fi
NO
```
## 2. true和false的本质
true 和 false 都是 Shell 的内置命令，它们的返回值是一个“逻辑值”，其中true 返回了 0，而 false 则返回了 1 

在 Shell 里，将 0 作为程序是否成功结束的标志，这就是 Shell 里头 true 和 false 的实质，它们用以反应某个程序是否正确结束，而并非传统的真假值（1 和 0），相反地，它们返回的是 0 和 1，即true返回0而false返回1.

## 3.条件测试
shell中使用 test 进行数值测试（各种数值属性测试）、字符串测试（各种字符串属性测试）和文件测试（各种文件属性测试）。

**数值测试**，具体参数可以使用help test查看
命令 | 描述
------| ----------------------------------
n1 -eq n2 | 检查n1是否与n2相等 (equal) 
n1 -ge n2 | 检查n1是否大于或等于n2 (greater and equal) 
n1 -gt n2 | 检查n1是否大于n2 (greater than) 
n1 -le n2 | 检查n1是否小于或等于n2 (less and equal) 
n1 -lt n2 | 检查n1是否小于n2 (less than) 
n1 -ne n2 | 检查n1是否不等于n2 (not equal) 

```
$ if test 5 -eq 5;then echo "YES"; else echo "NO"; fi #两数相等
YES
$ if test 5 -ne 5;then echo "YES"; else echo "NO"; fi #两数不相等
NO
```

**字符串测试**
命令 | 描述
------| ----------------------------------
str1 = str2 | 检查str1是否和str2相同 
str1 != str2 | 检查str1是否和str2不同 
str1 < str2 |  检查str1是否比str2小 
str1 > str2 |  检查str1是否比str2大 
-n str1 | 检查str1的长度是否非0 
-z str1 | 检查str1的长度是否为0 

```
$ if test -n "not empty";then echo "YES"; else echo "NO"; fi
YES
$ if test -z "not empty";then echo "YES"; else echo "NO"; fi
NO
$ if test -z "";then echo "YES"; else echo "NO"; fi
YES
$ if test -n "";then echo "YES"; else echo "NO"; fi
NO
```
**文件测试**
命令 | 描述
------| ----------------------------------
-d file | 检查file是否存在并是一个目录 
-e file | 检查file是否存在 
-f file | 检查file是否存在并是一个文件 
-r file | 检查file是否存在并可读 
-s file | 检查file是否存在并非空 
-w file | 检查file是否存在并可写 
-x file | 检查file是否存在并可执行 
-O file | 检查file是否存在并属当前用户所有 
-G file | 检查file是否存在并且默认组与当前用户相同 
file1 -nt file2 | 检查file1是否比file2新 
file1 -ot file2 | 检查file1是否比file2旧 

```
$ if test -f /bin/bash; then echo "YES"; else echo "NO"; fi
YES
$ if test -d /bin/bash; then echo "YES"; else echo "NO"; fi
NO
```

## 4.逻辑运算符
test 命令内部的逻辑运算和 Shell 的逻辑运算符有一些区别，对应的为 -a 和 &&，-o 与 ||，这两者不能混淆使用。而非运算都是 !

-a 和 -o 作为测试命令的参数用在测试命令的内部，而 && 和 || 则用来运算测试的返回值，! 为两者通用。需要关注的是：
- 有时可以不用 ! 运算符，比如 -eq 和 -ne 刚好相反，可用于测试两个数值是否相等； -z 与 -n 也是对应的，用来测试某个字符串是否为空
- 在 Bash 里，test 命令可以用[] 运算符取代，但是需要注意，[之后与] 之前需要加上额外的空格
- 在测试字符串时，所有变量建议用双引号包含起来，以防止变量内容为空时出现仅有测试参数，没有测试内容的情况

用 [ ] 可以取代 test，这样看上去会“美观”很多
```
$ i=5 #赋值不要空行
$ if [ $i -eq 5 ]; then echo "YES"; else echo "NO"; fi
YES
$ if [ $i -gt 4 ] && [ $i -lt 6 ]; then echo "YES"; else echo "NO"; fi
YES
```
记得给一些字符串变量加上 ""，记得 [ 之后与 ] 之前多加一个空格，不然会出现问题

```
$ str=""
$ if [ "$str" = "test" ]; then echo "YES"; else echo "NO"; fi
NO
```
## 5. 命令列表

命令列表的执行规律符合逻辑运算的运算规律，用 && 连接起来的命令，如果前者成功返回，将执行后面的命令，反之不然；用 || 连接起来的命令，如果前者成功返回，将不执行后续命令，反之不然。这个时候的&&和||和上面的与运算和或运算不同。

```
$ ping -c 1 www.google.com -W 1 && echo "=======connected=======" # ping -c 指定ping的次数 -W 指定等待响应时间（单位是毫秒） 
PING www.google.com (216.58.192.228): 56 data bytes

--- www.google.com ping statistics ---
1 packets transmitted, 1 packets received, 0.0% packet loss, 1 packets out of wait time
round-trip min/avg/max/stddev = 10.240/10.240/10.240/0.000 ms
=======connected======= 
```

用命令列表取代 if/then 等条件分支结构可以省掉一些代码，而且使得程序比较美观、易读。
