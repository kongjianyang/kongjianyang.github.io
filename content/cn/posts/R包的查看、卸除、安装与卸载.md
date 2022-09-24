---
title: R包的查看、卸除、安装与卸载
author: Liang
date: '2018-11-24'
slug: R包的查看、卸除、安装与卸载
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
# 01. 卸载自己古老的包

查看自己的包
```{r}
mypackages <- installed.packages()[,c('Package','Version','LibPath')] %>% as.data.frame()
write.csv(mypackages, "~/Desktop/mypackages.csv")
```


从存的文档中找到自己想要卸载的R包

```{r}
remove.packages(c("BSgenome.Athaliana.TAIR.TAIR9", "BSgenome.Hsapiens.UCSC.hg19", "GenomeInfoDb", "GenomeInfoDbData", "GenomicAlignments", "GenomicFeatures", "GenomicRanges", "GO.db", "GSEABase", "KEGGgraph", "KEGGREST", "learnr", "RgoogleMaps", "RSQLite", "yeastRNASeq", "yyplot"), lib = .libPaths()[1])
remove.packages(c("IRdisplay", "IRkernel"), lib = .libPaths()[2])
```


```{r}
mypackages <- installed.packages()[,c('Package','Version','LibPath')] %>% as.data.frame()
write.csv(mypackages, "~/Desktop/mypackages_new.csv")
```

查看之后上述的包已经被卸载了。

# 02. 补充部分
查看已加载的包
```
(.packages())
```

卸除已加载的包

```
detach("package:RMySQL")
```
注意是卸除，不是卸载，也就是说不是把包从R运行环境中彻底删除，只是不希望该包被加载使用。

在包使用函数冲突，检验函数依赖时比较有用。

安装包

```
install.packages("TSA")
```

列出包所在库的路径

```
.libPaths()
```

包的载入

```
library() 或 require()
```
安装完包后，需要加载才能使用其中的函数，此时括号中不使用引号。两者的不同之处在于library()载入之后不返回任何信息，而require()载入后则会返回TRUE，因此require()适合用于程序的书写。

包的更新

```
update.packages()
```
彻底删除已安装的包：
```
remove. packages(c("pkg1","pkg2") , lib = file.path("path", "to", "library"))
```

查看已安装的包
```
installed.packages()[,c('Package','Version','LibPath')]
```
其中c(‘Package’,’Version’,’LibPath’) 表示显示包名、版本、库路径信息，若无[,c(‘Package’,’Version’,’LibPath’)]参数，则显示所有信息。

查看某个包提供的函数

```
help(package='TSA')
```
