---
title: WGCNA构建基因共表达网络详细教程
author: Liang
date: '2018-11-24'
slug: WGCNA构建基因共表达网络详细教程
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
这篇文章更多的是对于混乱的中文资源的梳理，并补充了一些没有提到的重要参数，希望大家不会踩坑。

#1. 简介
## 1.1 背景
WGCNA（weighted gene co-expression network analysis，权重基因共表达网络分析）是一种分析多个样本基因表达模式的分析方法，可将表达模式相似的基因进行聚类，并分析模块与特定性状或表型之间的关联关系，因此在基因组研究中被广泛应用。

相比于只关注差异表达的基因，WGCNA利用数千或近万个变化最大的基因或全部基因的信息识别感兴趣的**基因集**，并与表型进行显著性关联分析。既充分利用了信息，也把数千个基因与表型的关联转换为数个基因集与表型的关联，免去了多重假设检验校正的问题。

WGCNA算法首先假定基因网络服从**无尺度分布**(scale free network)，并定义基因共表达相关矩阵、基因网络形成的邻接函数，然后计算不同节点的相异系数，并据此构建分层聚类树(hierarchical clustering tree)，该聚类树的不同分支代表不同的基因模块(module)，模块内基因共表达程度高，而分属不同模块的基因共表达程度低。

##1.2 无尺度网络
网络的数学名称是图，在图论中对于每一个节点有一个重要概念，即：度(degree)。一个点的度是指图中该点所关联的边数。如下图，如果不加以思考，人们很容易认为生活中常见的网络会是一种random network，即每一个节点的度相对平均。然而第二种图，即scale-free network才是一种更稳定的选择。Scale-free network具有这样的特点，即存在少数节点具有明显高于一般点的度，这些点被称为hub。由少数hub与其它节点关联，最终构成整个网络。这样的网络的节点度数与具有该度数的节点个数间服从power distribution。生物体选择scale-free network而不是random network尤其进化上的原因，对于scale-free network，少数关键基因执行主要功能，这种网络具有非常好的鲁棒性(Robust)，即只要保证hub的完整性，整个生命体的基本活动在一定刺激影响下将不会受到太大影响，而random network若受到外界刺激，其受到的伤害程度将直接与刺激强度成正比。

