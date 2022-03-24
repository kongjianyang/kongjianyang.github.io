---
title: Linux下查看文件命令选择
author: Liang
date: '2018-11-24'
slug: Linux下查看文件命令选择
categories:
  - 生信修炼
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
Linux内有三大命令可以用来查看文件内容，分别是cat、more、和less，他们之间既有共同点又有区别，例如：cat可以一次性显示整个文件的内容，还可以将多个文件连接起来显示，常与重定向符号配合使用，适用于文件内容少的情况，而more和less一般用于显示文件内容超过一屏的内容，并且提供翻页的功能。more比cat强大，提供分页显示的功能，less比more更强大，提供翻页，跳转，查找等命令。而且more和less都支持：用空格显示下一页，按键b显示上一页。下面详细介绍这3个命令。

## 1. cat
cat命令比较简单，比较常用

cat主要有三大功能：
+ 1.一次显示整个文件:cat filename
+ 2.从键盘创建一个文件:cat > filename 只能创建新文件,不能编辑已有文件.
+ 3.将几个文件合并为一个文件:cat file1 file2 > file

对非空输出行编号，使用```cat -b```命令：
```
[root@localhost test]# cat -b log2012.log log2013.log log.log

     1  2012-01

     2  2012-02

     3  ======

     4  2013-01

     5  2013-02

     6  2013-03
```

输出所有行号，使用```cat -n```命令：
```
[root@localhost test]# cat -n log.log 

     1  2012-01

     2  2012-02

     3

     4

     5  ======
```

## 2. more

more命令，功能类似 cat ，cat命令是整个文件的内容从上到下显示在屏幕上。 more会以一页一页的显示方便使用者逐页阅读，而最基本的指令就是按空白键（space）就往下一页显示，按 b 键就会往回（back）一页显示，而且还有搜寻字串的功能 。more命令从前向后读取文件，因此在**启动时就加载整个文件**。

常用命令
```
Enter    向下n行，需要定义。默认为1行  
Ctrl+F   向下滚动一屏  
空格键   向下滚动一屏  
Ctrl+B   返回上一屏  
=        输出当前行的行号  
:f      输出文件名和当前行的行号  
v        调用vi编辑器  
!命令    调用Shell，并执行命令   
q        退出more  
```

## 3. less

less 与 more 类似，但使用 less 可以随意浏览文件，而 more 仅能向前移动，却不能向后移动，而且**less 在查看之前不会加载整个文件**。  

less 工具也是对文件或其它输出进行分页显示的工具，应该说是**linux正统查看文件内容的工具，功能极其强大**。less 的用法比起 more 更加的有弹性。在 more 的时候，我们并没有办法向前面翻， 只能往后面看，但若使用了 less 时，就可以使用 [pageup] [pagedown] 等按键的功能来往前往后翻看文件，更容易用来查看一个文件的内容！除此之外，在 less 里头可以拥有更多的搜索功能，不止可以向下搜，也可以向上搜。

常用命令
```
/字符串：向下搜索“字符串”的功能  
?字符串：向上搜索“字符串”的功能  
n：重复前一个搜索（与 / 或 ? 有关）  
N：反向重复前一个搜索（与 / 或 ? 有关）  
b  向后翻一页  
d  向后翻半页
h  显示帮助界面  
Q  退出less 命令  
u  向前滚动半页  
y  向前滚动一行  
空格键 滚动一页  
回车键 滚动一行
```
