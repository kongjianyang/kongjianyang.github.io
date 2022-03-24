---
title: R语言代码规范
author: Liang
date: '2018-11-24'
slug: R语言代码规范
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
编程的代码规范目的是使我们的R代码更容易阅读、分享和验证，下述是一些约定俗成的代码规范：
## 1.0 文件名
对于R file名字的命名，一般采用一些有意义的名字来命名，不要有特殊字符和空格，但是要注意大小写（特别是windowws系统是不管大小写的），所以最好就小写就行了；R代码就放在.R文件中，而R数据文件则放在.RData文件中。我一般不用下划线分割文件名，而是使用大小写交替的方式

>GOOD: predict_ad_revenue.R; PredictAdRevenue.R 
BAD: foo.R

## 2.0 标识符(Identifiers)
不要使用下划线(_)或连字符(-)标识符。标识符应按照以下命名约定。**变量名**的首选形式都是小写字母和单词分开用点(variable.name),但也接受variableName;**函数名**使用首字母大写而不用点(FunctionName);

>variable.name is preferred, variableName is accepted  
GOOD: avg.clicks  
OK: avgClicks  
BAD: avg_Clicks 


>FunctionName  
GOOD: CalculateAvgClicks  
BAD: calculate_avg_clicks , calculateAvgClicks  
Make function names verbs.  
Exception: When creating a classed object, the function name

## 3.0 间距(Spacing)

当使用所有二进制运算符(如=,+,-,<,等)在两端空格。例外:当符号 = 是函数调用时的传递参数周围不用空格隔开。 
不要在符号“，”前空格隔开，但需要在“，”后添加空格 
good style
```
tab.prior <- table(df[df$days.from.opt < 0, "campaign.id"]) 
total <- sum(x[, 1]) 
total <- sum(x[1, ])123
```
bad style 
```
tab.prior <- table(df[df$days.from.opt<0, "campaign.id"])  # Needs spaces around '<' 
tab.prior <- table(df[df$days.from.opt < 0,"campaign.id"])  # Needs a space after the comma
tab.prior<- table(df[df$days.from.opt < 0, "campaign.id"])  # Needs a space before <
tab.prior<-table(df[df$days.from.opt < 0, "campaign.id"])  # Needs spaces around <
total <- sum(x[,1])  # Needs a space after the comma 
total <- sum(x[ ,1])  # Needs a space after the comma, not before123456
```

## 4.0 花括号(Curly braces)
前括号永远不应该独占一行; 后括号应当总是独占一行. 在代码块只含单个语句时可省略花括号
```
if (is.null(ylim)) {
  ylim <- c(0, 0.06)
}
```
## 5.0 赋值
使用<-进行赋值, 不用=赋值. 
## 6.0 注释
整行注释应以#后接一个空格开始，行内短注释应在代码后接两个空格, #, 再接一个空格。
```
# Create histogram of frequency of campaigns by pct budget spent.
hist(df$pct.spent,
     breaks = "scott",  # method for choosing number of buckets
     main   = "Histogram: fraction budget spent by campaignid",
     xlab   = "Fraction of budget spent",
     ylab   = "Frequency (count of campaignids)")
```
## 7.0 函数的定义和调用
函数定义应首先列出无默认值的参数, 然后再列出有默认值的参数。函数定义和函数调用中, 允许每行写多个参数; 折行只允许在赋值语句外进行。

## 8.0 分号
不要以分号结束一行, 也不要利用分号在同一行放多于一个命令. (分号是毫无必要的, 并且为了与其他Google编码风格指南保持一致, 此处同样略去. )(**分号作为语句结束标识，虽然不规范，但是在缩短文档长度的时候我会选择使用...**)






