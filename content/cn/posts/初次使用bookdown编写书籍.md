---
title: 初次使用bookdown编写书籍
author: Liang
date: '2018-11-28'
slug: 初次使用bookdown编写书籍
categories:
  - R
tags: []
lastmod: '2018-11-28T15:42:28-05:00'
keywords: []
description: ''
comment: true
toc: true
autoCollapseToc: true
postMetaInFooter: no
hiddenFromHomePage: no
contentCopyright: no
reward: no
mathjax: true
mathjaxEnableSingleDollar: true
mathjaxEnableAutoNumber: true
hideHeaderAndFooter: no
flowchartDiagrams:
  enable: no
  options: ''
sequenceDiagrams:
  enable: no
  options: ''
---

bookdown支持采用Rmarkdown (R代码可以运行)或普通markdown编写文档，然后编译成HTML, WORD, PDF, Epub等格式。

# 1. 基本使用

使用要求：

  - 安装Rstudio
  - 安装Pandoc
  
  ```
  conda install -c conda-forge pandoc
  ```
  
  接下来需要到.Renviron中设置环境：
  ```
  RSTUDIO_PANDOC=/Applications/RStudio.app/Contents/MacOS/pandoc
  ```
  
  - 安装bookdown
  
  ```
  install.packages("bookdown")
  ```

下载demo：
```
git clone https://github.com/rstudio/bookdown-demo
```

然后进行编译，运行下载的示例中的bash _build.sh，_book目录下就是成书。

```
#!/bin/sh
Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::gitbook')"
# 生成pdf需要安装好latex，如果不需要可以注释掉
Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::pdf_book')"
```

如果想在Rstudio中进行预览：

```
bookdown:::serve_book("./01Demo/bookdown-demo/")
```

# 2. 文件格式

- 一个典型的bookdown文档包含多个章节，每个章节在一个R Markdown文件里面 (文件的语法可以是pandoc支持的markdown语法，但后缀必须为Rmd)。

- 每一个章节都必须以`# Chapter title`开头。后面可以跟一段概括性语句，概述本章的内容，方便理解，同时也防止二级标题出现在这一页。默认系统会按照文件名的顺序合并Rmd文件。

- 另外章节的顺序也可在_bookdown.yml文件中通过`rmd_files:["file1.Rmd", "file2.Rmd", ..]`指定。

- 如果有index.Rmd，index.Rmd总是出现在第一个位置。通常index.Rmd里面也需要有一章节，如果不需要对这一章节编号的话，可以写作`# Preface {-}`, 关键是{-}。

- 在index.Rmd，可以定义Pandoc相关的YAML metadata, 比如标题、作者、日期等 (去掉#及其后的内容)。


```
--- 
title: "A Minimal Book Example"
author: "Yihui Xie"
date: "`r Sys.Date()`"
site: bookdown::bookdown_site
output: bookdown::gitbook
documentclass: book
bibliography: [book.bib, packages.bib]
biblio-style: apalike
link-citations: yes
github-repo: rstudio/bookdown-demo
description: "This is a minimal example of using the bookdown package to write a book. The output format for this example is bookdown::gitbook."
---
```

插入脚注:

`text^[footnote]` is used to get the footnote.

```
where `type` may be `article`,  `book`,  `manual`,  and so on.^[The type name is case-insensitive,  so it does not matter if it is `manual`,  `Manual`,  or `MANUAL`.]
```

插入引文

假如我们的bib文件中内容如下，如果我们要引用这个文章，只要写 `[@chen_m6a_2015]`就可以了。

```
@article{chen_m6a_2015,
	title = {m6A {RNA} {Methylation} {Is} {Regulated} by {MicroRNAs} and {Promotes} {Reprogramming} to {Pluripotency}},
	volume = {16},
	issn = {1934-5909, 1875-9777},
	url = {http://www.cell.com/cell-stem-cell/abstract/S1934-5909(15)00017-X},
	doi = {10.1016/j.stem.2015.01.016},
	language = {English},
	number = {3},
	urldate = {2016-12-08},
	journal = {Cell Stem Cell},
	author = {Chen, Tong and Hao, Ya-Juan and Zhang, Ying and Li, Miao-Miao and Wang, Meng and Han, Weifang and Wu, Yongsheng and Lv, Ying and Hao, Jie and Wang, Libin and Li, Ang and Yang, Ying and Jin, Kang-Xuan and Zhao, Xu and Li, Yuhuan and Ping, Xiao-Li and Lai, Wei-Yi and Wu, Li-Gang and Jiang, Guibin and Wang, Hai-Lin and Sang, Lisi and Wang, Xiu-Jie and Yang, Yun-Gui and Zhou, Qi},
	month = mar,
	year = {2015},
	pmid = {25683224},
	pages = {289--301},
}
```

bookdown是可以直接导出为word文档的。导出方法是，在_output.yml里添加一行：

```
bookdown::word_document2: default 
```

注意，default这个词是不能少的，不管它是不是默认。我也不知道为什么。

解决办法是，不使用公式环境，而使用行内公式（即公式前后有一个美元符号），公式前面用圆括号里加公式标签就可以了。例如，输入：

$$latex
f(x;\mu,\sigma^2) = \frac{1}{\sigma\sqrt{2\pi}} e^{ -\frac{1}{2}\left(\frac{x-\mu}{\sigma}\right)^2 }
$$

$$
E = mc^2
$$
# 引用其他章节

[Cross-references](ttps://bookdown.org/yihui/bookdown/cross-references.html)

例如引用第四章，可以使用

```
[Chapter 4 Plant Materials and Growth Conditions](#plant_growth)
```

# 输出为Word

在index.Rmd或者_bookdown.yml中设置site: bookdown::bookdown_site后， RStudio就能识别这个项目是一个bookdown项目， 这时RStudio会有一个Build窗格，其中有“Build book”快捷图标， 从下拉菜单中选择一个输出格式（包括gitbook、pdf_book、epub_book）， 就可以编译整本书。

在_output.yml加入一行bookdown::word_document2: default可以输出为Word, 注意，default这个词是不能少的。

**Reference:**

- [Bookdown平台](http://blog.genesino.com/2016/11/bookdown-usage/#%E7%BC%96%E8%AF%91%E6%88%90%E4%B9%A6)


- [R bookdown 语法标记速查](http://www.pzhao.org/zh/post/bookdown-cheatsheet/)











