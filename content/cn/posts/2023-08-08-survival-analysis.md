---
title: "生存分析入门"
date: 2023-08-08T15:58:44-07:00
author: KJY
slug: "生存分析"
draft: false
toc: true
categories:  
  -bioinfo
tags:        
  - article
---

作为临床分析中的重要一环，今天入门生存分析。

生存分析（survival analysis）是生物医学研究中常用的分析方法。在队列随访研究中，我们会事先定义一些观察终点，比如肿瘤复发、患者死亡、血压达标等，这些终点称为事件（event）。从研究开始到发生事件的时间间隔称为生存时间（survival time）。

由于生存时间数据具有以下两个特点，所以提出生存分析这一特殊的分析方法：

（1）偏态分布：生存时间通常具有明显的偏态分布，有正态分布假设的统计方法不能适用。
（2）删失（censoring）：研究对象在观察时间内没有发生事件称为删失。一种情况是研究对象在中途失访或退出，导致没有观察到事件；另一种情况是超过了最长的随访时间事件仍未发生。删失数据是一种不完整数据，是生成分析独有的重要组成部分。


生存分析使用的方法：

1. Kaplan-Meier plots to visualize survival curves（根据生存时间分布，估计生存率以及中位生存时间，以生存曲线方式展示，从而分析生存特征，一般用Kaplan-Meier法，还有寿命法）
2. Log-rank test to compare the survival curves of two or more groups（通过比较两组或者多组之间的的生存曲线，一般是生存率及其标准误，从而研究之间的差异，一般用log rank检验）
3. Cox proportional hazards regression to describe the effect of variables on survival（用Cox风险比例模型来分析变量对生存的影响，可以两个及两个以上的因素，很常用）

所以一般做生存分析，可以用KM（Kaplan-Meier）方法估计生存率，做生存曲线，然后可以根据分组检验一下多组间生存曲线是否有显著的差异，最后用Cox风险比例模型来研究下某个因素对生存的影响



# Kaplan-Meier生存曲线估计

在t检验或回归分析中，我们估计的是研究对象的一些参数，比如均值、标准差、回归系数等。而在生存分析中，我们得到的不是单个特定的数值，而是一条曲线，称为生存曲线（survival curve）。曲线对应的函数称为生存函数（survival function），用S(t)表示，其定义为：

S(t)是个体生存超过时间t的概率

以时间t为横坐标，S(t)为纵坐标，绘制出来的曲线就是生存曲线。生存曲线具有两个特点：

（1）显然，在观察开始的时候，所有个体都是存活的，所以S(t=0)=1；
（2）时间越长，生存的概率越小，所以S(t)是递减的。

表1展示了KM法的计算过程。

![](/img/2023-08-08-21-02-37.png)


表1一共包含5列，最后两列可以通过前三列计算出来。第一列是生存时间t，注意不包含删失的时间，但包含时间0。第二列是t时刻事件发生个体数，可以看到大部分数据为1。第三列是t时刻仍然存活的个体数。

前三行准备好后，第四行就是一个简单的数学计算。除了第一行外，其余各行的第五列等于上一行的第五列乘以本行的第四列。

# 假设检验Log-rank

在很多情况下，我们需要比较两组生存曲线之间有无差别，比如某种新药组的患者生存率是否比常规药物组要高。一种容易想到的方法是指定一个时间点，比如2年，分别计算出两组生存时间超过2年的个案数，然后进行2×2列联表的χ2检验。这个方法有两个明显的缺点：一是由于删失的存在，难以准确计算生存率；二是时间长度可以随意指定，带来分析结果的偏差。


Log-rank检验的零假设是两组生存曲线一样的。如果零假设成立，那么两组内的事件发生个体数之比应该等于两组样本数之比，由此计算出事件发生的期望数。Log-rank方法就是分别将两组所有时间点的期望数加起来，与所有观察数进行比较。

# Cox比例风险回归模型

在临床研究中，有许多情况，其中几个已知量（称为 协变量covariates）可能会影响患者的预后。

例如，假设比较了两组患者：有和没有特定基因型的患者。如果其中一组还包含较年长的个体，则生存率的任何差异都可能归因于基因型或年龄，或两者都有。因此，在调查与任何一个因素相关的生存率时，通常需要针对其他因素的影响进行调整。

Cox模型的目的是同时评估几个因素对生存的影响。换句话说，它允许我们检查特定因素如何影响特定时间点特定事件（例如，感染，死亡）的发生率。该比率通常称为风险比率。

Cox模型与Kaplan-Meier法：

Kaplan-Meier法是非参数法，而Cox模型是半参数法，一般来说在符合一定条件下，后者的检验效应要大于前者
Kaplan-Meier法一般处理单因素对研究生存结局的影响，而Cox模型可以同时处理多个因素对生存结局的影响

当预测变量为分类变量时（例如：治疗A与治疗B；男性与女性），Kaplan-Meier曲线和对数秩检验才有用。对于定量预测指标（例如基因表达，体重或年龄），它们并不容易工作。

一种替代方法是Cox比例风险回归分析，它既适用于定量预测变量也适用于类别变量。此外，Cox回归模型扩展了生存分析方法，可以同时评估几种风险因素对生存时间的影响。

# R语言分析



```{r}
# 确保在导入前安装好
library(survival)
library(dplyr)
library(survminer)
library(tidyverse)
```

我们将使用的核心函数包括：

Surv()：创建一个生存对象
survfit()：使用公式或已构建的Cox模型拟合生存曲线
coxph()：拟合Cox比例风险回归模型


