---
title: 三维基因组学研究之Hi-C
author: Liang
date: '2018-11-24'
slug: 三维基因组学研究之Hi-C
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
# 1. 技术原理
基因组研究的维度可以分为很多种，例如下图所示

![](https://upload-images.jianshu.io/upload_images/3014937-84cb24e699b55840.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

其中Hi-C是研究三维结构的一种方法。Hi-C技术源于染色体构象捕获（Chromosome Conformation Capture, 3C）技术，利用高通量测序技术，结合生物信息分析方法，**研究全基因组范围内整个染色质DNA在空间位置上的关系**，获得高分辨率的染色质三维结构信息。

其中染色质构象捕获（3C）技术是用福尔马林瞬时固定细胞核染色质，用过量的限制性内切酶酶切消化染色质 - 蛋白质交联物，在 DNA 浓度极低而连接酶浓度极高的条件下用连接酶连接消化物，蛋白酶消化交联物以释放出结合的蛋白质，用推测可能有互作的目的片段引物进行普通PCR和定量PCR来确定是否存在相互作用。3C 技术假定**物理上互作的 DNA 片段连接频率最高，以基因座特异性 PCR 来检测基因组中 DNA 片段之间的物理接触，最终以 PCR 产物的丰度来确定是否存在相互作用**。

Hi-C技术在3C的基础上，在酶切后将缺口进行补平（dCTP 进行生物素标），然后用连接酶进行连接，将样本进行超声破碎，随后用生物素亲和层析将片段沉淀（也就是抓下来带有生物素标记的片段），加上接头进行深度测序。

# 2. 技术流程
下图显示其技术流程
![](https://upload-images.jianshu.io/upload_images/3014937-b66c93b9c55b0e7e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


第一步还是用甲醛使细胞内**空间上靠近的DNA片段形成共价键**；然后用限制性内切酶将染色质片段化；第三步用生物酰化的核酸分子链接酶切形成的粘性末端，链接过程需要在稀释的溶液中进行，有助于形成分子内链接；第四步纯化并片段化DNA，用链霉亲和素的磁珠富集含生物酰化的junction片段；最后，对收集到的junction片段进行建库并使用pair-end方法测序。

# 3. 分析步骤

Hi-C的优势在于其结合了二代测序，这势必也使得其数据分析相对复杂了。目前比较成熟的数据分析流程大致包含6个步骤：

（1）      前期raw reads过滤（跟一般二代测序数据处理基本一致）
（2）      序列比对。建议采用pair-end测序模式
（3）      定位酶切位点。比对寻找到reads pairs在基因组物理位置之后，通过插入片段大小的限制搜索reads pairs两端每条read所对应的最近的酶切片段。酶切片段的位置代表了DNA交互产生的大致位置
（4）      筛选出有效的比对片段。配对的reads位于酶切位点两端且mapped的方向相反
（5）      整合DNA  片段交互强度。
（6）      DNA片段交互矩阵标准化。

分析流程可如下图所示：
![](https://upload-images.jianshu.io/upload_images/3014937-09c5bfbeff18467e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
