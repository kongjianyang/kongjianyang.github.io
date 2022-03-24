---
title: 服务器端使用IGV
author: Liang
date: '2018-11-24'
slug: 服务器端使用IGV
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
# 1. 打开IGV
终端打开IGV
```
module load igv
module show igv
```
提示以下信息

```
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   /depot/bioinfo/apps/modules/igv/2.3.60:
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
whatis("Visualization tool for interactive exploration of genomic datasets ")
load("java")
prepend_path("PATH","/group/bioinfo/apps/apps/IGV_2.3.60")
help([[
Notes:
IGV (Integrative Genomics Viewer)
version 2.3.60
Visualization tool for interactive exploration of genomic datasets
http://www.broadinstitute.org/software/igv/home
User Guide: http://www.broadinstitute.org/software/igv/UserGuide
FAQ: http://www.broadinstitute.org/software/igv/FAQ
Forum: https://groups.google.com/forum/#!forum/igv-help
Info: /group/bioinfo/apps/apps/IGV_2.3.60/readme.txt
Start with "igv.sh" 
Need X11 display: More config info at:
https://www.rcac.purdue.edu/compute/carter/guide/#accounts_login_x11

]])
```
提示打开IGV通过igv.sh， 输入
```
igv.sh &
```
# 2. 搭配使用igvtools
```
module load igvtools
module show igvtools
```
提示以下信息
```
----------------------------------------------------------------------------
   /depot/bioinfo/apps/modules/igvtools/2.3.60:
----------------------------------------------------------------------------
whatis("Utilities for preprocessing data files ")
load("java")
prepend_path("PATH","/group/bioinfo/apps/apps/IGVTools-2.3.60")
help([[
Notes:
IGV Tools
version 2.3.60
Utilities for preprocessing data files
http://www.broadinstitute.org/software/igv/home
User Guide: http://www.broadinstitute.org/software/igv/UserGuide
FAQ: http://www.broadinstitute.org/software/igv/FAQ
Forum: https://groups.google.com/forum/#!forum/igv-help
Info: /group/bioinfo/apps/apps/IGVTools-2.3.60/igvtools_readme.txt
Need X11 display for igvtools_gui

]])
```
# 3. 加载基因组
Genomes > Load Genome form file，例如Zea_mays.AGPv3.22.dna.genome.fa，加载完基因组后会生成Zea_mays.AGPv3.22.dna.genome.fa.fai的文件。


# 4. 加载GFF文件
由于 GFF 文件很大，需要排序以及建索引之后才能导入 IGV: 利用 IGVtools 进行排序和建立索引
```
igvtools sort zea_mays.protein_coding.gff zea_mays.protein_coding.sorted.gff
igvtools index zea_mays.protein_coding.sorted.gff 
```
load GFF 选择刚刚排序和索引之后的 gff 文件: 
点击:file->load from file

# 4. 加载bam文件
BWA出来的sam文件无法直接被 IGV 利用的，必须经过 samtools 处理后才能被 IGV 显示出来。

使用脚本批量index文件
```
#!/bin/bash
for i in *.bam
do
echo "Indexing: "$i
samtools index $i $i".bai"
done
```
注意将.bam和.bai放在同一个文件夹下。
建立完索引后 load bam 文件:
File –>load from file 打刚刚建立完索引的 bam 文件。

# 5. IGV可视化基因
找到自己感兴趣基因的起始和终止位置，可以根据gff的文件进行查找。可视化结果：
![](https://upload-images.jianshu.io/upload_images/3014937-4b7468fe79848963.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
