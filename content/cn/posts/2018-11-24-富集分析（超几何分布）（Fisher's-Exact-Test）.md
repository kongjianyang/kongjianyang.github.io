---
title: 富集分析（超几何分布）（Fisher's-Exact-Test）
author: Liang
date: '2018-11-24'
slug: 富集分析（超几何分布）（Fisher's-Exact-Test）
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
# 1. 简介
超几何分布（hypergeometric）是统计学上一种离散概率分布。它描述了由有限个物件中抽出n个物件，成功抽出指定种类的物件的个数（不归还）。

超几何分布和Fisher's Exact Test是完全一模一样的原理，只是两种不同的称谓。

 例如在有N个样本，其中m个是不及格的。超几何分布描述了在该N个样本中抽出n个，其中k个是不及格的机率：

![公式](https://upload-images.jianshu.io/upload_images/3014937-38681a7eb825d7e3.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

上式可如此理解：n^N 表示所有在N个样本中抽出n个，而抽出的结果不一样的数目。
k^m 表示在m个样本中，抽出k个的方法数目。剩下来的样本都是及格的，而及格的样本有N-m个，剩下的抽法便有(n-K^N-m)种。

若n=1，超几何分布还原为伯努利分布。

若N接近∞，超几何分布可视为二项分布。注意二项分布是有归还 (with replacement) 的抽取。

然后计算得到的p-value通过Bonferroni校正之后，以0.05为阈值（小于0.05），满足此条件的GO term定义为显著富集。

（1）超几何分布的模型是不放回抽样

（2）超几何分布中的参数是M,N,n上述超几何分布记作X~H(n，M，N）。

# 2. 例子
以文章Gene Expre ssion in Ovarian Cancer Reflects Both Morphology and Biological Behavior, Distinguishing Clear Cell from Other Poor-Prognosis Ovarian Carcinomas所鉴定的差异基因为例。

测试一下这些基因和化学刺激响应的相关性。

样本的大小是n，属于“化学刺激响应”这个分类的基因有k个。
```
eg <- c("7980", "3081", "3162", "3059", "1545", "1917", "6696", "5797", "6648" , "10397" , "6781", "5817", "1282", "1284", "6948", "7077")
n <- length(eg)
k <- sum(eg %in% allgeneInCategory)
n
k
#16
#12
```
那么做为背景，总体基因为N，属于“化学刺激响应”这个分类的基因有M个。
```
library(org.Hs.eg.db)
goid <- "GO:0042221"
allgeneInCategory <- unique(get(goid, org.Hs.egGO2ALLEGS))
M <- length(allgeneInCategory)
N <- length(mappedkeys(org.Hs.egGO))
M 
N
#4373
#19307
```


## 2.1 二项式分布
从总体上看，要拿到一个基因属于“化学刺激响应”这个分类的概率是M/N。那么现在抽了n个基因，里面有k个基于这个分类，p值为
```
1-sum(sapply(0:k-1, function(i) choose(n,i) * (M/N)^i * (1-M/N)^(n-i)))
#1.301651e-05
```
## 2.2 超几何分布
二项式分布，是有放回的抽样，你可以多次抽到同一基因，这是不符合的。所以这个计算只能说是做为近似的估计值，无放回的抽样，符合超几何分布，通过超几何分布的计算，p值为：

```
phyper(k-1,M, N-M, n, lower.tail=FALSE)
#1.289306e-05
```

用2x2表做独立性分析
```{r}
d <- data.frame(gene.not.interest=c(M-k, N-M-n+k), gene.in.interest=c(k, n-k))
row.names(d) <- c("In_category", "not_in_category")
d
```
![2x2表分析](https://upload-images.jianshu.io/upload_images/3014937-b7e20d37f208921f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

##2.3 卡方检验
对于２x２表来说，卡方检验通常也只能做为近似估计值，特别是当sample size或expected ell count比较小的时候，计算并不准确。
```{r}
chisq.test(d, )
#Chi-squared approximation may be incorrect
#	Pearson's Chi-squared test with Yates' continuity correction

#data:  d
#X-squared = 22.148, df = 1, p-value = 2.525e-06
```

##2.4 Fisher精确检验
名副其实，真的就比较exact，因为它使用的是超几何分布来计算p值。Fisher精确检验是基于超几何分布计算的，它分为两种，分别是单边检验（等同于超几何检验）和双边检验。
```{r}
fisher.test(d)
#	Fisher's Exact Test for Count Data

#data:  d
#p-value = 1.289e-05
#alternative hypothesis: true odds ratio is not equal to 1
#95 percent confidence interval:
# 0.02285468 0.32152483
#sample estimates:
#odds ratio 
#0.09739934 
```


# 3. 额外
1.n大于等于40.所有理论频数大于等于5---用卡方检验
2.n大于等于40，所有理论频数大于1，小于5----用校正的卡方
3.n小于40，理论频数小于1-----用fish精确概率法