![随机网络，大部分节点都连出2到3条边，0条与1条边的和4条边的都很少，而无尺度网络中，大部分节点连1条边，少数节点（红色）连有大量边。](https://upload-images.jianshu.io/upload_images/3014937-3ebbf5b6687c0379.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 1.3 相关术语

*   共表达网络：点代表基因，边代表基因表达相关性。加权是指对**相关性值进行冥次运算** (冥次的值也就是**软阈值** (power, pickSoftThreshold这个函数所做的就是确定合适的power))。无向网络(unsigned network)的边属性计算方式为 `abs(cor(genex, geney)) ^ power`；有向网络(signed network)的边属性计算方式为 `(1+cor(genex, geney)/2) ^ power`; sign hybrid的边属性计算方式为`cor(genex, geney)^power if cor>0 else 0`， **sign hybrid意味着它既包含加权网络也包含非加权网络**。这种处理方式强化了强相关，弱化了弱相关或负相关，使得相关性数值更符合`无标度网络`特征，更具有生物意义。除了软阈值还有硬阈值一说，计算方式是 a_ij = 1 if s_ij > β otherwise a_ij = 0。这里的β就是硬阈值(hard threshold)。

*   Module(模块)：高度內连的基因集。在无向网络中，模块内是高度**相关**的基因。在有向网络中，模块内是高度**正相关**的基因。

*   Connectivity (连接度)：类似于网络中 “度” (degree)的概念。每个基因的连接度是与其相连的基因的`边属性之和`。

*   Module eigengene E: 给定模型的第一主成分，代表**整个模型的基因表达谱**。即用一个向量代替了一个矩阵，方便后期计算。

*   Intramodular connectivity: 给定基因与给定模型内其他基因的关联度，判断基因所属关系。

*   Adjacency matrix (邻接矩阵)：基因和基因之间的加权相关性值构成的矩阵。

*   TOM (Topological overlap matrix)：把邻接矩阵转换为拓扑重叠矩阵，以降低噪音和假相关，获得的新距离矩阵，这个信息可拿来构建网络或绘制TOM图。


# 2. 一般步骤

![WGCNA一般步骤](https://upload-images.jianshu.io/upload_images/3014937-b8c34cba39d409d4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

# 3. 代码
利用WGCNA有一步法建网络的，也有step by step的方法，为了保证理解，建议至少过一遍step by step。

安装WGCNA根据不同的操作系统可能略有不同，我在macOS下安装着实废了一番功夫。这一部分不提。

```
# 加载必须的包并做参数设置
library(MASS)
library(class)
library(cluster)
library(impute)
library(Hmisc)
library(WGCNA)
options(stringsAsFactors = F)
```
读取基因表达数据，注意要做一个转换，保证基因在列，样品在行，官方推荐使用Deseq2的`varianceStabilizingTransformation`或`log2(x+1)`对标准化后的数据做个转换。如果数据来自不同的批次，需要先移除批次效应。如果数据存在系统偏移，需要做下quantile normalization。一般要求样本数多于15个。样本数多于20时效果更好，样本越多，结果越稳定。
```{r}
dat0 <- read.csv("./01raw_data/GBM55and65and8000.csv")
datExprdataOne <- t(dat0[,15:69])
datExprdataTwo <- t(dat0[, 70:134])
datSummary <- dat0[, c(1:14)]
dim(datExprdataOne); dim(datExprdataTwo); dim(datSummary)
rm(dat0)
#[1]   55 8000
#[1]   65 8000
#[1] 8000   14
```
检验数据质量
```{r}
gsg = goodSamplesGenes(datExprdataOne, verbose = 3)
if (!gsg$allOK){
  # Optionally, print the gene and sample names that were removed:
  if (sum(!gsg$goodGenes)>0) 
    printFlush(paste("Removing genes:", 
                     paste(names(datExprdataOne)[!gsg$goodGenes], collapse = ",")));
  if (sum(!gsg$goodSamples)>0) 
    printFlush(paste("Removing samples:", 
                     paste(rownames(datExprdataOne)[!gsg$goodSamples], collapse = ",")));
  # Remove the offending genes and samples from the data:
  datExprdataOne = datExprdataOne[gsg$goodSamples, gsg$goodGenes]
}
#Flagging genes and samples with too many missing values...
#  ..step 1
```
检查是否有离群值，结果显示无
```{r}
sampleTree = hclust(dist(datExprdataOne), method = "average")
plot(sampleTree, main = "Sample clustering to detect outliers", sub="", xlab="")
```
![离群值检测](https://upload-images.jianshu.io/upload_images/3014937-7ae3b977b3e3966f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

筛选软阈值， 无向网络在power小于15或有向网络power小于30内，没有一个power值可以使无标度网络图谱结构R^2达到0.8或平均连接度降到100以下，则可能是由于部分样品与其他样品差别太大造成的。这可能由批次效应、样品异质性或实验条件对表达影响太大等造成，需要移除。

```{r}
powers1 <- c(seq(1, 10, by=1), seq(12, 20, by=2))
sft <- pickSoftThreshold(datExprdataOne, powerVector = powers1)
RpowerTable <- pickSoftThreshold(datExprdataOne, powerVector = powers1)[[2]]
```
```{r}
cex1 = 0.7
par(mfrow = c(1,2))
plot(RpowerTable[,1], -sign(RpowerTable[,3])*RpowerTable[,2], xlab = "soft threshold (power)", ylab = "scale free topology model fit, signes R^2", type = "n")
text(RpowerTable[,1], -sign(RpowerTable[,3])*RpowerTable[,2], labels = powers1, cex = cex1, col = "red")
abline(h = 0.95, col = "red")
plot(RpowerTable[,1], RpowerTable[,5], xlab = "soft threshold (power)", ylab = "mean connectivity", type = "n")
text(RpowerTable[,1], RpowerTable[,5], labels = powers1, cex = cex1, col = "red")
```

![软阈值筛选](https://upload-images.jianshu.io/upload_images/3014937-983815e8026ebdb0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

横轴是Soft threshold (power)，纵轴是无标度网络的评估参数，数值越高，网络越符合无标度特征 (non-scale)。
我们可以使用系统给的参数帮助我们得到soft threshold，可以是
```
sft$powerEstimate
#4
```
给出的是4，因为这个筛选的标准是R-square=0.85，但是我们希望R-square的值达到0.9，所以选择power值为6.

利用power=6计算connectivity，并且可视化无尺度网络图的拓扑结构
```{r}
betal = 6
k.dataOne <- softConnectivity(datExprdataOne, power = betal) -1
k.dataTwo <- softConnectivity(datExprdataTwo, power = betal) - 1
par(mfrow=c(2,2))
scaleFreePlot(k.dataOne, main = paste("data set I, power=", betal), truncated = F)
scaleFreePlot(k.dataTwo, main = paste("data set II, power=", betal), truncated = F)
```
![Data I scale free plot](https://upload-images.jianshu.io/upload_images/3014937-11b57ae3e23638cf.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![Data II scale free plot](https://upload-images.jianshu.io/upload_images/3014937-fabcfec8b4df355b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

筛选连通性最高的3600个基因做为后续分析，不过一般不在这一步进行筛选，因为生物体内的基因网络图更多的是无尺度的。
```{r}
kCut <- 3601
kRank <- rank(-k.dataOne)
vardataOne <- apply(datExprdataOne, 2, var)
vardataTwo <- apply(datExprdataTwo, 2, var)
restK <- kRank <= kCut & vardataOne >0 & vardataTwo > 0 
ADJdataOne <- adjacency(datExpr = datExprdataOne[,restK], power = betal)
dissTOMdataOne <- TOMdist(ADJdataOne)
hierTOMdataOne <- hclust(as.dist(dissTOMdataOne), method = "average")
par(mfrow = c(1,1))
plot(hierTOMdataOne, labels = F, main = "dendrogram, 3600 mast connected in data set I")
```
![Data I的层级聚类图](https://upload-images.jianshu.io/upload_images/3014937-82bacf08123d508b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

层级聚类树展示各个模块, 灰色的为**未分类**到模块的基因，这里使用的`cutreeStaticColor`检测module，但是对于复杂的基因结构建议使用 `cutreeDynamic`。其中也有一些具体的参数可以选择得到合适的module。
```{r}
colordataOne <- cutreeStaticColor(hierTOMdataOne, cutHeight = 0.94, minSize = 125)
par(mfrow=c(2,1), mar = c(2,4,1,1))
plot(hierTOMdataOne, main = "Glioblastoma data set 1, n = 55", labels = F, xlab = "", sub = "")
plotColorUnderTree(hierTOMdataOne, colors = data.frame(module = colordataOne))
title("module membership data set I")
```
![Data I层级聚类图](https://upload-images.jianshu.io/upload_images/3014937-e0c5b0fcdd39d7ee.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

后续换了一种方法希望得到更多module以期得到更多的eigegene。


```{r}
dataOne_net = blockwiseModules(datExprdataOne, power = 6, maxBlockSize = 200,
                       TOMType = "signed", minModuleSize = 30,
                       reassignThreshold = 0, mergeCutHeight = 0.25,
                       numericLabels = TRUE, pamRespectsDendro = FALSE,
                       saveTOMs=TRUE, corType = "pearson", 
                       loadTOMs=TRUE,
                       saveTOMFileBase = "DataI.tom",
                       verbose = 3)

# Calculating module eigengenes block-wise from all genes
#  Flagging genes and samples with too many missing values...
#    ..step 1
# ....pre-clustering genes to determine blocks..
#   Projective K-means:
#   ..k-means clustering..
#   ..merging smaller clusters...
# Block sizes:
```
绘制模块之间相关性图

```{r}
dataOne_MEs <- dataOne_net$MEs

plotEigengeneNetworks(dataOne_MEs, "Eigengene adjacency heatmap", 
                      marDendro = c(3,3,2,4),
                      marHeatmap = c(3,4,2,2), plotDendrograms = T, 
                      xLabelsAngle = 90)
```
![eigengene聚类及热图](https://upload-images.jianshu.io/upload_images/3014937-e65b58c54a99add1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

可视化基因网络 (TOM plot)

```{r}
load(dataOne_net$TOMFiles[1], verbose=T)

## Loading objects:
##   TOM

TOM <- as.matrix(TOM)

dissTOM = 1-TOM
# Transform dissTOM with a power to make moderately strong 
# connections more visible in the heatmap
plotTOM = dissTOM^7
# Set diagonal to NA for a nicer plot
diag(plotTOM) = NA
# Call the plot function

TOMplot(plotTOM, dataOne_net$dendrograms, 
        main = "Network heatmap plot, all genes")
```


![Data I的TOM plot](https://upload-images.jianshu.io/upload_images/3014937-e87b0b493dff54dd.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

导出网络图

```{r}
probes = colnames(dat0[,15:69])
dimnames(TOM) <- list(probes, probes)
# Export the network into edge and node list files Cytoscape can read
cyt = exportNetworkToCytoscape(TOM,
             edgeFile = "edges.txt",
             nodeFile = "nodes.txt",
             weighted = TRUE, threshold = 0,
             nodeNames = probes, nodeAttr = dataOne_net$colors)
```  


部分参考：

http://blog.sciencenet.cn/blog-118204-1111379.html

https://www.jianshu.com/p/94b11358b3f3




