---
title: 编写自己的第一个R包并发布到GitHub
author: Liang
date: '2018-11-28'
slug: 编写自己的第一个R包并发布到GitHub
categories:
  - R
tags: []
lastmod: '2018-11-28T12:37:59-05:00'
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

## 1. 编写R包

发现要深入了解一门语言要尝试给这个语言造轮子，所以就开始学习怎么开始写自己的第一个R包了。我习惯利用Rstudio编写R程序，所以在Rstudio中开发。

选择File -> New Project，然后选择New Directory，接着选择R Package，最后给你R包取个名字即可，如下图所示，可以选择git版本进行version control。我的包名称是Rtools。

RStudio会在当前目录（默认是个人目录下）创建一个R包文件夹，主要文件（夹）包括：man，R，DESCRIPTION，NAMESPACE以及xx.Rproj。下面是文件目录解释：

```
testR(包的名字，这里包的名字叫testR)
|
|--DESCRIPTION(描述文件，包括包的名字，版本号，标题，描述，依赖关系)
|--R(函数源文件)
   |--function1.R
   |--function2.R
   |--...
|--man(帮助文档)
   |--function1.Rd
   |--function2.Rd
   |--testR-package.Rd
   |--...
|--NAMESPACE(命名空间)
|--vignettes(包的描述文件，可以用rmarkdown写)
|--src(非R脚本eg.C.C++,Python)
|--data(R包中的数据，最好是.rda格式)
|--demo(R包中的demo)
|--test(R包中的测试代码)
|--...
```

DESCRIPTION文件写了这个R的描述信息，主要为了告诉别人（或者自己）这个R包的一些重要的元数据（官方说法），可以按照自己的需要进行修改：

```
Package: Rtools
Type: Package
Title: My First R Package
Version: 0.1.0
Author: Liang
Maintainer: The package maintainer <yourself@somewhere.net>
Description: Just for learn
License: GPL
Encoding: UTF-8
LazyData: true
RoxygenNote: 6.1.1
```

接下来需要准备好一个写好的R自定义函数，比如在R文件夹创建一个uniprot.R文件，然后将函数写入该文件；我们使用R包就是将输入参数导入函数中，然后函数给我们一个结果。比如我的函数如下：

```
idmapping <- function(query, inputid, outputid, fmt){
  query <- paste(query, collapse = ",")
  r <- httr::POST('http://www.uniprot.org/uploadlists/', body = list(from= inputid, to = outputid, format = fmt, query = query), encode = "form")
  cont <- httr::content(r, type = "text")
  result <- readr::read_tsv(cont)
}
```

接下来需要给上述idmapping函数写个文档，告诉使用者这个函数是做什么用的（也可以方便自己记忆）；其实我们再使用R包的时候，为了查看一个函数的使用，都会`?+函数`来阅读使用说明，其实这个使用说明就是接下来要说的对象文档

文档一般都以`#'`开头，第一行是简要介绍，以@param开头的行逐个介绍函数的自变量（懒得介绍的话就像示例里的x2那一行一样空着，但x2后面必须有一个空格），`@return`开头的行介绍因变量（必填），`@export @examples`两行可以不修改。有更多函数的话，照葫芦画瓢在文件里往下继续写就是了。保存。

```
#' Use r code to connect uniprot web api
#'
#' You can choose one id as input id as well as another id as output id
#' Know more information you can learn from uniprot documentation
#'
#' @param query vector of protein ids
#' @param inputid type of input id, character
#' @param outputid type of output id, character
#' @param fmt output form
#'
#' @return a dataframe
#' @export
#'
#' @examples
#' result <- idmapping(query = proid, inputid = "ACC", outputid = "P_ENTREZGENEID", fmt = "fmt")
#'
idmapping <- function(query, inputid, outputid, fmt){
  query <- paste(query, collapse = ",")
  r <- httr::POST('http://www.uniprot.org/uploadlists/', body = list(from= inputid, to = outputid, format = fmt, query = query), encode = "form")
  cont <- httr::content(r, type = "text")
  result <- readr::read_tsv(cont)
}
```

注意这里的注释信息不是我们常见的代码注释，而是对函数整体的roxygen注释，主要为了方便后续文档的生成。

接着输入`devtools::document()`，自动会在man文件夹下生成该函数的Rd文档。

最后每个项目都需要有一个完整的说明文档vignettes。

生成文档的方法如下：`devtools::use_vignette("testR-tutorial")`，会生成一个vignettes文件夹，里面有rmarkdown文档，你可以编辑描述自己的package。

最后安装下自己的这个R包，这里还是用RStudio的功能：点击Build -> Build & Reload，其会重新编译这个R包，更新文档等操作，并重新加载R包；我用`?idmapping`看下自己写的文档。

## 2. 发布到GitHub

```
cd ./Rtools # 进入到目标文件夹。
git init #（在本机上想要创建一个新的git仓库）
git add -A # 提交所有变化
git remote add origin xxxxxxxxx xxxxxx #就是你仓库的地址，具体的地址可以去Github上copy。关联远程仓库。
git commit -m "firstCommit" # 添加commit
git pull --rebase origin master # 更新远程的代码到本地，rebase变更基线
git push origin master # 将本地repo于远程的origin的repo合并，第一次用-u，系统要求输入账号密码
```

如果rebase有任何错误的话，可以尝试一下进行修复

```
# 通过git reflog找到rebase前的HEAD的commit id.
git reflog 
# 然后reset到rebase之前的状态
git reset --hard HEAD_ID
```

如果本地和GitHub上的项目有冲突的话，可以使用下面的命令

```
git push origin master -f #强制push，会替换掉GitHub上的版本
```

还可以测试从GitHub上下载下来进行本地安装

```
devtools::install_github("kongjianyang/Rtools")
library(Rtools)
```

