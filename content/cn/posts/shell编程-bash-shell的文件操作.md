---
title: shell编程-bash-shell的文件操作
author: Liang
date: '2018-11-24'
slug: shell编程-bash-shell的文件操作
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
## 1. 基本操作
ls 命令显示文件基本属性，d 表示目录，- 表示普通文件（或者硬链接），l 表示符号链接，p 表示管道文件，b 和 c 分别表示块设备和字符设备。除此之外还可以使用stat命令，stat以文字的格式来显示inode的内容。
```
$ stat bin/
16777220 8608385535 drwxr-xr-x 37 root wheel 0 1184 "Nov 23 09:06:38 2018" "Nov 10 01:38:56 2018" "Nov 10 01:38:56 2018" "Sep 21 00:17:17 2018" 4096 0 0x88000 bin/
```
file命令也可以给出文件的基本信息
```
$ file bin
bin: directory
```

可以使用chmod给文件添加权限
```
chmod 777 regular_file
```

可以使用passwd命令给用户修改自己的密码
```
passwd #普通用户通过执行该命令，修改自己的密码
```

可以使用tree显示目录树
```
$ tree #当前目录
```

## 2. 压缩与解压缩文件
```
#tar
$ tar -cf file.tar file   #压缩
$ tar -xf file.tar    #解压
#gz
$ gzip  -9 file
$ gunzip file
# tar.gz
$ tar -zcf file.tar.gz file
$ tar -zxf file.tar.gz
# bz2
$ bzip2 file
$ bunzip2 file
#tar.bz2
$ tar -jcf file.tar.bz2 file
$ tar -jxf file.tar.bz2
```

## 3. 文件搜索
寻找目录下所有的.doc文件或者.pptx的文件
```
$ find ./ -name "*.doc" -o -name "*.pptx" # -o是或者
```
可以对找到的所有C文件移动到c_files文件夹下
```
$ find ./ -name "*.c" -o -name "*.h" | xargs -i mv '{}' ./c_files/
```
此外，Linux 下还有命令查找工具：which 和 whereis，前者用于返回某个命令的全路径，而后者用于返回某个命令、源文件、man 文件的路径。例如，查找find` 命令的绝对路径：
```
$ which find
/usr/bin/find
$ whereis find
find: /usr/bin/find /usr/X11R6/bin/find /usr/bin/X11/find /usr/X11/bin/find /usr/man/man1/find.1.gz /usr/share/man/man1/find.1.gz /usr/X11/man/man1/find.1.gz
```
如果想根据文件的内容搜索文件，那么 find 和 updatedb+locate 以及 which，whereis 都无能为力啦，可选的方法是 grep，sed 等命令
