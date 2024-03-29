---
title: "R语言数据导入rio包"
date: 2022-03-30T14:32:27-05:00
author: KJY
slug: rio
draft: false
toc: true
categories:
  - bioinfo
tags:
  - article
---





rio: A Swiss-Army Knife for Data I/O

[CRAN - Package rio (r-project.org)](https://cran.r-project.org/web/packages/rio/index.html)

## 笔记说明

在读[《Modern R with the tidyverse》](https://links.jianshu.com/go?to=https%3A%2F%2Fb-rodrigues.github.io%2Fmodern_R%2Freading-and-writing-data.html)一书时发现了这个非常好用的R包，做此笔记记录。本笔记记录rio包的数据导入功能。导出功能说明见：[用rio包进行数据导出](https://www.jianshu.com/p/9bae75ae6893)

## 数据导入

![](https://upload-images.jianshu.io/upload_images/17983329-0b66383d4e75a6d4.png?imageMogr2/auto-orient/strip|imageView2/2/w/517/format/webp)

Hadley Wickham在《R for Data Science》中总结的探索性数据分析的分析流程

数据导入是数据分析的第一步。实际工作中数据的来源和原始数据文件的格式多种多样。对应不同的原始文件来源或格式就有很多不同的读取数据的R包。学习、使用起来非常麻烦。在rio包之前，为了满足数据导入需要，大概需要学习的R包和其对应的数据文件类型如下：

-   readr包 - text files（如csv, tsv, fwf文件）
-   haven包 - SPSS, Stata, and SAS files
-   readxl包 - excel files
-   DBI包 - databases
-   jsonlite包 - json
-   xml2包 - XML
-   httr包 - Web APIs
-   rvest包 - HTML (Web Scraping)

## rio包及其数据导入功能

rio包封装了很多数据导入和导出的包，并将不同包的数据导入导出操作统一到两个函数上：`import()`和`export()`，通过文件的后缀名来判断文件类型。这使得在R中进行数据的导入导出操作变得非常简单。有关rio包的更多信息可以参见：[https://cran.r-project.org/web/packages/rio/vignettes/rio.html](https://links.jianshu.com/go?to=https%3A%2F%2Fcran.r-project.org%2Fweb%2Fpackages%2Frio%2Fvignettes%2Frio.html)  
下面对rio包的一些数据导入功能进行展示（基本参照《Modern R with the tidyverse》中对应的内容，所使用的数据可以在[https://github.com/b-rodrigues/modern\_R/tree/master/datasets](https://links.jianshu.com/go?to=https%3A%2F%2Fgithub.com%2Fb-rodrigues%2Fmodern_R%2Ftree%2Fmaster%2Fdatasets)下载）：

-   加载rio包

```
## The following rio suggested packages are not installed: ‘csvy’, ‘feather’, ‘fst’, ‘hexView’, ‘readODS’, ‘rmatio’, ‘xml2’
## Use 'install_formats()' to install them
```

-   使用`import()`进行数据导入

```
#导入csv文件
mtcars <- import("data/mtcars.csv")
head(mtcars)
```

```
##   mpg cyl disp  hp drat    wt  qsec vs am gear carb
## 1 21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
## 2 21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
## 3 22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
## 4 21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
## 5 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
## 6 18.1   6  225 105 2.76 3.460 20.22  1  0    3    1
```

在Windows系统下，对于萌新来说需要注意的一点是不能直接把文件路径粘贴过来，windows系统使用“\\”标识路径，而R使用“/”表示路径。  
导入其他格式的数据也是一样：

```
#导入stata数据
mtcars_stata <- import("data/mtcars.dta")
#导入sas数据
mtcars_sas <- import("data/mtcars.sas7bdat")
```

-   用`import_list()`导入一个excel文件中的多个sheet

```
multi <- import_list("data/multi.xlsx")
str(multi)
```

```
## List of 2
##  $ mtcars:'data.frame':  32 obs. of  11 variables:
##   ..$ mpg : num [1:32] 21 21 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 ...
##   ..$ cyl : num [1:32] 6 6 4 6 8 6 8 4 4 6 ...
##   ..$ disp: num [1:32] 160 160 108 258 360 ...
##   ..$ hp  : num [1:32] 110 110 93 110 175 105 245 62 95 123 ...
##   ..$ drat: num [1:32] 3.9 3.9 3.85 3.08 3.15 2.76 3.21 3.69 3.92 3.92 ...
##   ..$ wt  : num [1:32] 2.62 2.88 2.32 3.21 3.44 ...
##   ..$ qsec: num [1:32] 16.5 17 18.6 19.4 17 ...
##   ..$ vs  : num [1:32] 0 0 1 1 0 1 0 1 1 1 ...
##   ..$ am  : num [1:32] 1 1 1 0 0 0 0 0 0 0 ...
##   ..$ gear: num [1:32] 4 4 4 3 3 3 3 4 4 4 ...
##   ..$ carb: num [1:32] 4 4 1 1 2 1 4 2 2 4 ...
##  $ iris  :'data.frame':  150 obs. of  5 variables:
##   ..$ Sepal.Length: num [1:150] 5.1 4.9 4.7 4.6 5 5.4 4.6 5 4.4 4.9 ...
##   ..$ Sepal.Width : num [1:150] 3.5 3 3.2 3.1 3.6 3.9 3.4 3.4 2.9 3.1 ...
##   ..$ Petal.Length: num [1:150] 1.4 1.4 1.3 1.5 1.4 1.7 1.4 1.5 1.4 1.5 ...
##   ..$ Petal.Width : num [1:150] 0.2 0.2 0.2 0.2 0.2 0.4 0.3 0.2 0.2 0.1 ...
##   ..$ Species     : chr [1:150] "setosa" "setosa" "setosa" "setosa" ...
```

从`str(multi)`的结果可以看出，导入后生成的multi对象是一个由两个dataframe组成的list。

-   一次性导入同一目录下的所有数据文件

首先生成一个包含所有数据文件的向量：

```
paths <- Sys.glob("data/unemployment/*.csv")
paths
```

```
## [1] "data/unemployment/unemp_2013.csv" "data/unemployment/unemp_2014.csv"
## [3] "data/unemployment/unemp_2015.csv" "data/unemployment/unemp_2016.csv"
```

`Sys.glob()`利用正则表达式找到所有数据文件，本例中找到所有data/unemployment/目录下以csv为后缀的文件。  
之后利用`import_list()`一次性导入所有数据文件：

```
all_data <- import_list(paths)  
str(all_data)
```

```
## List of 4
##  $ unemp_2013:'data.frame':  118 obs. of  8 variables:
##   ..$ Commune                   : chr [1:118] "Grand-Duche de Luxembourg" "Canton Capellen" "Dippach" "Garnich" ...
##   ..$ Total employed population : int [1:118] 223407 17802 1703 844 1431 4094 2146 971 1218 3002 ...
##   ..$ of which: Wage-earners    : int [1:118] 203535 15993 1535 750 1315 3800 1874 858 1029 2664 ...
##   ..$ of which: Non-wage-earners: int [1:118] 19872 1809 168 94 116 294 272 113 189 338 ...
##   ..$ Unemployed                : int [1:118] 19287 1071 114 25 74 261 98 45 66 207 ...
##   ..$ Active population         : int [1:118] 242694 18873 1817 869 1505 4355 2244 1016 1284 3209 ...
##   ..$ Unemployment rate (in %)  : num [1:118] 7.95 5.67 6.27 2.88 4.92 ...
##   ..$ Year                      : int [1:118] 2013 2013 2013 2013 2013 2013 2013 2013 2013 2013 ...
##  $ unemp_2014:'data.frame':  118 obs. of  8 variables:
##   ..$ Commune                   : chr [1:118] "Grand-Duche de Luxembourg" "Canton Capellen" "Dippach" "Garnich" ...
##   ..$ Total employed population : int [1:118] 228423 18166 1767 845 1505 4129 2172 1007 1268 3124 ...
##   ..$ of which: Wage-earners    : int [1:118] 208238 16366 1606 757 1390 3840 1897 887 1082 2782 ...
##   ..$ of which: Non-wage-earners: int [1:118] 20185 1800 161 88 115 289 275 120 186 342 ...
##   ..$ Unemployed                : int [1:118] 19362 1066 122 19 66 287 91 38 61 202 ...
##   ..$ Active population         : int [1:118] 247785 19232 1889 864 1571 4416 2263 1045 1329 3326 ...
##   ..$ Unemployment rate (in %)  : num [1:118] 7.81 5.54 6.46 2.2 4.2 ...
##   ..$ Year                      : int [1:118] 2014 2014 2014 2014 2014 2014 2014 2014 2014 2014 ...
##  $ unemp_2015:'data.frame':  118 obs. of  8 variables:
##   ..$ Commune                   : chr [1:118] "Grand-Duche de Luxembourg" "Canton Capellen" "Dippach" "Garnich" ...
##   ..$ Total employed population : int [1:118] 233130 18310 1780 870 1470 4130 2170 1050 1300 3140 ...
##   ..$ of which: Wage-earners    : int [1:118] 212530 16430 1620 780 1350 3820 1910 920 1100 2770 ...
##   ..$ of which: Non-wage-earners: int [1:118] 20600 1880 160 90 120 310 260 130 200 370 ...
##   ..$ Unemployed                : int [1:118] 18806 988 106 29 73 260 80 41 72 169 ...
##   ..$ Active population         : int [1:118] 251936 19298 1886 899 1543 4390 2250 1091 1372 3309 ...
##   ..$ Unemployment rate (in %)  : num [1:118] 7.46 5.12 5.62 3.23 4.73 ...
##   ..$ Year                      : int [1:118] 2015 2015 2015 2015 2015 2015 2015 2015 2015 2015 ...
##  $ unemp_2016:'data.frame':  118 obs. of  8 variables:
##   ..$ Commune                   : chr [1:118] "Grand-Duche de Luxembourg" "Canton Capellen" "Dippach" "Garnich" ...
##   ..$ Total employed population : int [1:118] 236100 18380 1790 870 1470 4160 2160 1030 1330 3150 ...
##   ..$ of which: Wage-earners    : int [1:118] 215430 16500 1640 780 1350 3840 1900 900 1130 2780 ...
##   ..$ of which: Non-wage-earners: int [1:118] 20670 1880 150 90 120 320 260 130 200 370 ...
##   ..$ Unemployed                : int [1:118] 18185 975 91 27 66 246 76 35 70 206 ...
##   ..$ Active population         : int [1:118] 254285 19355 1881 897 1536 4406 2236 1065 1400 3356 ...
##   ..$ Unemployment rate (in %)  : num [1:118] 7.15 5.04 4.84 3.01 4.3 ...
##   ..$ Year                      : int [1:118] 2016 2016 2016 2016 2016 2016 2016 2016 2016 2016 ...
```

特别地，如果处理的数据是像unemployment数据这种，每个数据集的变量结构一致，你可以在一次性导入同一目录下所有数据文件的基础上，利用`rbind = TRUE`选项将他们合并到一个数据集中：

```
bind_data <-  import_list(paths, rbind = TRUE)  
str(bind_data)
```

```
## 'data.frame':    472 obs. of  9 variables:
##  $ Commune                   : chr  "Grand-Duche de Luxembourg" "Canton Capellen" "Dippach" "Garnich" ...
##  $ Total employed population : int  223407 17802 1703 844 1431 4094 2146 971 1218 3002 ...
##  $ of which: Wage-earners    : int  203535 15993 1535 750 1315 3800 1874 858 1029 2664 ...
##  $ of which: Non-wage-earners: int  19872 1809 168 94 116 294 272 113 189 338 ...
##  $ Unemployed                : int  19287 1071 114 25 74 261 98 45 66 207 ...
##  $ Active population         : int  242694 18873 1817 869 1505 4355 2244 1016 1284 3209 ...
##  $ Unemployment rate (in %)  : num  7.95 5.67 6.27 2.88 4.92 ...
##  $ Year                      : int  2013 2013 2013 2013 2013 2013 2013 2013 2013 2013 ...
##  $ _file                     : chr  "data/unemployment/unemp_2013.csv" "data/unemployment/unemp_2013.csv" "data/unemployment/unemp_2013.csv" "data/unemployment/unemp_2013.csv" ...
 - attr(*, ".internal.selfref")=<externalptr> 
```

注意到新生成的数据集中多了一个变量：\_file 用来指示当前观测原本属于哪个数据文件。

-   使用更多参数进行非常规导入

如果数据导入遇到问题，可能需要查看rio包背后使用的是什么包的什么函数来进行数据导入，并根据情况在用`import()`读取数据时添加对应参数。  
接下来看一个不成功的导入例子：

```
testdata <- import("data/mtcars_problem.csv")  
head(testdata)
```

```
##   mpg&cyl&disp&hp&drat&wt&qsec&vs&am&gear&carb
## 1          21&6&160&110&3.9&2.62&16.46&0&1&4&4
## 2         21&6&160&110&3.9&2.875&17.02&0&1&4&4
## 3        22.8&4&108&93&3.85&2.32&18.61&1&1&4&1
## 4      21.4&6&258&110&3.08&3.215&19.44&1&0&3&1
## 5       18.7&8&360&175&3.15&3.44&17.02&0&0&3&2
## 6       18.1&6&225&105&2.76&3.46&20.22&1&0&3&1
```

可以看出导入并不成功，不成功的原因在于原始的csv中使用非常规的“&”符号作为分隔符。查看`import()`的帮助（在R中运行“？import”）可知，当数据是csv格式时，rio调用data.table包的`fread()`进行读取。我们进一步查看`data.table::fread()`的帮助，发现`fread()`中可以使用`sep=`选项来指定csv数据的分隔符。当我们把这个参数传给`import()`后，`import()`会在调用`data.table::fread()`时将其传给`data.table::fread()`：

```
testdata <- import("data/mtcars_problem.csv", sep = "&")  
head(testdata)
```

```
##    mpg cyl disp  hp drat    wt  qsec vs am gear carb
## 1   21   6  160 110  3.9  2.62 16.46  0  1    4    4
## 2   21   6  160 110  3.9 2.875 17.02  0  1    4    4
## 3 22.8   4  108  93 3.85  2.32 18.61  1  1    4    1
## 4 21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
## 5 18.7   8  360 175 3.15  3.44 17.02  0  0    3    2
## 6 18.1   6  225 105 2.76  3.46 20.22  1  0    3    1
```
