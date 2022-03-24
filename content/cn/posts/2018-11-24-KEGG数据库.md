---
title: KEGG数据库
author: Liang
date: '2018-11-24'
slug: KEGG数据库
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
KEGG(Kyoto Encyclopedia of Genes and Genomes)是系统分析基因功能、基因组信息数据库，它有助于研究者把基因及表达信息作为一个整体网络进行研究。KEGG主要包含以下数据库：
![](https://upload-images.jianshu.io/upload_images/3014937-4e2dd818e7c4087f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

其中在 KEGG PATHWAY 数据库中，将生物代谢通路划分为 6 类，分别为：细胞过程（Cellular Processes）、环境信息处理（Environmental Information Processing）、遗传信息处理（Genetic Information Processing）、人类疾病（Human Diseases）、新陈代谢（Metabolism）、生物体系统（Organismal Systems），其中每类又被系统分类为二、三、四层。第二层目前包括有 43 种子 pathway；第三层即为其代谢通路图；第四层为每个代谢通路图的具体注释信息。

# 2. 探索
首先打开KEGG数据库，你会进入下面这个界面，我们直奔主题，点击KEGG PATHWAY。 
![](https://upload-images.jianshu.io/upload_images/3014937-96e9136d05a8e512.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![](https://upload-images.jianshu.io/upload_images/3014937-9154223f43e75942.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![](https://upload-images.jianshu.io/upload_images/3014937-62ef46c4eb54d38d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
点击三级分类的通路，就可以找到我们想要的pathway map了。比如点击三级分类pathway map 的“cell cycle”，然后就进入了下面这样的界面。 

![](https://upload-images.jianshu.io/upload_images/3014937-893919bc52192dc9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

一般默认是人的pathway，如果你像查看其他物种上的pathway，你需要点击下拉三角形，选择你所关心的物种。如下面图中所示 

![](https://upload-images.jianshu.io/upload_images/3014937-151e70b360f25940.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
KEGG pathway中有着大量的通路图，以PI3K-Akt signaling pathway（ko04151）为例，里面包含了大量的蛋白等化合物，以及它们之间相互作用的关系。  
![](https://upload-images.jianshu.io/upload_images/3014937-5f5708fb5d95dcb4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
# 3. 看图说话

在KEGG中有两种代谢图

- 参考代谢通路图reference pathway，是根据已有的知识绘制的概括的、详尽的具有一般参考意义的代谢图，这种图上就不会有绿色的小框，而都是无色的，所有的框都可以点击查看更详细的信息；

- 特定物种的代谢图species-specific pathway，会用绿色来标出这个物种特有的基因或酶，只有这些绿色的框点击以后才会给出更详细的信息。

这两种图很好区分，reference pathway 在KEGG中的名字是以map开头的，比如map00010，就是糖酵解途径的参考图；而特定物种的代谢通路图开头三个字符不是map而是种属英文单词的缩写（应该就是一个属的首字母+2个种的首字母）比如酵母的糖酵解通路图，就是sce00010，大肠杆菌的糖酵解通路图就应该是eco00010。
代谢通路中各种符号标识 ：

- K+num：基因ID号，表示在所有同源物种中具有相似结构或功能的一类同源蛋白
- ko+num： 代谢通路名称，表示一个特定的生物路径
- M+ num： 模块名称
- C+ num： 化合物名称
- E-,-,-,-： 酶名称
- R + num : 反应名
- RC+ num ： 反映类型
- RP+num： 反应物对

图例作用关系：

![](https://upload-images.jianshu.io/upload_images/3014937-c07690f6350716cd.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


参考：
https://www.wxwenku.com/d/106727898
http://blog.sciencenet.cn/blog-1835014-1123749.html








