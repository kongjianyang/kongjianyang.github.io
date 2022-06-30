---
title: "GSEA和GSVA分析"
date: 2022-06-28T19:10:27-04:00
author: KJY
slug: GSEA
draft: false
toc: true
categories:  
  - hugo
tags:        
  - article
---



GSEA全称Gene Set Enrichment Analysis，GSVA全称Gene Set Variation Analysis，它们都是基于基因集开展的分析，因此我们先要了解基因集的定义。基因集顾名思义就是一些基因的集合，任何一些基因放在一起都可以叫做基因集，但是我们用来分析的基因集要求有一定的生物学意义。



MSigDB（Molecular Signatures Database）数据库中定义了已知的基因集合：http://software.broadinstitute.org/gsea/msigdb 包括H和C1-C7八个系列（Collection），每个系列分别是：

H:hallmark gene sets （癌症）特征基因集合，共50组，最常用；
C1: positional gene sets 位置基因集合，根据染色体位置，共326个，用的很少；
C2: curated gene sets：（专家）校验基因集合，基于通路、文献等：
C3: motif gene sets：模式基因集合，主要包括microRNA和转录因子靶基因两部分
C4: computational gene sets：计算基因集合，通过挖掘癌症相关芯片数据定义的基因集合；
C5: GO gene sets：Gene Ontology 基因本体论，包括BP（生物学过程biological process，细胞原件cellular component和分子功能molecular function三部分）
C6: oncogenic signatures：癌症特征基因集合，大部分来源于NCBI GEO 发表芯片数据
C7: immunologic signatures: 免疫相关基因集合。

常规GO/KEGG富集分析需要设定阈值过滤差异基因，阈值太宽富集的结果太多，阈值太严又可能会遗漏一些关键结果。GO/KEGG富集的结果通常还很宽泛，并不能很好地解释生物学现象。有鉴于此，Broad研究所开发了基因集富集分析(GSEA)方法。GSEA使用无监督算法，不用过滤任何基因，配合MSigDB数据库使用，更容易找到解释生物学现象的基因集.



GSEA分析要先将样本做组间对比分析, 对比分析之后要按结果将基因排序，以差异倍数方法为例，把所有基因按差异倍数(FC)的值降序排列以供后续分析。



![img](https://upload-images.jianshu.io/upload_images/19009296-fa72995c15acb2f8?imageMogr2/auto-orient/strip|imageView2/2/w/1080/format/webp)





上图小人脚下的小方块代表排序好的差异基因列表，蓝色之外的其他色块代表属于某个基因集的基因，如黄色属于基因集A，绿色属于基因集B。最下面高低不等的竖条代表与基因列表对应的FC值，红色上调、蓝色下调、黄色没有变化。基因集的富集分析需要经历三步：



基因集A富集分析时，小人从基因列表的左端走到右端，每经过一个蓝色基因扣分，每遇到一个黄色基因加分，扣分时与FC无关，加分时考虑FC的权重。基因集A最终的富集分数(ES)是小人曾经得过的最高/低分，实际公式比这复杂，但基本理念如此。

采用置换检验(Permutation testing)计算基因集A的显著性，即p值。

基因集A富集分析完成后，按上述同样的方法完成基因集B、C直至所有输入基因集的分析。所有需要富集分析的基因集都计算ES和p值之后，将ES转换为标准富集分数(NES)，并计算校正后p值。



(1)背景基因排序：将全部基因按照某种指标（差异分析p值，表型相关性，表达量等）进行排序，比如log2FC排序。

(2)目标基因富集：将某个特定类型的基因在排序表中标出，目标基因可以是某个通路或GO terms的基因等。

(3)计算富集分数：使用加权法，计算ES值变化。对位于中部（与性状相关性低）的部分采用较小的权值，所以越集中在两端，与表型的相关性越高。ES曲线最大值为富集分数（Enrichment Score）。

(4)Permutation test：对基因集的ES值进行显著性检验及多重假设检验，从而计算出显著富集的基因集。

enrichmentScore：富集得分。ES 反映基因集中的基因（S）在排序列表基因（L）的两端富集的程度。计算方式是，从基因集 L 的第一个基因开始，计算一个累计统计值。当遇到一个落在 D 里面的基因，则增加统计值。遇到一个不在 S 里面的基因，则降低统计值。每一步统计值增加或减少的幅度与基因的表达变化程度（更严格的是与基因和表型的关联度，可能是 fold-change，也可能是 pearson corelation 值）是相关的（可以是线性相关，也可以是指数相关）。富集得分 ES 最后定义为最大的峰值。正值 ES 表示基因集在列表的顶部富集，负值 ES 表示基因集在列表的底部富集。

由于不同用户输入的基因数据库文件中的基因集数目可能不同，富集评分的标准化考虑了基因集个数和大小。其**绝对值大于1**为一条富集标准。

通常情况下，我们一般认为|NES|>1，NOM p-val<0.05，FDR q-val<0.25的通路下的基因集合是有意义的。



pvalue: 统计检验的 p 值，也称为 NOM p-val。通过基于表型而不改变基因之间关系的排列检验 (permutation test)计算观察到的富集得分(ES)出现的可能性。若样品量少，也可基于基因集做排列检验 (permutation test)，计算p-value。

这里得到的表格即说明（假设是由两组分析后得到的 logFC 作为分子的值）对应的基因集在两组内有差异，当 ES 或者 NES 为正时，说明该基因集在高表达组（头部）富集；当 ES 或者 NES 为负时，说明该基因集在低表达组（尾部）富集。结果这里一般只需要关注满足阈值（p.adj）



GSEA虽然是一种强大的富集分析工具，但是它的应用场景通常局限于Case/Control的实验设计。

GSVA不需要预先进行样本之间的差异分析，它依据表达矩阵就可以计算每个样本中特定基因集的变异分数。简单的说，输入以基因为行的表达矩阵和基因集数据库给GSVA，它就输出以基因集名称为行的变异分数矩阵，如下图所示：

![img](https://upload-images.jianshu.io/upload_images/19009296-f092b5b61ea13972?imageMogr2/auto-orient/strip|imageView2/2/w/1080/format/webp)

左侧输入基因表达矩阵和基因集数据库，中间是GSVA算法原理，右侧是输出的基因集变异分数矩阵。基因集变异分数可以理解为基因集内所有基因的综合表达值。

(1)算法会对表达数据进行核密度估计；

(2)基于第一步的结果对样本进行表达水平排序；

(3)对于每一个基因集进行类似K-S检验的秩统计量计算；

(4)获取GSVA富集分数。最终输出为以每个基因集对应每个样本的数据矩阵。



GSVA 可以寻找样本间有显著差异的基因集。这些“差异表达”的基因集，相对于基因而言，更加具有生物学意义，更具有可解释性，可以进一步用于肿瘤subtype的分型等等与生物学意义结合密切的探究。
