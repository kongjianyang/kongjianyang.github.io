---
title: 序列比较中ClustalW和BLAST的区别
author: Liang
date: '2018-11-24'
slug: 序列比较中ClustalW和BLAST的区别
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
序列比对是生物信息学研究中一种常见且经典的手段。经过多年的发展，序列比对也诞生了很多种方法，这篇文章选择讨论的是两种比较常见的序列比对方法，选择哪种比对方法也是科研中容易踩坑的一个点。

#BLAST 

BLAST(Basic Local Alignment Search Tool )算法是1990年由Altschul等人提出的两序列局部比对算法，采用了一种短片段匹配算法和一种有效的统计模型来找出目的序列和数据库之间的最佳局部比对效果。

它的基本思想是：通过产生数量更少的但质量更好的增强点来提高匹配的精确度。首先采用哈希法对查询序列以碱基的位置为索引建立哈希表，然后将查询序列和数据库中所有序列联配，找出精确匹配的“种子”，以“种子”为中心，使用动态规划法向两边扩展成更长的联配，最后在一定精度范围内选取符合条件的联配按序输出。得分最高的联配序列就是最有比对序列。

其算法过程可简单描述为：
1) 从两个序列中找出一些长度相等且可以形成无空位完全匹配的子序列，即序列片段对；
2) 找出两个序列之间所有匹配程度超过一定值的序列片段对；
3) 将得到的序列片段对根据给定的相似性阂值延伸，得到一定长度的相似性片段，称为高分值片段对。

1. 将Query序列中每k个字的组合做成一个表，以k=3为例(DNA序列中，我们则常以k=11为例)，我们"依序"将Query序列中每3个字的组合视为一个字组，并将这些字组列在一张字组表上，直到Query序列中最后一个字也被收入进表上为止
![制作字母表](https://upload-images.jianshu.io/upload_images/3014937-6f0b5436a2859d76.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

2. 根据打分矩阵(scoring matrix)为所有的字母对打分。下面是一个比较常见打分矩阵，相同匹配加2，AG，CT减5，其他不匹配减7，空位减5。给出一个阈值T，留下高于T的单词匹配对，作为后面extend的seed。
![字母对打分表](https://upload-images.jianshu.io/upload_images/3014937-cea0158aebc2c6ed.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

3. 为每对单词执行上面步骤，找出所有打分高于T单词对。找到所有的seed。

4.在实际运行中，算法最大的消耗在步骤extend上面，减少extend的方法就是减少seed的数目。对于选出的seed，可以将距离相近的合并为一个seed，这样就可以减少大量extend的计算量。

5.下一步是extend的步骤，对于每一对选择出来的种子，将其向两边延伸，使其在尽可能长的距离得到尽可能多的分数。具体方法是逐渐向两边扩展，规定常数 D，在扩展到分数为Highest Score-D时停止，如果最终得分大于得分阈值S，则将其设为高分区域HSP(high-scoring segment pair, HSP)。
![extend字组](https://upload-images.jianshu.io/upload_images/3014937-f34d9d7b9609ece0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

6. 将相邻的或距离较近的HSP合并。

7. 对于每部分HSP使用Smith-Watermans算法进行局部性比对，为每部分打分，作为最终结果。

这里我们知道BLAST是基于局部比对的方法，另一个常用来做序列比对的方法是全局比对，ClustalW是其中的一个代表。

#ClustalW
CLUSTALW(它的PC版本是CLUSTALX)是目前使用最广泛的多序列比对程序。它采用的是一种渐进的比对方法(progressive methods)，先将多个序列两两比对构建距离矩阵，反映序列之间两两关系；然后根据距离矩阵计算产生系统进化指导树，对关系密切的序列进行加权；然后从最紧密的两条序列开始，逐步引入临近的序列并不断重新构建比对，直到所有序列都被加入为止。

![ClustalW基本步骤](https://upload-images.jianshu.io/upload_images/3014937-b6ef22c42dddd5a6.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

ClustalW采用的是全局比对的算法，所以当我们用BLAST和ClustalW进行比对的时候结果很大概率上是不一样的，下图是一个例子
![全局比对VS局部比对](https://upload-images.jianshu.io/upload_images/3014937-420ce025cb1ccfbf.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

这样引出一个问题，我们什么时候选择用BLAST，什么时候选择用ClustalW呢？
下面的表可以用来进行参考

全局比对 | 局部比对
------------ |--------------
比较的是全部长度(end to end alignment) | 找到局部最高相似性
包含query和target全部信息 | 匹配部分query信息到target上
如果两条序列长度相当，相似性高，建议全局 | 只考虑序列的局部结构
全部匹配常见于寻找同源基因 (人和老鼠)| 常见于寻找DNA的保守区域
采用Needleman-Wunsch算法 | 采用Smith-Whaterman算法

上世纪70年代，Needleman-Wunsch提出了End-to-end的全局比对算法，但是随着越来越多的蛋白质被测序，人们越来约发现某些蛋白差异虽然很大，但是在局部的功能域上却很相似，这些功能域相当保守且发挥相近的重要功能，但是仅靠全局比对算法却很那发现他们。所以就有了Smith-Whaterman算法。Smith-Whaterman算法的主要创新点是给Needleman-Wunsch的算法设置了一个最低罚分不超过0的选项。公式看起来很简单。但是这个0花了整整10年时间，其实这个0只是赋予了一部分（局部）重新开始的机会。

![全局对比和局部比对算法](https://upload-images.jianshu.io/upload_images/3014937-db27275d8d26ecb2.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


