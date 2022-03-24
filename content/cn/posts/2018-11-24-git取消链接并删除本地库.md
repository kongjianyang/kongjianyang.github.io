---
title: git取消链接并删除本地库
author: Liang
date: '2018-11-24'
slug: git取消链接并删除本地库
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
有的时候我们需要删除从GitHub上克隆下来的库

从github上clone一个仓库：
```
git clone git@github.com:USERNAME/repo.git
```
在本地目录下关联远程repository
```
git remote add origin git@github.com:git_username/repository_name.git
```

取消本地目录下关联的远程库
```
git remote remove origin
```

删除本地库
```
Quincy_C@Quincy MINGW64 /gitskills/gitskills (master) 
$ git branch #显示本地所有分支 
* master

Quincy_C@Quincy MINGW64 /gitskills/gitskills (master) 
$ git init 1#初始化仓库 
Reinitialized existing Git repository in D:/Program Files/Git/gitskills/gitskills/.git/

Quincy_C@Quincy MINGW64 /gitskills/gitskills (master) 
$ ls -a 2#查看内部文件 
./ ../ .git/ README.md

Quincy_C@Quincy MINGW64 /gitskills/gitskills (master) 
$ rm -rf .git 3#强删.git

Quincy_C@Quincy MINGW64 /gitskills/gitskills 
$ ls -a 4#查看内部文件 
./ ../ README.md

Quincy_C@Quincy MINGW64 /gitskills/gitskills 
$ cd .. 5#回退

Quincy_C@Quincy MINGW64 /gitskills 
$ rm -rf gitskills 6# 强删文件夹

Quincy_C@Quincy MINGW64 /gitskills 
$ cd .. 7# 回退

Quincy_C@Quincy MINGW64 / 
$ rm -rf gitskills 8# 强删文件夹
```
