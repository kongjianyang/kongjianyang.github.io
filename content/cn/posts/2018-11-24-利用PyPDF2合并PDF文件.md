---
title: 利用PyPDF2合并PDF文件
author: Liang
date: '2018-11-24'
slug: 利用PyPDF2合并PDF文件
categories:
  - 大蟒笔记
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
# 1. 问题
有的时候我们有一系列PDF文件我们希望合并到一个PDF中进行查看和打印，这个时候合并PDF文件就非常有用，PyPDF2库可以帮助我们做到这点。

# 2. 用法

PyPDF2 包括了 PdfFileReader PdfFileMerger PageObject PdfFileWriter 四个常用的主要 Class。

以下命令可以解释这个库是怎么工作的

```
from PyPDF2 import PdfFileReader, PdfFileWriter
readFile = 'read.pdf'
writeFile = 'write.pdf'
# 获取一个 PdfFileReader 工具
pdfReader = PdfFileReader(open(readFile, 'rb'))
# 获取 PDF 的页数
pageCount = pdfReader.getNumPages()
print(pageCount)
# 返回一个 PageObject
page = pdfReader.getPage(i)
# 获取一个 PdfFileWriter 工具
pdfWriter = PdfFileWriter()
# 将一个 PageObject 插手到 PdfFileWriter 中
pdfWriter.addPage(page)
# 输出到文件中
pdfWriter.write(open(writeFile, 'wb'))
```
接下来的命令是一个实例

```
from PyPDF2 import PdfFileMerger

pdfs = ['file1.pdf', 'file2.pdf', 'file3.pdf', 'file4.pdf']

merger = PdfFileMerger()

for pdf in pdfs:
    merger.append(open(pdf, 'rb'))

with open('result.pdf', 'wb') as fout:
    merger.write(fout)
```


另外一个技巧

在Python列表中提取匹配到的元素

```
mylist = ["aa123", "bb2322", "aa354", "cc332", "ab334", "333aa"]
l = [i for i in mylist if 'aa' in i]
l
#['aa123', 'aa354', '333aa']
```







