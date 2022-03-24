---
title: bedGraph，bed以及bam文件格式转换
author: Liang
date: '2018-11-24'
slug: bedGraph，bed以及bam文件格式转换
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
感兴趣的基因信息包含在bedGraph文件中，下面命令是对其文件格式进行转换，一般进行到bam文件可视化的效果比较好。

# 1. bedGraph转bed文件
BedGraph ，的数据和bed文件很类似，ChIPseq数据做完peak calling后的bed文件最短只有三列，染色体序号，染色体起始位置和结束位置。如下所示，前面的声明和Wig类似，后面的四列分别表示染色体序号，起始位置，结束位置和value值。相当于为bed文件的延伸格式。
```
track type=bedGraph name="BedGraph Format" description="BedGraph format" visibility=full color=200,100,0 altColor=0,100,200 priority=20
chr19 49302000 49302300 -1.0
chr19 49302300 49302600 -0.75
chr19 49302600 49302900 -0.50
chr19 49302900 49303200 -0.25
chr19 49303200 49303500 0.0
chr19 49303500 49303800 0.25
chr19 49303800 49304100 0.50
chr19 49304100 49304400 0.75
chr19 49304400 49304700 1.00
```
所以我们想要得到bed文件只需要提取bedGraph的前三列即可，同时注意不要第一行，利用grep -v命令
```
# Convert bedGraph to bed file
grep -v track GSM1252087_edm2-4_RNAseq.bedGraph | cut -f 1-3 > GSM1252087_edm2-4_RNAseq.bed
```

# 2. 建立genome size文件
genome size文件是为了最后一步转化为bam文件所必须的，samtools可以很简单的建立index文件
```
# Build genome index file
samtools faidx Arabidopsis_thaliana.TAIR10.dna.toplevel.fa
```
生成的索引文件genome.fasta.fai,是一个文本文件，分成了5列。第一列是子序列的名称；第二列是子序列的长度；个人认为“第三列是序列所在的位置”，因为该数字从上往下逐渐变大，最后的数字是genome.fasta文件的大小；第4和5列不知是啥意思。于是通过此文件，可以定位子序列在fasta文件在磁盘上的存放位置，直接快速调出子序列。

genome size文件包含index文件的前两行，也就是chromosome信息和子序列的长度，所以我们可以提取作为genome size。
```
# Build the genome size file
awk {'print "Chr"$1,"\t",$2'} Arabidopsis_thaliana.TAIR10.dna.toplevel.fa.fai > Arabidopsis_genomeFile.txt
```

# 3. bed转bam
bedtools工具提供的bedtobam命令
```
# Change the bed file to bam file
cat GSM1252087_edm2-4_RNAseq.bed | awk '{x++; printf "%s\tread%d\n",$0,x}' | bedtools bedtobam -g Arabidopsis_genomeFile.txt -i - > GSM1252087_edm2-4_RNAseq.bam
```

Ref:
http://www.chenlianfu.com/?p=1399
