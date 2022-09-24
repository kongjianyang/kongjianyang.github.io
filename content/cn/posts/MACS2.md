---
title: "MACS2使用"
date: 2022-03-25T14:32:27-05:00
author: KJY
slug: bioinfo
draft: false
toc: true
categories:
  - bioinfo
tags:
  - article
---

参考资料：

[这可能是最棒的MACS2使用说明 (360doc.com)](http://www.360doc.com/content/18/0205/00/19913717_727772514.shtml)

[使用MACS2进行差异peak分析_生信修炼手册的博客-CSDN博客](https://blog.csdn.net/weixin_43569478/article/details/108079812)

MACS2：Model-based analysis of ChiP-Seq. 最初的设计是用来鉴定转录因子的结合位点，但是它也可以用于其他类型的富集方式测序。

MACS2作为使用最广泛的peak calling软件，在v2版本中添加了差异peak分析的功能，所有的子命令功能描述如下

![](https://imgconvert.csdnimg.cn/aHR0cHM6Ly9tbWJpei5xcGljLmNuL21tYml6X3BuZy9LQXRSUEJCeWVHNVI5MGNRaWJxS2FibjVKM3ZwSDUyTWZnZUpkRTVwSGQza1BmdVNONEozMTVERVRKclpteFJxVGV0UXNQd3ZCVGdpY24zeFU3Tzdtd2hnLzY0MA?x-oss-process=image/format,png)

通过`bdgdiff`子命令来进行差异peak分析， 该命令不需要基于已有的peak calling结果，只需要输入每个样本对应的bedGraph格式的文件。需要注意的是，该命令只针对两个样本间的差异peak进行设计，适用于没有生物学重复的情况。

对于使用macs2来进行差异peak的完整流程，官方给出了详细的说明文档，链接如下

> https://github.com/taoliu/MACS/wiki/Call-differential-binding-events

可以分为以下3步

#### 1\. 预测插入片段长度

通过`predictd`子命令可以预测样本的fragment size，命令如下

```
macs2 predictd -i input.bam
```

```
#!/bin/bash

module load bioinfo
module load biocontainers/default
module load macs2/2.2.7.1-py39

for i in `ls [A-H][1-9][A-H][1-9][A-H][1-9].bam`;
do
msg="macs2 predictd -i $i";
echo $msg;
macs2 predictd -i $i;
```



#### 2\. peak  calling

在peak calling时，需要添加`-B`参数，这样才可以输出样本对应的bedgraph文件，同时需要保证peak  calling时采用一致的`--extsize`的值，就是第一步预测出来的数值，取多个样本的均值即可。官方也给出了推荐值，对于大多数的转录因子chip\_seq数据，推荐值为200， 对于大部分组蛋白修饰的chip\_seq数据，推荐值为147，命令如下

```
# condition1
macs2 callpeak -B -t cond1_ChIP.bam -c cond1_Control.bam -n cond1 --nomodel --extsize 147
# condition2
# broad peak calling:
macs2 callpeak -B -t cond1_ChIP.bam -c cond1_Control.bam -n cond1 --outdir Macs2_out -g 8.55e8  --nomodel --extsize 147 --broad --broad-cutoff 0.05 -q 0.05 2> macs2/Pou5f1-rep2-macs2.log
```

- `-n/--name`表示实验的名字; 输出文件名的前缀
- `--outdir`:输出结果的存储路径
- `-B/--bdg`: 以bedGraph格式存放*fragment pileup*, *control lambda*, *-log10pvalue* 和*log10qvale*.
- `-q`： q值(最小的FDR)的阈值。可以根据结果进行修正。q值是p值经Benjamini–Hochberg–Yekutieli修正后的值。*默认，0.01，对于 broad marks(组蛋白修饰的chipseq)，可以使用0.05；*
- `--broad--cutoff`: 用于过滤 `broad`得到的peak，默认是q值，如果设置 `-p`就用p值。
- `--nomodel`: 这个参数说明不需要MACS去构建模型，也就是说下面的参数除了 `--shift, --extsize`外都会被无视。
- `--extsize`： MACS使用这个参数将read以5'-> 3'衍生至等长片段。比如说你知道你的转录因子的结合区域是200bp，那么参数就是 `--extsize 200`。当且仅当 `--nomodel`和 `--fix-bimodal`设置使用。
- `-g`表示可比对的基因组大小。比如说人类是2.7e9，也就是2.7G，拟南芥根据NCBI显示是119,667,750，也就是1.2e8. 这个参数设置的原因，根据我读发表MACS的那篇文献推测，是因为MACS需要进行全基因组扫描构建双峰模型估计shift size。这个只是我猜测而已，反正根据自己物种来就对了。由于基因组序列的重复性，基因组实际可以mapping的大小小于原始的基因组。这个参数要根据实际物种计算基因组的有效大小。
- -f/--format FORMAT`用来声明输入的文件格式，目前MACS能够识别的格式有 'ELAND', 'BED', 'ELANDMULTI', 'ELANDEXPORT', 'ELANDMULTIPET' (双端测序), 'SAM', 'BAM', 'BOWTIE', 'BAMPE', 'BEDPE'. 除'BAMPE', 'BEDPE'需要特别声明外，其他格式都可以用 `AUTO

在运行这一步的时候，会输出每个样本过滤之后的reads数目，示意如下

```
# tags after filtering in treatment: 19291269# tags after filtering in control: 12914669
```

这个数值在差异分析中会用到，所以要记录下来。

> maybe need to add paired end mode, Paired-End mode is off

#### 3. Reults of peak calling

1. NAME_peaks.xls
存放peak信息的文件

- 染色体名
- peak 起始位置
- peak 终止位置
- peak 区域长度
- peak summit位置
- peak summit位置堆积信号
- -log10(pvalue)
- fold enrichment for this peak summit against random Poisson distribution with local lambda
- -log10(qvalue) at peak summit
- peak name

2. NAME_peaks.narrowPeak
BED6+4格式，包含peak位置信息，peak summit, pvalue and qvalue，可以使用UCSC genome browser查看。其中几列信息如下：

- 1th: 染色体名
- 2th: peak 起始位置
- 3th: peak 终止位置
- 4th: peak name
- 5th: integer score for display, int(-10*log10(pvalue))
- 7th: fold-change
- 8th: -log10(pvalue)
- 9th: -log10qvalue
- 10th: 峰位与peak起点的距离

3. NAME_summits.bed
BED格式，包含peak summits(peak最高点)位置；如果想寻找结合位点的motifs ，建议使用此文件。

- 5th: -log10pvalue

4. NAME_peaks.broadPeak
ED6+3格式，与narrowPeak类似，除了没有第10列peak summit的注释信息。

5. NAME_peaks.gappedPeak
BED12+3格式，存放broad region 和 narrow peaks，可以使用UCSC genome browser查看。

6. NAME_model.r
R程序，运行后生成基于输入数据产生的模型图片

```
$ Rscript NAME_model.r
```

7. bdg files
bedGraph 文件，可以导入UCSC genome browser查看，或转格式为bigWig 文件；

- treat_pileup ：实验组bedGraph 文件
- control_lambda ：对照组bedGraph 文件

#### 4. 输出文件的比较

- xls文件
文件包含信息还是比较多的，和narrowPeak唯一不同的是peak的起始位置需要减1才是bed格式的文件，另外还包含fold_enrichment 和narrowPeak的fold change 对应，-log10pvalue,-log10qvalue, peak长度，peak 峰值位置等。

- narrowPeak文件
和xls文件信息类似

- summits.bed文件
包含峰的位置信息和-log10pvalue

- bdg文件
bdg文件适合导入UCSC或IGV进行谱图可视化，或者转换为bigwig格式再进行可视化

#### 5\. 差异peak分析

参考这篇文章：

[Call differential binding events · macs3-project/MACS Wiki (github.com)](https://github.com/macs3-project/MACS/wiki/Call-differential-binding-events)

>The purpose of this step is to do a three ways comparisons to find out where in the genome has differential enrichment between two conditions. A basic requirement is that this region should be at least enriched in either condition.

命令如下

```
macs2 bdgdiff --t1 cond1_treat_pileup.bdg --c1 cond1_control_lambda.bdg --t2 cond2_treat_pileup.bdg \--c2 cond2_control_lambda.bdg --d1 12914669 --d2 14444786 -g 60 -l 120 --o-prefix diff_c1_vs_c2
```

```bash
查询命令使用：
macs2 bdgdiff -h

用法说明：
usage: macs2 bdgdiff [-h] --t1 T1BDG --t2 T2BDG --c1 C1BDG --c2 C2BDG
                     [-C CUTOFF] [-l MINLEN] [-g MAXGAP] [--d1 DEPTH1]
                     [--d2 DEPTH2] [--outdir OUTDIR]
                     (--o-prefix OPREFIX | -o OFILE OFILE OFILE)
# 可选参数：
optional arguments:
# 参数 --t1是读取MACS pileup bedGraph for condition 1. 
# 参数 --t2是读取MACS pileup bedGraph for condition 2. 
# 参数 --c1是读取MACS control lambda bedGraph for condition 1.
# 参数 --c2是读取MACS control lambda bedGraph for condition 2.
# 参数 --d1  Sequencing depth (# of non-redundant reads in million) for condition 1. 
# 参数 --d2  Sequencing depth (# of non-redundant reads in million) for condition 2. 
# 参数 --o-prefix diff_c1_vs_c2保存输出文件名。
#  -l MINLEN, --min-len MINLEN
                        Minimum length of differential region. Try bigger
                        value to remove small regions. DEFAULT: 200
#  -g MAXGAP, --max-gap MAXGAP
                        Maximum gap to merge nearby differential regions.
                        Consider a wider gap for broad marks. Maximum gap
                        should be smaller than minimum length (-g). DEFAULT:
                        100
```



其中`-d1`和`-d2`的值就是第二步运行时输出的reads数目，`-o`参数指定输出文件的前缀。运行成功后，会产生3个文件

1.  diff\_c1\_vs\_c2\_c3.0\_cond1.bed
    
2.  diff\_c1\_vs\_c2\_c3.0\_cond2.bed
    
3.  diff\_c1\_vs\_c2\_c3.0\_common.bed
    

其中, con1.bed保存了在condition1中上调的peak, con2.bed保存了在condition2中上调的peak, common.bed文件中保存的是没有达到阈值的，非显著差异peak。

上述3个文件格式是完全相同的，最后一列的内容为log10 likehood ratio值，用来衡量两个条件之间的差异，默认阈值为3，大于阈值的peak为组间差异显著的peak, 这个阈值可以通过`-c`参数进行调整。  

> The last column in the file represent the log10 likelihood ratio to show how likely the observed signal in condition 1 in this region is from condition 1 comparing to condition 2. Higher the value, bigger the difference.



这里需要注意bdgdiff可能不适合broad peaks:

[Narrow & Broad peaks from 'macs2 bdgdiff' (biostars.org)](https://www.biostars.org/p/274094/)

> `bdgdiff` first generate three tracks from the 4 input tracks, which contains the log-likelihoods of t1 > t2, t1=t2, and t1 < t2. The three output files are in fact peaks called by `bdgpeakcall`--the subfunction for calling narrow peaks--from these three tracks. So, `bdgdiff` is not suitable for calling differential broad peaks.



#### 4. 使用IGV加载MACS的结果

1. 首先解压并重命名 `bedGraph` 文件。以FoxA1数据集为例，首先定位到`HAIB_T47D_FoxA1_MACS_bedGraph/treat`,
2. 解压文件 `gzip -d HAIB_T47D_FoxA1_treat_afterfiting_all.bdg.gz`
3. 更改后缀为`bedGraph`，这样可被IGV识别`mv HAIB_T47D_FoxA1_treat_afterfiting_all.bdg HAIB_T47D_FoxA1_treat_afterfiting_all.bedGraph`
4. 用IGV加载`HAIB_T47D_FoxA1_treat_afterfiting_all.bedGraph`，根据IGV的手册。

#### 一些解释

MACS2比较适合call narrow peak, SICER适用于找出那些diffuse/broad peak，通过识别空间信号簇来寻找ChIP-enriched信号

SICERv2.0: 输入文件不再局限于bed格式，bam文件也是可以的。



什么时候需要去重

理论上来讲，不同的序列在进行PCR扩增时，扩增的倍数应该是相同的。但是由于聚合酶的偏好性，PCR扩增次数过多的情况下，会导致一些序列持续扩增，而另一些序列扩增到一定程度后便不再进行，也就是我们常说的PCR偏好性。

这种情况对于定量分析（如ChIP-seq），会造成严重的影响。此外，PCR扩增循环数过多，会出现一些扩增偏差，进而影响一些突变识别（比如call SNP)的置信度。

因此，在一些NGS分析流程中需要考虑去除PCR重复。

若起始量很低，PCR扩增次数很多，那么则需要去除PCR重复。因此：

- RNA-seq由于其建库起始量一般都很高所以不需要去除重复，而且RNA-seq数据中经常会出现某些基因的表达量十分高，这就导致这些基因打断的reads的比对情况有很大概率是一致的。
- 而ChIP-seq中，由于起始量不高，且没有那种富集程度很高的位点，因此通常需要考虑去除PCR重复。
- 至于call SNP，起始量一般都高（因为要保证测序深度），此外由于PCR扩增会导致一些序列复制错误，这将严重影响SNP位点识别的置信度。因此一般需要去重复。

This redundancy is consistently applied for both the ChIP and input samples.

> **Why worry about duplicates?** Reads with the same start position are considered duplicates. These duplicates can arise from experimental artifacts, but can also contribute to genuine ChIP-signal.
>
> - **The bad kind of duplicates:** If initial starting material is low this can lead to overamplification of this material before sequencing. Any biases in PCR will compound this problem and can lead to artificially enriched regions. Also blacklisted (repeat) regions with ultra high signal will also be high in duplicates. Masking these regions prior to analysis can help remove this problem.
> - **The good kind of duplicates:** Duplicates will also exist within highly efficient (or even inefficient ChIP) when deeply sequenced. Removal of these duplicates can lead to a saturation and so underestimation of the ChIP signal.
>
> **The take-home:** Consider your enrichment efficiency and sequencing depth. But, because we cannot distinguish between the good and the bad, best practice is to remove duplicates prior to peak calling. Retain duplicates for differential binding analysis. Also, if you are expecting binding in repetitive regions keep duplicates and multiple mappers.

