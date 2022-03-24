---
title: shell编程-bash-shell中的特殊变量
author: Liang
date: '2018-11-24'
slug: shell编程-bash-shell中的特殊变量
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
## 1.介绍
shell有很多以$开头的特殊变量，以下是对于这些变量的说明：

变量 | 意义
-------|--------------------------------
$$ | Shell本身的PID（ProcessID）
$! | Shell最后运行的后台Process的PID
$? | 最后运行的命令的结束代码（返回值）
$- | 使用Set命令设定的Flag一览
$* | 所有参数列表。如"$*"用「"」括起来的情况、以"$1 $2 … $n"的形式输出所有参数。
$@ | 所有参数列表。如"$@"用「"」括起来的情况、以"$1" "$2" … "$n" 的形式输出所有参数。
$# | 添加到Shell的参数个数
$0 | Shell本身的文件名
$1～$n | 添加到Shell的各参数值。$1是第1参数、$2是第2参数…

## 2.例子
下面通过一个例子解释怎么使用这些特殊变量
命令一个variable.sh的简单脚本，其内容如下

```
#!/bin/bash
echo "number:$#" # $# 是传给脚本的参数个数
echo "scname:$0" # $0 是脚本本身的名字
echo "first :$1" # $1是传递给该shell脚本的第一个参数
echo "second:$2" # $2是传递给该shell脚本的第二个参数
echo "argume:$@" # $@ 是传给脚本的所有参数的列表
echo "all argume:$*" # $* 所有参数列表
echo "finish code:$?" # $? 最后运行命令的结束代码
```

执行该脚本并传入aa和bb两个参数
```
bash variable.sh aa bb
```

得到如下结果

```
number:2
scname:variable.sh
first :aa
second:bb
argume:aa bb
finish code:0
```
