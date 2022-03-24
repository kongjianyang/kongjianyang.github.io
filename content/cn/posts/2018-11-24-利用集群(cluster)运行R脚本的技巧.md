---
title: 利用集群(cluster)运行R脚本的技巧
author: Liang
date: '2018-11-24'
slug: 利用集群(cluster)运行R脚本的技巧
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
### 1. 编写脚本
首先编写一个R脚本保存在当前目录下，例如HeatMap.R
```
library(gplots)
qlf_path <- "../07DEgene/QLF_DEG/"
file_name <- dir(qlf_path)
figure_path <- "../07DEgene/figure/qlf_heatmap/"
for (k in 21:21){
  mymain <- strsplit(file_name[k], "_")[[1]][c(1,2,4,5)]
  mymain <- paste(mymain, collapse = "_")
  figure_name <- paste0(figure_path, mymain, ".pdf")
  pdf(figure_name)
  qlf_file <- paste0(qlf_path, file_name[k])
  data <- read.table(qlf_file)
  data <- as.matrix(data)
  mycol <- colorpanel(n=40,low="blue",high="yellow") 
  heatmap.2(data, col = mycol, scale = "row", key=TRUE, trace="none",cexCol=1,cexRow=0.5, srtRow=45, adjRow=c(0, 1), srtCol=45, adjCol=c(1,1), Rowv= T, Colv = F, lmat=rbind( c(0, 3), c(2,1), c(4,0) ), lhei=c(1.5, 4, 2), lwid = c(3,4), labRow = "", main = mymain)
  dev.off()
}
```
然后编写一个串行作业脚本，例如pbs_heatmap.sh

```
#!/bin/sh
#PBS -l nodes=1:ppn=20
#PBS -l walltime=00:30:00
#PBS -q your query name
#PBS -m ae
#PBS -M youremal address
#PBS -N heatmap_job

cd $PBS_O_WORKDIR
module load bioinfo
module load R
Rscript HeatMap.R
```

### 2.提交作业脚本
使用 qsub 命令提交作业
```
qsub pbs_heatmap.sh
```
### 3.查看作业状态

qstat 命令查看作业的状态，如果是 R 表示在运行，Q 表示在排队
使用 checkjob ID，查看为什么在排队
qstat -f JobID 查看作业的详细情况，包括提交时间，哪些节点在运行这个作
业等。
qdel ID 删除 R 和 Q 的作业
qhold ID 把 Q 的作业挂起
qrls ID 把挂起的作业释放

 ### 4. 额外知识
有的时候需要在cluster上安装R包和装载R包。
安装R包：
```
install.packages("gplots”,lib=“/data/user/Rlib”)
```
lib 的参数值为需要将R 包安装的路径。
查看自己已经安装的R包的路径可以使用命令：
```
> .libPaths()
[1] "C:/Users/jmzeng/Documents/R/win-library/3.1"
[2] "C:/Program Files/R/R-3.1.0/library"
```
查看自己已经安装的R包有哪些，使用命令:
```
> colnames(installed.packages())
 [1] "Package"               "LibPath"               "Version"              
 [4] "Priority"              "Depends"               "Imports"              
 [7] "LinkingTo"             "Suggests"              "Enhances"             
[10] "License"               "License_is_FOSS"       "License_restricts_use"
[13] "OS_type"               "MD5sum"                "NeedsCompilation"     
[16] "Built"
```
