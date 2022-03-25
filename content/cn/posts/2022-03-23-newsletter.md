---
title: "创建自己的newsletter信息"
date: 2022-03-23T13:42:27-05:00
author: KJY
slug: second-post-cn
draft: false
toc: true
categories:
  - test
tags:
  - article
---



记录使用GitHub创建自己的newsletter信息：

结构参考这篇仓库：[ShixiangWang/weekly: 生信爱好者周刊（每周日发布） (github.com)](https://github.com/ShixiangWang/weekly)

[TOC]

## 1. 克隆并更新到自己的仓库

### 克隆别人的仓库到本地



```
git clone git@github.com:ShixiangWang/weekly.git
```

并在自己的github创建自己的仓库

### 删除原来git版本控制

进入project的[根目录](https://so.csdn.net/so/search?q=根目录&spm=1001.2101.3001.7020)中，右击鼠标打开Git Bash
输入 `find . -name ".git" | xargs rm -Rf`

### 初始化自己的仓库

```bash
$ touch README.md
$ git init
$ git add *
$ git commit -m "此处可添加提交代码相关的注释"
$ git remote add origin https://github.com/yourUserName/repositoryName.git
$ git push -u origin master
123456
```

origin 是代码仓库地址的别称
[git详细教程](https://www.jianshu.com/p/d1c1191819c8)

.gitignore文件编写

该文件内容是不想提交到仓库的文件或文件夹。
忽略某个文件夹下面所有内容要带星号*
pyqt5/build/*
pyqt5/dist/*
time_format/build/*
time_format/dist/*
time_format/img/*

