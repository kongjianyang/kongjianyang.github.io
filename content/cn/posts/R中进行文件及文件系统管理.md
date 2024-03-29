---
title: "R中进行文件以及文件系统管理"
date: 2018-11-25T13:42:27-05:00
author: KJY
slug: R_files
draft: false
toc: true
categories:
  - test
tags:
  - article
---

本文中提到的文件系统管理主要是指文件和目录（即文件夹）的创建、查看、重命名、复制、删除和文件权限处理。

## 1. 文件操作

创建文件

    # 创建一个空文件 A.txt
    file.create("A.txt")
    # 查看当前目录下的子目录和文件
    list.files()
    
    # 创建多个空文件 A1.txt，A2.txt，A3.txt
    file.create("A1.txt", "A2.txt", "A3.txt")
    # 查看当前目录下的子目录和文件
    list.files()
    
    # 创建一个有内容的文件 B.txt
    cat("文件测试\n", file = "B.txt")
    list.files()

查看文件

    # 显示当前目录中的目录和文件
    
    ## 下面两句结果相同
    list.files() # 建议使用该命令，方便记忆
    dir() #python中这个意味着查看文件属性
    
    ## 参数full.names = TRUE，确定文件显示全名
    ## 参数recursive = TRUE，递归显示，即把目录下的目录和文件都以文件的形式显示
    list.files(, full.names = TRUE, recursive = TRUE)
    
    # 检查文件是否存在
    ## 存在的文件
    file.exists("A.txt")
    ## 不存在的文件
    file.exists("readme.txt")
    # 判断是否是文件
    file_test("-f", "A.txt")

读取文件

    # 文件A.txt读取
    readLines("A.txt")
    
    # 文件B.txt读取
    readLines("B.txt")

文件重命名

    # 给文件A.txt重命名为AA.txt
    file.rename("A.txt","AA.txt") #早知道有这个rename函数就不麻烦使用Python给文件改名了
    list.files()

复制文件

    file.copy("B.txt", "C.txt")
    # 查看文件内容
    readLines("C.txt")

删除文件

    # 新建文件
    file.create("tempa1", "tempa2", "tempa3", "tempa4")
    list.files()
    # 删除文件
    file.remove("tempa1", "tempa2", "tempa3", "tempa4")
    list.files()

查看文件权限

    # 查看文件完整信息
    file.info("A.txt")
    
    # 查看文件访问权限
    # 0表示有相关权限
    # 1表示没有相关权限
    
    ## 是否存在
    file.access("A.txt",0)
    
    ## 是否可执行
    file.access("A.txt",1)
    
    ## 是否可写
    file.access("A.txt",2)
    
    ## 是否可读
    file.access("A.txt",4)
    
    # 文件权限修改
    
    ## 查看文件信息
    file.info("A.txt")
    
    ## 修改文件权限，创建者可读可写可执行，其他人无权限
    Sys.chmod("A.txt", mode = "0400", use_umask = TRUE)
    
    ## 查看文件信息
    file.info("A.txt")
    
    #这些我更加倾向使用bash的命令来查看修改

## 2. 目录操作

创建目录

    # 新建一个目录
    dir.create("test") # 不能同时创建多个目录
    list.dirs()
    
    # 递归创建
    dir.create("test/test",recursive = TRUE)
    list.dirs()

查看目录

    # 查看当前默认目录的一级目录和文件
    list.files() # 同时会显示目录下的文件
    dir()
    
    # 查看当前默认目录的子目录
    
    ## 默认递归显示各级子目录
    list.dirs()
    
    ## 只显示一级子目录
    list.dirs(recursive= FALSE)
    
    # 通过系统命令查看目录结构
    system("tree") #tree的功能很强大
    
    # 检查目录是否存在
    # 存在的目录
    file.exists(".")
    file.exists("./test")
    
    # 不存在的目录
    file.exists("./test1")
    
    # 判断是否是目录
    
    ## 下面两个语句结果相同
    file_test("-d", "./test")
    file_test("-d", "test")

目录重命名

    # 查看目录
    dir()
    
    # 对test目录重命名
    file.rename("test", "test1")
    
    # 查看目录
    dir()
    
    # 目录重命名
    file.rename("test1", "test")

删除目录

    dir.create('temp')
    dir.create('temp1/temp1', recursive = TRUE)
    dir()
    
    # 删除temp目录
    unlink("temp", recursive = TRUE) # unlink也可用来删除文件，此时不需要设置参数recursive
    dir() # unlink用来删除文件和目录
    
    unlink("temp1", recursive = TRUE)
    dir()

目录的权限

    # 查看目录完整信息
    file.info(".")
    
    # 检查目录的权限
    df<-dir(full.names = TRUE)
    
    # 检查文件或目录是否存在，mode=0
    file.access(df, 0) == 0
    
    # 检查文件或目录是否可执行，mode=1，目录为可以执行
    file.access(df, 1) == 0
    
    # 检查文件或目录是否可写，mode=2
    file.access(df, 2) == 0
    
    # 检查文件或目录是否可读，mode=4
    file.access(df, 4) == 0
    
    # 修改目录权限，所有用户只读
    Sys.chmod("./test", mode = "0555", use_umask = TRUE)
    file.info("./test")

## 3. 小结

![](https://snag.gy/dTOImU.jpg)
