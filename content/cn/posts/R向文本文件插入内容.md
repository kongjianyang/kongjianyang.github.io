---
title: "R向文本文件插入内容"
date: 2018-11-25T13:42:27-05:00
author: KJY
slug: R_inscert_content
draft: false
toc: true
categories:
  - test
tags:
  - article

---



## 1. 创造文件并写入

    fileConn<-file("./output.txt") #创造一个文件
    writeLines(c("Hello","World"), fileConn) #写入内容到文件内
    close(fileConn)

## 2. 替代方法

可以使用sink和cat命令写入文件

sink函数将输出结果重定向到文件。

使用方式：sink(file = NULL, append = FALSE, type = c(“output”,
“message”),split = FALSE)

append参数：布尔值。TRUE时，输出内容追加到文件尾部。FALSE，覆盖文件原始内容。

cat函数即能输出到屏幕，也能输出到文件.

使用方式：cat(… , file = ““, sep =” “, fill = FALSE, labels =
NULL,append = FALSE)

有file时，输出到file。无file时，输出到屏幕。

append参数：布尔值。TRUE时，输出内容追加到文件尾部。FALSE，覆盖文件原始内容。

    sink("./outfile2.txt")
    cat("hello\nworld")
    
    ## hello
    ## world
    
    sink()

## 3. 替代方法2

R中还有一个write函数，可以直接写入内容到文件内

    line="hello\nworld"
    write(line,file="./outfile3.txt")

## 4. 插入文件到文本指定位置

创造文件

    line="hello\nworld"
    write(line,file="./outfile3.txt")

读取文件

    txt_cont <- readLines("./outfile3.txt", warn=FALSE)
    length(txt_cont)
    
    ## [1] 2

在文件的第二行插入内容重新写入

    txt_cont <- paste(txt_cont[1], "my", txt_cont[2], sep = "\n")
    #不能用+，和Python不同，字符串不能加
    writeLines(txt_cont, "./outfile4.txt")