我们将使用内置的肺癌数据集学习使用survival包。你可以通过运行?lung获取数据集信息：

```{r}
?lung
```

inst: Institution code
time: Survival time in days
status: censoring status 1=censored, 2=dead
age: Age in years
sex: Male=1 Female=2
ph.ecog: ECOG performance score (0=good 5=dead)
ph.karno: Karnofsky performance score as rated by physician
pat.karno: Karnofsky performance score as rated by patient
meal.cal: Calories consumed at meals
wt.loss: Weight loss in last six months


接着用Surv()函数创建生存数据对象（主要输入生存时间和状态逻辑值），再用survfit()函数对生存数据对象拟合生存函数，创建KM(Kaplan-Meier)生存曲线

```{r}
fit <- survfit(Surv(time, status) ~ sex, data = lung)
```

这里先构建了生存对象，然后使用survfit()函数拟合一条生存曲线。


如果想看整体的fit结果，可以summary(fit) or summary(fit)$table，但是想看每个时间点的更好的方式则是:


```{r}
res.sum <- surv_summary(fit)
head(res.sum)
```

具体每个列的含义如下：

* time: the time points on the curve.
* n.risk: the number of subjects at risk at time t
* n.event: the number of events that occurred at time t.
* n.censor: the number of censored subjects, who exit the risk set, without an event, at time t.
* surv: estimate of survival probability.
* std.err: standard error of survival.
* upper: upper end of confidence interval
* lower: lower end of confidence interval
* strata: indicates stratification of curve estimation. If strata is not NULL, there are multiple curves in the result. The levels of strata (a factor) are the labels for the curves.



根据上述fit结果，我们可以将KM生存数据进行可视化，主要使用Survminer包的ggsurvplot()函数，如下（这里我们在survfit()函数时用性别因子进行了分组，所以生存曲线有两组，即两条曲线；如果不想分组，将sex换成1即可）：



```{r}
ggsurvplot(fit,
       pval = TRUE, conf.int = TRUE,
       risk.table = TRUE, # Add risk table
       risk.table.col = "strata", # Change risk table color by groups
       linetype = "strata", # Change line type by groups
       surv.median.line = "hv", # Specify median survival
       ggtheme = theme_bw(), # Change ggplot2 theme
       palette = c("#E7B800", "#2E9FDF")
       )
```

![](/img/2023-08-08-22-01-58.png)

可以进行一些美化，添加曲线的置信区间，并增加long-rank检验的结果p值以及风险表格：


```{r}
ggsurvplot(fit, conf.int=TRUE, pval=TRUE, risk.table=TRUE, 
           legend.labs=c("Male", "Female"), legend.title="Sex",  
           palette=c("dodgerblue2", "orchid2"), 
           title="Kaplan-Meier Curve for Lung Cancer Survival",
           surv.median.line = "hv", # Specify median survival
           )
```

![](/img/2023-08-08-22-02-20.png)

Kaplan-Meier曲线用来对两个分类变量差异的可视化非常合适，但是不能分析多分类的问题：

```{r}
ggsurvplot(survfit(Surv(time, status)~nodes, data=survival::colon))
```

![](/img/2023-08-08-22-04-07.png)

而且生存曲线另外不能可视化的是连续型变量的风险，而Cox PH回归模型正好是处理这类问题的一把好手

```{r}
fit <- coxph(Surv(time, status)~sex, data=lung)
fit
```

```{r}
exp(0.531)
```


结果中的exp(coef)列包含。它就是风险比率——该变量对风险率的乘数效应（对于该变量每个单位增加的）。因此，对于像性别这样的分类变量，从男性（基线）到女性的结果大约减少约40％的危险。你也可以翻转coef列上的符号，并采用exp(0.531)，你可以将其解释为男性导致危险增加1.7倍，或者单位时间男性的死亡率约为女性1.7倍（女性死亡率为男性的0.588倍）。


可以通过调用summary(fit)来获得Cox模型结果。你也可以使用survdiff()直接计算log-rank测试p值。

```{r}
summary(fit)
```


```{r}
survdiff(Surv(time, status)~sex, data=lung)
```


创建另一个模型，分析数据集中的所有变量！这向我们展示了当所有变量一起考虑时，如何影响生存。一些是非常强大的预测指标（性别，ECOG评分）。有趣的是，医师对Karnofsky表现评分的评分稍高，但患者评分相同。

```{r}
fit <- coxph(Surv(time, status)~sex+age+ph.ecog+ph.karno+pat.karno+meal.cal+wt.loss, data=lung)
fit
```


让我们回到肺部数据并查看年龄的Cox模型。看起来年龄在模拟为连续变量时似乎有一点重要。


```{r}
coxph(Surv(time, status)~age, data=lung)
```

现在我们的的回归分析显示年龄有重要意义，让我们制作Kaplan-Meier图。但是，正如我们之前所看到的，我们不能这样做，因为我们会为每个独特的年龄值获得单独的曲线！


但是，如果我们选择一个不同的切点，例如70岁，这大概是年龄分布上限的四分之一（见“分位数”）。结果现在非常重要！


```{r}
lung <- lung %>% 
  mutate(agecat=cut(age, breaks=c(0, 70, Inf), labels=c("young", "old")))
```


```{r}
ggsurvplot(survfit(Surv(time, status)~agecat, data=lung), pval=TRUE)
```

![](/img/2023-08-08-22-03-05.png)











