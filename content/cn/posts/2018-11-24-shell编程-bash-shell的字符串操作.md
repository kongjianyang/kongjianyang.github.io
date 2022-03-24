---
title: shell编程-bash-shell的字符串操作
author: Liang
date: '2018-11-24'
slug: shell编程-bash-shell的字符串操作
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
## 1.字符串属性

字符有可能是数字、字母、空格、其他特殊字符，而字符串有可能是它们中的一种或者多种的组合，在组合之后还可能形成具有特定意义的字符串，诸如邮件地址，URL地址等。

数字或者数字组合
```
$ i=5;j=9423483247234;
$ echo $i | grep "^[0-9]$"
5
$ echo $j | grep "^[0-9]\+$"
9423483247234
```
字符组合
```
$ c="A"; d="fwefewjuew"; e="fewfEFWefwefe"
$ echo $c | grep "^[A-Z]$"
A
$ echo $d | grep "^[a-z]\+"
fwefewjuew
$ echo $e | grep "^[a-zA-Z]\+$"
fewfEFWefwefe
```
字母和数字的组合
```
$ ic="432fwfwefeFWEwefwef"
$ echo $ic | grep "^[0-9a-zA-Z]\+$"
432fwfwefeFWEwefwef
```
匹配邮件地址
```
$ echo "test2007@lzu.cn" | grep "[0-9a-zA-Z\.]*@[0-9a-zA-Z\.]*"
test2007@lzu.cn
```
匹配 URL 地址
```
$ echo "http://news.lzu.edu.cn/article.jsp?newsid=10135" | grep "^http://[0-9a-zA-Z\./=?]\+$"
http://news.lzu.edu.cn/article.jsp?newsid=10135
```
## 2.字符串长度

即计算所有字符的个数，计算方法五花八门，下面是几个例子
```
$ var="get the length of me"
$ echo ${var}     # 这里等同于$var
get the length of me
$ echo ${#var}
20
$ expr length "$var"
20
$ echo $var | awk '{printf("%d\n", length($0));}'
20
$ echo -n $var |  wc -c
20
```
## 3.拆分字符串
Bash 提供的数组数据结构，以数字为下标的，和 C 语言从 0 开始的下标一样，我们写个脚本，命名为split_string.sh，内容如下
```
#!/bin/bas
var="get the length of me"
var_arr=($var)    #把字符串var存放到字符串数组var_arr中，默认以空格作为分割符
echo ${var_arr[0]} ${var_arr[1]} ${var_arr[2]} ${var_arr[3]} ${var_arr[4]}
echo ${var_arr[@]}    #整个字符串，可以用*代替@，下同
echo ${#var_arr[@]}   #类似于求字符串长度，`#`操作符也可用来求数组元素个数
```
运行结果如下
```
get the length of me
get the length of me
5
```
## 4. 字符串常规操作

**取子串**

awk 默认把一行按照空格分割为多个域，并可以通过 $1，$2，$3 ... 来获取，$0 表示整行。
```
$ var="get the length of me"
$ echo ${var:0:3}
get
$ echo ${var:(-2)}   # 方向相反呢
me
$ echo $var | awk '{printf("%s\n", substr($0, 9, 6))}'
length
$ echo $var | awk '{printf("%s\n", $1)}'
get
$ echo $var | awk '{printf("%s\n", $5)}'
me
```
cut也可以用来截取子串，-d指定分割符，如同awk用-F指定分割符一样；-f指定“域”，如同awk的$数字。
```
echo $var | cut -d " " -f 5
```

**匹配字符求子串**
tr 也可以用来取子串，它可以类似#和 % 来“拿掉”一些字符串来实现取子串，tr 的 -c 选项是 complement 的缩写，即 invert，而 -d 选项是删除，tr -cd "[a-z]" 这样一来就变成保留所有的字母
```
$ echo $var | tr -d " "
getthelengthofme
$ echo $var | tr -cd "[a-z]" #把所有的空格都拿掉了，仅仅保留字母字符串，注意-c和-d的用法
getthelengthofme
```
还可以使用head和tail截取字符串
```
$ echo "abcdefghijk" | head -c 4
abcd
$ echo -n "abcdefghijk" | tail -c 4
hijk
```
**查询子串在目标串中的位置**
```
$ var="get the length of me"
$ echo $var | awk '{printf("%d\n", match($0, "the"))}'
5
```  

**子串替换**
使用{}替换
```
$ var="get the length of me"
$ echo ${var/ /_}        #把第一个空格替换成下划线
get_the length of me
$ echo ${var// /_}       #把所有空格都替换成下划线
get_the_length_of_me
```
用 awk，awk 提供了转换的最小替换函数 sub 和全局替换函数 gsub，类似 / 和 //
```
$ echo $var | awk '{sub(" ", "_", $0); printf("%s\n", $0);}' #先替换之后再输出，sub最小替换
get_the length of me
$ echo $var | awk '{gsub(" ", "_", $0); printf("%s\n", $0);}' #gsub全局替换
get_the_length_of_me
```
用 sed，流编辑器，sed全名叫stream editor，用程序的方式来编辑文本：
```
$ echo $var | sed -e 's/ /_/'    #s <= substitude
get_the length of me
$ echo $var | sed -e 's/ /_/g'   #看到没有，简短两个命令就实现了最小匹配和最大匹配g <= global
get_the_length_of_me
```
用tr命令替换，tr(translate)命令是sed命令的简化版，tr命令能实现的功能， sed都能实现
```
$ echo $var | tr " " "_"
get_the_length_of_me
$ echo $var | tr '[a-z]' '[A-Z]'   #这个可有意思了，把所有小写字母都替换为大写字母
GET THE LENGTH OF ME
```














