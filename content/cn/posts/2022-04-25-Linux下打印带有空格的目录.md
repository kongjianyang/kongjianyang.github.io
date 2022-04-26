---
title: "Linux下打印带有空格的目录"
date: 2022-04-25T13:42:27-05:00
author: KJY
slug: dirt_space
draft: false
toc: true
categories:
  - test
tags:
  - article

---

有时候在macos下会有很多空格的目录文件需要处理，很麻烦，可以使用下面的命令自动处理带有空格的文件



```
alias cwd='printf "%q\n" "$(pwd)" | tee >(pbcopy)'
```

## printf命令

printf 命令模仿 C 程序库（library）里的 printf() 程序。

printf 由 POSIX 标准所定义，因此使用 printf 的脚本比使用 echo 移植性好。

printf 使用引用文本或空格分隔的参数，外面可以在 **printf** 中使用格式化字符串，还可以制定字符串的宽度、左右对齐方式等。默认的 printf 不会像 **echo** 自动添加换行符，我们可以手动添加 **\n**。

printf 命令的语法：

```
printf  format-string  [arguments...]
```

**参数说明：**

- **format-string:** 为格式控制字符串
- **arguments:** 为参数列表。

```
#!/bin/bash
# author:菜鸟教程
# url:www.runoob.com
 
printf "%-10s %-8s %-4s\n" 姓名 性别 体重kg  
printf "%-10s %-8s %-4.2f\n" 郭靖 男 66.1234
printf "%-10s %-8s %-4.2f\n" 杨过 男 48.6543
printf "%-10s %-8s %-4.2f\n" 郭芙 女 47.9876
```

执行脚本，输出结果如下所示：

```
姓名     性别   体重kg
郭靖     男      66.12
杨过     男      48.65
郭芙     女      47.99
```

**%s %c %d %f** 都是格式替代符，**％s** 输出一个字符串，**％d** 整型输出，**％c** 输出一个字符，**％f** 输出实数，以小数形式输出。

**%-10s** 指一个宽度为 10 个字符（**-** 表示左对齐，没有则表示右对齐），任何字符都会被显示在 10 个字符宽的字符内，如果不足则自动以空格填充，超过也会将内容全部显示出来。

**%-4.2f** 指格式化为小数，其中 **.2** 指保留2位小数。

## tee命令



功能：

> 从标准输入中复制到每一个文件，并输出到标准输出。



可以用来做手动跟踪命令的输出内容，同时又想将输出的内容写入文件，确保之后可以用来参考。



```
ping google.com | tee output.txt
```

这个输出内容不仅被写入 `output.txt` 文件，也被显示在标准输出中。
