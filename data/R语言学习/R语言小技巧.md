# 2019-06-19 关于字符串都可以用stringr包处理

参考：

[http://www.bioinfo-scrounger.com/archives/796](http://www.bioinfo-scrounger.com/archives/796)

[http://blog.fens.me/r-stringr/](http://blog.fens.me/r-stringr/)

涉及到字符串操作都可以使用stringr来进行

# 1. 字符串拼接函数

str_c: 字符串拼接。 str_join: 字符串拼接，同str_c。 str_trim: 去掉字符串的空格和TAB(\t) str_pad: 补充字符串的长度 str_dup: 复制字符串 str_wrap: 控制字符串输出格式 str_sub: 截取字符串 str_sub: 截取字符串，并赋值，同str_sub

# 2. 字符串计算函数

str_count: 字符串计数 str_length: 字符串长度 str_sort: 字符串值排序 str_order: 字符串索引排序，规则同str_sort

# 3. 字符串匹配函数

str_split: 字符串分割 str_split_fixed: 字符串分割，同str_split str_subset: 返回匹配的字符串 word: 从文本中提取单词 str_detect: 检查匹配字符串的字符 str_match: 从字符串中提取匹配组。 str_match_all: 从字符串中提取匹配组，同str_match str_replace: 字符串替换 str_replace_all: 字符串替换，同str_replace str_replace_na:把NA替换为NA字符串 str_locate: 找到匹配的字符串的位置。 str_locate_all: 找到匹配的字符串的位置,同str_locate str_extract: 从字符串中提取匹配字符 str_extract_all: 从字符串中提取匹配字符，同str_extract

# 4. 字符串变换函数

str_conv: 字符编码转换 str_to_upper: 字符串转成大写 str_to_lower: 字符串转成小写,规则同str_to_upper str_to_title: 字符串转成首字母大写,规则同str_to_upper

# 5. 参数控制函数，仅用于构造功能的参数，不能独立使用。

boundary: 定义使用边界 coll: 定义字符串标准排序规则。 fixed: 定义用于匹配的字符，包括正则表达式中的转义符 regex: 定义正则表达式

# 6. 其中几个特殊的

str_wrap，控制字符串输出格式

 str_wrap(string, width = 80, indent = 0, exdent = 0)  
 ​  
 txt<-'R语言作为统计学一门语言，一直在小众领域闪耀着光芒。直到大数据的爆发，R语言变成了一门炙手可热的数据分析的利器。随着越来越多的工程背景的人的加入，R语言的社区在迅速扩大成长。现在已不仅仅是统计领域，教育，银行，电商，互联网….都在使用R语言。'  
 ​  
 # 设置宽度为40个字符  
 > cat(str_wrap(txt, width = 40), "\n")  
 R语言作为统计学一门语言，一直在小众领域  
 闪耀着光芒。直到大数据的爆发，R语言变成  
 了一门炙手可热的数据分析的利器。随着越来  
 越多的工程背景的人的加入，R语言的社区在  
 迅速扩大成长。现在已不仅仅是统计领域，教  
 育，银行，电商，互联网….都在使用R语言。   
 ​  
 # 设置宽度为60字符，首行缩进2字符  
 > cat(str_wrap(txt, width = 60, indent = 2), "\n")  
   R语言作为统计学一门语言，一直在小众领域闪耀着光芒。直到大数  
 据的爆发，R语言变成了一门炙手可热的数据分析的利器。随着越来  
 越多的工程背景的人的加入，R语言的社区在迅速扩大成长。现在已  
 不仅仅是统计领域，教育，银行，电商，互联网….都在使用R语言。 

str_split,字符串分割，同str_split_fixed

 str_split(string, pattern, n = Inf)  
 str_split_fixed(string, pattern, n)  
 ​  
 > val <- "abc,123,234,iuuu"  
 ​  
 # 以,进行分割  
 > s1<-str_split(val, ",");s1  
 [[1]]  
 [1] "abc"  "123"  "234"  "iuuu"

str_subset:返回的匹配字符串

 > val <- c("abc", 123, "cba")  
 ​  
 # 全文匹配  
 > str_subset(val, "a")  
 [1] "abc" "cba"  
 ​  
 # 开头匹配  
 > str_subset(val, "^a")  
 [1] "abc"  
 ​  
 # 结尾匹配  
 > str_subset(val, "a$")  
 [1] "cba"

word, 从文本中提取单词

 word(string, start = 1L, end = start, sep = fixed(" "))  
 ​  
 > val <- c("I am Conan.", "http://fens.me, ok")  
 ​  
 # 默认以空格分割，取第一个位置的字符串  
 > word(val, 1)  
 [1] "I"               "http://fens.me,"  
 > word(val, -1)  
 [1] "Conan." "ok"      
 > word(val, 2, -1)  
 [1] "am Conan." "ok"         
 ​  
 # 以,分割，取第一个位置的字符串   
 > val<-'111,222,333,444'  
 > word(val, 1, sep = fixed(','))  
 [1] "111"  
 > word(val, 3, sep = fixed(','))  
 [1] "333"

# 2019-06-20 R与Excel交互

R读取excel可以使用readxl包 R存储excel可以使用writexl包

## readxl包

library(readxl)  
path="F:\\2017年XXX.xlsx"  
dataset<-read_excel(path, range = "E4:H13")  
dataset    #默认首行为标题  
dataset1<-read_excel(path, range = "E4:H13",col_names = FALSE)  
dataset1   #首行不作为为标题，标题自动生成  
dataset2<-read_excel(path,skip=3)  
dataset2  #跳过前三行，默认第四行为标题（col_names默认为TRUE）

## readxl包

library(readxl)  
path="F:\\2017年XXX.xlsx"  
dataset<-read_excel(path, range = "E4:H13")  
dataset    #默认首行为标题  
dataset1<-read_excel(path, range = "E4:H13",col_names = FALSE)  
dataset1   #首行不作为为标题，标题自动生成  
dataset2<-read_excel(path,skip=3)  
dataset2  #跳过前三行，默认第四行为标题（col_names默认为TRUE）

## writexl包

library(writexl)  
  
mtcars$中文 <- sample(c("速度快","无依赖","体积小"),  
                    32,replace=T)  
  
# 单个sheet  
write_xlsx(mtcars,"F:/mtcars.xlsx")  
  
# 多个sheet  
write_xlsx(list(表1=mtcars[1:15,],  
                表2=mtcars[16:32,]),  
           "F:/mtcars.xlsx")

# 2019-06-22 R中的reshape2包和dplyr包

## 1. reshape包

主要是melt和dcast两个函数

melt(data, id.vars, measure.vars,  
  variable.name = "variable", ..., na.rm = FALSE, value.name = "value",  
  factorsAsStrings = TRUE)

标为id的变量都没有改变，而其他变量都变成一个新生变量的值，另外一列变量记录对应的数值结果。

dcast

rowvar1 + rowvar2 + ... ~ colvar1 + colvar2 + ...

~左边定义了要划掉的变量集合，以确定各行的内容，而右边定义要划掉、确定各列内容的变量集合。

## 2. dplyr包

dplyr是由Hadley Wickham主持开发和维护的一个主要针对数据框快速计算、整合的函数包，同时提供一些常用函数的高速写法以及几个开源数据库的连接。此包是plyr包的深化功能包，其名字中的字母“d”即来源于data frame，以示其专注于数据框数据的整理和操作。

# 2019-06-30 R中的with函数, transform函数功能

with和within 函数可以实现这个功能：把数据框或列表作为环境，自由的调用其中的对象，这样可以方便我们自由的使用数据框或列表中的内容

假设需要创建一个名称为mydata 的数据框，其中的变量为向量x1和向量x2，现在创建一个新变量sumx存储向量x1和向量x2两个变量的和，并创建另外一个新变量meanx存储向量x1和向量x2两个变量的平均值。

首先，回顾一下数据框的概念。

数据框是R语言里中的一种数据结构，其内部可以由多种数据类型，每一列是一个变量，每行是一个观测记录。数据框是R语言中通用的数据结构，是一种特殊的列表对象。 然后，创建数据框mydata。

# 创建数据框mydata，x1和x2是mydata的两个列向量

mydata <- data.frame(x1 = c(2, 2, 6, 4), x2 = c(3, 4, 2, 8))

根据上面提到的作用和用法，利用transform函数为数据框mydata增加数据。

# 利用transform函数对数据框mydata增加两个变量（列向量）sumx和meanx，并把结果存储在数据框mydata中

mydata <- transform(mydata, sumx = x1 + x2, meanx = (x1 + x2)/2)

#利用within函数，expr表达式执行一条语句占一行，执行多条语句需要换行 mydata <- within(mydata, {sumx = x1 + x2 meanx = (x1 + x2)/2})

#或者多条语句在同一行，则中间应当用分号;隔开 mydata <- within(mydata, {sumx = x1 + x2; meanx = (x1 + x2)/2})

# 2019-07-07 解决running command ‘"pdflatex"问题

解决问题的方案

brew install -v yihui/tinytex/tinytex

TinyTeX 是一个瘦身版的 TeX Live。TeX Live 的庞大体型问题困扰我多年，在 2018 年之前我终于抽出一周时间来解决这个问题，其实方案很简单：把对普通用户毫无用处的源代码和文档去掉即可。

LaTeX是排版引擎，CTeX和TeX Live是发行版。也可以这么理解，LaTeX是毛坯房，CTeX和TeX Live是带精装的房子。

LaTeX中来，它只是构建在TeX之上的一系列宏的定义的集合，可以认为它提供了操作系统。我们在使用LaTeX撰写文档的时候，我们还需要ctexbook文档类，geometry的宏包，当然啦，我们还需要一个好用的编辑器。这些东西并不是由LaTeX直接提供给你的，而是由别人开发好以后，放在网上给我们下载，我们才能够使用这些功能。那么我们在撰写文档的时候需不需要把这些工具都手动下载下来呢，显然不需要。谁替我们下载了这些宏包，谁让我们的生活变得这么自在呢？是的，就是TeXLive，它其实就是一个大的捆绑包，把基本的操作系统和一些必要的工具捆在一起，让用户可以开箱即食。

# 2019-07-13 R中的管道操作 magritttr

[http://blog.fens.me/r-magrittr/](http://blog.fens.me/r-magrittr/)

向右操作符%>%, 向左操作符%T>%, 解释操作符%$% 和 复合赋值操作符%<>%。

%% 的作用是把左侧数据的属性名传给右侧，让右侧的调用函数直接通过名字，就可以获取左侧的数据。比如，我们获得一个data.frame类型的数据集，通过使用 %%，在右侧的函数中可以直接使用列名操作数据。

data.frame(x=1:10,y=rnorm(10),z=letters[1:10]) %$% .[which(x>5),]

# 2019-07-21 练习

## R 标准地图记

[http://tiramisutes.github.io/2019/06/19/Rmap.html](http://tiramisutes.github.io/2019/06/19/Rmap.html)

## R语言中的矩阵计算

[http://blog.fens.me/r-matrix/](http://blog.fens.me/r-matrix/)

## 在jupyter里面调用R详细

%load_ext rpy2.ipython  
%%R #单元格全体  
%R #单行命令

IPython提供了很多魔法命令，使得在IPython环境中的操作更加得心应手。魔法命令都以%或%%开头，以%开头的为行命令，以%%开头的为单元命令。行命令只对命令所在的行有效，而单元命令则必须出现在单元的第一行，对整个单元的代码进行处理[3]。

查询这个%%R怎么用的可以使用

%%R?

## 利用R做富集分析及表达数据可视化

[https://mp.weixin.qq.com/s/Jvf_VFWAEOJUKznOESHmYg](https://mp.weixin.qq.com/s/Jvf_VFWAEOJUKznOESHmYg)

## 利用R将PDF文件合并和拆分

[https://www.r-bloggers.com/join-split-and-compress-pdf-files-with-pdftools/](https://www.r-bloggers.com/join-split-and-compress-pdf-files-with-pdftools/)

# Load pdftools  
library(pdftools)  
  
# extract some pages  
pdf_subset('https://cran.r-project.org/doc/manuals/r-release/R-intro.pdf',  
  pages = 1:3, output = "subset.pdf")  
  
# Should say 3  
pdf_length("subset.pdf")  
Similarly pdf_combine() is used to join several pdf files into one.  
  
# Generate another pdf  
pdf("test.pdf")  
plot(mtcars)  
dev.off()  
  
# Combine them with the other one  
pdf_combine(c("test.pdf", "subset.pdf"), output = "joined.pdf")  
  
# Should say 4  
pdf_length("joined.pdf")

# 2019-07-22 练习

## 资料输出

sink("sink-example.txt")  
i <- 1:3  
outer(i, i, "*")  
sink()

更多例子

# Start writing to an output file  
sink('analysis-output.txt')  
  
set.seed(12345)  
x <-rnorm(10,10,1)  
y <-rnorm(10,11,1)  
# Do some stuff here  
cat(sprintf("x has %d elements:\n", length(x)))  
print(x)  
cat("y =", y, "\n")  
  
cat("=============================\n")  
cat("T-test between x and y\n")  
cat("=============================\n")  
t.test(x,y)  
  
# Stop writing to the file  
sink()  
  
  
# Append to the file  
sink('analysis-output.txt', append=TRUE)  
cat("Some more stuff here...\n")  
sink()

如果想输出的内容是data frame需要先将data frame转化为matrix

## R读取特殊后缀文件

# 设置工作路径 setwd('D:/Sync/Dlm_wk/BB_merge_data/11Nov')  
  
filenames <- list.files("./venn", pattern = "*.csv", full.names = TRUE)  
filenames

## R调用系统命令

R 中调用的方法为system

system("pwd")

# 2019-07-23 练习

## 基于ggpubr包为ggplot添加p值和显著性标记

[https://www.jianshu.com/p/16b67c9111c0#%E7%BB%98%E5%9B%BE](https://www.jianshu.com/p/16b67c9111c0#%E7%BB%98%E5%9B%BE) [https://www.shixiangwang.top/post/ggpubr-add-pvalue-and-siglevels/](https://www.shixiangwang.top/post/ggpubr-add-pvalue-and-siglevels/)

# 2019-07-28

## T检验

[http://blog.fens.me/r-test-t/](http://blog.fens.me/r-test-t/)

T检验，是用于检验两个小样本的**平均值差异程度的检验方法**，**样本量在3-30个左右**，要求**样本为正态分布**，但**总体标准差可未知**。T检验，是用T分布理论来推断差异发生的概率，从而**判定两个样本平均值的差异是否显著**。T检验可分为单总体T检验，双总体非配对T检验，和双总体配对T检验。下面将分别进行介绍。

需要先对选定数据集进行进行正态分布检验。使用Shapiro-Wilk和qq图，作为正态分布检验的方法。

Shapiro-Wilk正态分布检验: 用来检验是否数据符合正态分布，类似于线性回归的方法一样，是检验其于回归曲线的残差。该方法推荐在样本量很小的时候使用，样本在3到5000之间。该检验原假设为H0:数据集符合正态分布，统计量为W。统计量W最大值是1，越接近1，表示样本与正态分布匹配。p值，当p-value小于显著性水平α(0.05)，则拒绝H0。

单总体T检验，是检验一个样本平均值与一个已知的总体平均值的差异是否显著。

双总体T检验，是检验两个样本平均值，与其各自所代表的总体的差异是否显著。双总体T检验又分为两种情况，一种是配对的样本T检验，用于检验两种同质对象，在不同条件下所产生的数据差异性；另一种是独立样本非配对T检验，用于检验两组独立的样本的平均数差异性。

配对T检验

目标：检验两组同质样本，在不同的处理下的样本平均值，是否有显著的差异性。

配对设计：**将2组样本的某些重要特征按相近的原则配成对子，消除混杂因素的影响**，观察样本之间的处理因素和研究因素的差异，其它因素基本相同，把配对两组样本个体随机处理。

非配对T检验

目标：用于检验两组独立的样本的平均数差异性。

## 多图拼接使用cowplot包

[https://www.jianshu.com/p/4429f1381835?utm_source=desktop&utm_medium=timeline](https://www.jianshu.com/p/4429f1381835?utm_source=desktop&utm_medium=timeline)

# 2019-07-30

## R 变量名称和字符串的转换

使用assign 和 get函数

get()：返回与字符串同名的变量的值 assign():为字符串变量的字符串赋值

The get function **searches and calls a data object**.

The assign R function assigns values to a variable name.

[get R Function (5 Example Codes) | Call Vector or Column of Data Frame (statisticsglobe.com)](https://statisticsglobe.com/get-r-function-example)

[assign Function in R (2 Examples) | How to Store Values in Variable Name (statisticsglobe.com)](https://statisticsglobe.com/assign-function-in-r)

# 2019-08-03

## R中的F检验

[http://blog.fens.me/r-test-f/](http://blog.fens.me/r-test-f/)

F检验法(F-test)，初期叫方差比率检验(Variance Ratio)，又叫联合假设检验(Joint Hypotheses Test)，是英国统计学家Fisher提出的，**主要通过比较两组数据的方差，以确定他们的密度是否有显著性差异。**

两组数据之间是否存在系统误差，则在进行F检验并确定它们的密度没有显著性差异之后，再进行T检验。

对于多元线性回归模型，t检验是对于单个变量进行显著性，检验该变量独自对被解释变量的影响。f检验是检验回归模型的显著意义，即所有解释变量联合起来对被解释变量的影响

使用Shapiro-Will作为正态分布检验的方法，全称 Shapiro-Wilk Normality Test.

利用Shapiro检验的结论：两个样本的W统计量都接近1，且p-value都大于0.05，不能拒绝原假设，两组样本数据为正态分布。

F检验使用的函数是 var.test()

F检验 以0.05为显著性水平，p-value=0.006232小于0.05，拒绝原假设，两样本方差有显著性差异。这个结果与我们构造的数据是一致的，样本的方差就是不同的。

## R中的attach、detach和with函数

在R语言中，对于串列，数据框中的数据的进行操作时，为了避免重复地键入对象名称，可使用attach或with。

假设data.frame包含列name，age

attach(onedata.frame)后就可以引用直接引用onedata.frame中的元素了

例子

> attach(ToothGrowth)  
> len  
 [1]  4.2 11.5  7.3  5.8  6.4 10.0 11.2 11.2  5.2  7.0 16.5 16.5 15.2 17.3  
[15] 22.5 17.3 13.6 14.5 18.8 15.5 23.6 18.5 33.9 25.5 26.4 32.5 26.7 21.5  
[29] 23.3 29.5 15.2 21.5 17.6  9.7 14.5 10.0  8.2  9.4 16.5  9.7 19.7 23.3  
[43] 23.6 26.4 20.0 25.2 25.8 21.2 14.5 27.3 25.5 26.4 22.4 24.5 24.8 30.9  
[57] 26.4 27.3 29.4 23.0  
> dose  
 [1] 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0  
[19] 1.0 1.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 0.5 0.5 0.5 0.5 0.5 0.5  
[37] 0.5 0.5 0.5 0.5 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 2.0 2.0 2.0 2.0  
[55] 2.0 2.0 2.0 2.0 2.0 2.0

使用detach之后，则之前的变量消失

> detach(ToothGrowth)  
> len  
Error: object 'len' not found

with也可以做到

> with(ToothGrowth, {  
+   dose1 <<- dose  
+ })  
> dose1  
 [1] 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0  
[19] 1.0 1.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 0.5 0.5 0.5 0.5 0.5 0.5  
[37] 0.5 0.5 0.5 0.5 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 2.0 2.0 2.0 2.0  
[55] 2.0 2.0 2.0 2.0 2.0 2.0

但是这个时候需要使用的 <<- 上层变量赋值

如果不是需要在全局变量中构造 dose1而是只需要用

> with(ToothGrowth, dose)  
 [1] 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0  
[19] 1.0 1.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 0.5 0.5 0.5 0.5 0.5 0.5  
[37] 0.5 0.5 0.5 0.5 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 2.0 2.0 2.0 2.0  
[55] 2.0 2.0 2.0 2.0 2.0 2.0

> with(ToothGrowth, {  
+   dose  
+ })  
 [1] 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0  
[19] 1.0 1.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 0.5 0.5 0.5 0.5 0.5 0.5  
[37] 0.5 0.5 0.5 0.5 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 2.0 2.0 2.0 2.0  
[55] 2.0 2.0 2.0 2.0 2.0 2.0

## R 语言赋值运算符：`<-` , `=`, `<<-`

<- 与 = 在大部分情况下是应该可以通用的。并且，相对于 <<- 运算符，它们的赋值行为均在它们自身的环境层（environment hierarchy）中进行。

<<-用于在函数中给上层变量赋值。

其中快捷输入 <- 可以使用快捷键

option + -

# 2019-08-04

## 检查离群值

# Outlier removal by the Tukey rules on quartiles +/- 1.5 IQR  
# 2017 Klodian Dhana  
  
  
outlierKD <- function(dt, var) {  
  var_name <- eval(substitute(var),eval(dt))  
  tot <- sum(!is.na(var_name))  
  na1 <- sum(is.na(var_name))  
  m1 <- mean(var_name, na.rm = T)  
  par(mfrow=c(2, 2), oma=c(0,0,3,0))  
  boxplot(var_name, main="With outliers")  
  hist(var_name, main="With outliers", xlab=NA, ylab=NA)  
  outlier <- boxplot.stats(var_name)$out  
  mo <- mean(outlier)  
  var_name <- ifelse(var_name %in% outlier, NA, var_name)  
  boxplot(var_name, main="Without outliers")  
  hist(var_name, main="Without outliers", xlab=NA, ylab=NA)  
  title("Outlier Check", outer=TRUE)  
  na2 <- sum(is.na(var_name))  
  message("Outliers identified: ", na2 - na1, " from ", tot, " observations")  
  message("Proportion (%) of outliers: ", (na2 - na1) / tot*100)  
  message("Mean of the outliers: ", mo)  
  m2 <- mean(var_name, na.rm = T)  
  message("Mean without removing outliers: ", m1)  
  message("Mean if we remove outliers: ", m2)  
  response <- readline(prompt="Do you want to remove outliers and to replace with NA? [yes/no]: ")  
  if(response == "y" | response == "yes"){  
    dt[as.character(substitute(var))] <- invisible(var_name)  
    assign(as.character(as.list(match.call())$dt), dt, envir = .GlobalEnv)  
    message("Outliers successfully removed", "\n")  
    return(invisible(dt))  
  } else{  
    message("Nothing changed", "\n")  
    return(invisible(var_name))  
  }  
}

## eval将字符串转变为命令执行

eval()可以把字符串转化成表达式来执行。 eval和parse结合使用，参数 text 等于要转化的字符串。

s<- "print('hello world')"  
eval(parse(text = s))

# 2019-08-07

## 一图统计学

[http://blog.sciencenet.cn/blog-651374-985834.html](http://blog.sciencenet.cn/blog-651374-985834.html)

## R定时任务

taskscheduleR

library(taskscheduleR)  
test_task_path <- file.path(getwd(),"test1.R")  
taskscheduler_create(taskname = "test_task", rscript = test_task_path,   
                 schedule = "MINUTE", starttime = "12:51", startdate = format(Sys.Date(), "%Y/%m/%d")  
                 ,schtasks_extra = '/RU CORP\\lijiaxiang /RP  ******'  
                 )

## 学习purrr 函数式编程

[https://zhuanlan.zhihu.com/p/32293221](https://zhuanlan.zhihu.com/p/32293221)

[https://zhuanlan.zhihu.com/p/32294057](https://zhuanlan.zhihu.com/p/32294057)

[https://jiaxiangli.netlify.com/2018/02/27/purrr/](https://jiaxiangli.netlify.com/2018/02/27/purrr/)

[http://bourneli.github.io/r/2018/05/07/function-programming-in-R.html](http://bourneli.github.io/r/2018/05/07/function-programming-in-R.html)

# 2019-08-18

## remedy是可以addin，在Rstudio中可以很好的优化markdown的体验

可以是用 droplevels()功能移除factor中已经不存在的level了

R function中想要输出多图的话需要利用list函数，例如

list(plot(x), plot(y))

# 快速改变label的大小

Complete themes

可以这样进行修改

theme_grey(base_size = 11, base_family = "",  
  base_line_size = base_size/22, base_rect_size = base_size/22)

# 查看R包的安装位置

> .libPaths() [1] "C:/Users/jmzeng/Documents/R/win-library/3.1" [2] "C:/Program Files/R/R-3.1.0/library"

可以用available.packages()可以查看自己的机器可以安装哪些包！

# tidyr包教学

gather—宽数据转为长数据。类似于reshape2包中的melt函数 spread—长数据转为宽数据。类似于reshape2包中的cast函数 unit—多列合并为一列 separate—将一列分离为多列

使用gather()函数实现宽表转长表，语法如下： gather(data, key, value, …, na.rm = FALSE, convert = FALSE) data：需要被转换的宽形表 key：将原数据框中的所有列赋给一个新变量key value：将原数据框中的所有值赋给一个新变量value …：可以指定哪些列聚到同一列中

spread(data, key, value, fill = NA, convert = FALSE, drop = TRUE) data：为需要转换的长形表 key：需要将变量值拓展为字段的变量 value：需要分散的值 fill：对于缺失值，可将fill的值赋值给被转型后的缺失值

unite(data, col, …, sep = “_”, remove = TRUE) data：为数据框 col：被组合的新列名称 …：指定哪些列需要被组合 sep：组合列之间的连接符，默认为下划线 remove：是否删除被组合的列

separate(data, col, into, sep = “[:alnum:]+”, remove = TRUE, convert = FALSE, extra = “warn”, fill = “warn”, …) data：为数据框 col：需要被拆分的列 into：新建的列名，为字符串向量 sep：被拆分列的分隔符 remove：是否删除被分割的列

# writexl同时存多个sheets

library(writexl)  
sheets <- list("sheet1Name" = sheet1, "sheet2Name" = sheet2) #assume sheet1 and sheet2 are data frames  
write_xlsx(sheets, "path/to/location")

# 简化R里面的复杂命令

View()函数的转化

v <- function(x) View(x)

# 将循环产生的数据框进行合并

df_total = data.frame()  
for (i in 1:7){  
    # vector output  
    model <- #some processing  
  
    # add vector to a dataframe  
    df <- data.frame(model)  
    df_total <- rbind(df_total,df)  
}

# ggplot2绘图添加文本注释上下标问题

library(ggplot2)  
df<-data.frame(A=1:5,B=6:10,D=letters[1:5])  
ggplot(df,aes(x=A,y=B,color=D))+  
  geom_point(size=5)+  
  annotate("text",x=3,y=7.5,label="atop(R^2==0.9,Y==X^2+5)",parse=T)+  
  theme_bw()+  
  theme(legend.position="none")

ggplot(df,aes(x=A,y=B,color=D))+  
  geom_point(size=5)+  
  annotate("text",x=3,y=8.5,label="X[1]==X[2]",parse=T,color="blue")+  
  xlab(expression(X^2))+ylab(expression(Y[1]))+  
  theme_bw()+  
  theme(legend.position="none")

# R markdown制作自动分析报告

首先讲下R markdown的布局。首先包含了一个头文件。该头文件包括四项内容：题目，作者，日期，输出格式。这里我强烈建议把data项改掉

data: ""`r Sys.Date()`""

这样就可以直接调取系统日期，最后生成了文件日期就可以实时更新了。这里涉及到了Rmarkdown的一个知识点，就是可以实使用 `r 变量名` 直接调取R中的变量。

Concatenating all rows within a group using dplyr

library(tidyr)  
library(dplyr)  
  
data <- read_csv('data.csv')  
byHand <- group_by(data, hand_id) %>%  
    summarise(combo_1 = paste(card_id, collapse = "-"),   
              combo_2 = paste(card_name, collapse = "-"),  
              combo_3 = paste(card_class, collapse = "-"))

批量重命名

顾名思义，就是同一个变量名在代码的很多位置重复出现，如果写着写着发现需要换个更合适的名字，就不用一个一个去编辑了(也不用Ctrl+F然后再按好多次回车键)，而只需要选中需要修改的变量，然后在菜单栏中依次点击Code -> Rename in Scope(默认快捷键是Ctrl+Alt+Shift+M)，就可以批量地进行重命名了。这个工具考虑了上下文，因此把变量a1修改为baoge并不会把变量a11误杀为baoge1。

# 改变R存储的的pdf图片距离边缘的距离

pdf(file = "test1.pdf", paper = "a4r")  
ggplot(mpg, aes(displ, hwy)) + geom_point()  
dev.off()  
  
pdf(file = "test2.pdf", paper = "a4r")  
ggplot(mpg, aes(displ, hwy)) + geom_point() +  
  theme(plot.margin = margin(2, 2, 2, 2, "cm"))  
dev.off()

# 为什么base_size在theme_bw中不起作用

This is a basic misunderstanding of how R works. If you want to use a variable base_size in a function call, you need to define it first.

library(ggplot2)  
test10 <- theme_bw(base_line_size = base_size/11)  
#> Error in structure(list(colour = colour, size = size, linetype = linetype, : object 'base_size' not found  
  
base_size <- 11  
test10 <- theme_bw(base_size = base_size, base_line_size = base_size/11)

module load gcc  
module load r  
module load rstudio  
rstudio

ssh -Y halstead-a319

Interactive Jobs

qsub -I -q standby -l nodes=1:ppn=20 -l walltime=04:00:00 -X

# 超几何分布

Figure from [http://www.programmersought.com/article/3695514833/](http://www.programmersought.com/article/3695514833/)

给定一个超几何分布，算出比某个事件更极端的概率，可以称为超几何分布检验。 比如在两个圈的venn图中，想要计算overlap是否显著：

应该减1

P(Observed 62 or more) = 1-P(Observed less than 62).

# 2019-12-06

medo 9月29日已编辑 假设: 有两个函数：

f1 = function (x) x+1 # index : "x" f2 = function (x) x-1 # index: "y" 一个向量：

xy = c( "x","y","y","x","x") 想要的结果： 类似c( f1,f2,f2,f1,f1)函数序列格式。

能想到的方式是用lapply + 设计一个内部包含if的函数，然后逐一判断。不知有没有其他更优美、更快的实现方式？

tctcab 回复了此帖 medo 9月29日已编辑 R的if else、switch 对应一向量的判断语句，如果对应数学计算，一种方式是借鉴sign、delta函数（[http://souptonuts.sourceforge.net/readme_sqlite_tutorial.html](http://souptonuts.sourceforge.net/readme_sqlite_tutorial.html)）将判断语句变成加减乘法的向量化处理，但对函数的选择就不能用这种方法。

tctcab9月29日 medo 没明白，现在你有f1，f2两个函数，要根据index是x或者y执行f1或者f2吗？

我能想到的就是合并f1 f2并把index也作为函数的一个参数…

medo 9月29日已编辑 tctcab 根据x 、 y 索引形成的函数序列不执行。生成函数序列后，后续准备放在uniroot函数中去求解。

medo 9月29日已编辑 一个处理方式：

f1 = function (x) x+1 # index : "x" f2 = function (x) x-1 # index: "y" xy = c( "x","y","y","x","x") c(f1,f2)[match(xy,c("x","y"))] yihui 回复了此帖 Cloud20169月29日 我歪个楼，代码块要放在一对三个反引号里 ```

yihui9月29日 medo 这不就是个普通的索引问题么：

c(x = f1, y = f2)[xy] medo 点了赞 2 个月 后 medo 4 天前 yihui 研读基础多少遍都不算多。

# R 去掉字符串前后指定位置

str <- c('Solyc00g005000.3.1', 'Solyc00g005040.3.1', 'Solyc00g005050.3.1')  
sub("..$","", str) # 去掉末尾两位  
sub("^....", "", str) # 去掉开头四位  
  
[1] "Solyc00g005000.3" "Solyc00g005040.3" "Solyc00g005050.3"  
[1] "c00g005000.3.1" "c00g005040.3.1" "c00g005050.3.1"

# R 输出文本到txt文件

## R语言的输出函数cat,sink，writeLines

1.cat函数即能输出到屏幕，也能输出到文件.

使用方式：cat(... , file = "", sep = " ", fill = FALSE, labels = NULL,append = FALSE)

有file时，输出到file。无file时，输出到屏幕。

append参数：布尔值。TRUE时，输出内容追加到文件尾部。FALSE，覆盖文件原始内容。

cat("hello")  
hello  
cat("hello",file="D:/test.txt",append=T)

2.sink函数将输出结果重定向到文件。

使用方式：sink(file = NULL, append = FALSE, type = c("output", "message"),split = FALSE)

append参数：布尔值。TRUE时，输出内容追加到文件尾部。FALSE，覆盖文件原始内容。

sink("hello.txt") # 将输出重定向到hello.txt  
cat("hello")  
sink() # 结束重定向

3.writeLines函数将字符串向量输出到文件中（会覆盖原始内容）

使用方式：writeLines(text, con = stdout(), sep = "\n", useBytes = FALSE)

text:字符串向量；con：输出文件

a=c("one","tew")  
writeLines(a,con="./test.txt")

## R两个列表合并为一个列表

l1 = list(2, 3)  
l2 = list(4, 5, 6)  
append(l1, l2) %>% unlist() # 最优解

## R 分割字符串

使用strsplit函数

strsplit("a_b_c", "_")  
  
[[1]]  
[1] "a" "b" "c"

注意如果使用以点为分割符号，需要用特殊方法

unlist(strsplit("a.b.c", "[.]"))  
  
# or  
  
unlist(strsplit("a.b.c", ".", fixed = TRUE))

## R 一行一行的读取文件

con = file(filepath, "r")  
  while ( TRUE ) {  
    line = readLines(con, n = 1)  
    if ( length(line) == 0 ) {  
      break  
    }  
    print(line)  
  }  
  
  close(con)

这个能运行的原因是

readLines documentation: "If the connection is open it is read from its current position." It's what makes the loop work.

最后记得要close.

## 得到嵌套列表中的第一个元素

x = list(list(1,2), list(3,4), list(5,6))  
library(purrr)  
map(x, 1)

# 2019-07-15 R中的取整

常规除法：/  
> 82/10  
[1] 8.2  
整除：    %/%  
  
> 82%/%10  
[1] 8  
求余：    %%  
  
> 82%%10  
[1] 2  
向下取整  floor()  
  
> floor(8.9)  
[1] 8  
向上取整 ceiling()  
  
> ceiling(8.1)  
[1] 9  
四舍五入取整 round()  
  
> round(8.4)  
[1] 8  
> round(8.5)  
[1] 8  
> round(8.6)  
[1] 9

# 2019-07-17 查看R包中的所有函数

查看某一个包中所涉及的函数可以用 help(package="gplots")； gplots就是一个包的名字。 还可以通过网页搜索 或者R自带搜索查询

如果浏览器不好使，还想查R包中函数，可以试试下面方法 library(help='gplots')

除此之外，还可以再R gui中直接显示包中函数名 ls("package:gplots");

当然还有其他方法，大家可以列举

# R语言配色

[https://www.jianshu.com/p/fbcab3f1a945?utm_source=desktop&utm_medium=timeline](https://www.jianshu.com/p/fbcab3f1a945?utm_source=desktop&utm_medium=timeline) wesanderson配色包

wes_palette("Cavalcanti1", 3)  
wes_palette("Royal1")  
  
# simple barplot  
barplot(c(2,5,7), col=wes_palette(n=3, name="GrandBudapest2"))  
  
library(ggplot2)  
ggplot(iris, aes(Sepal.Length, Sepal.Width, color = Species)) +   
  geom_point(size = 2) +   
  scale_color_manual(values = wes_palette(n=3, name="GrandBudapest2"))

[https://www.jianshu.com/p/e50babec45cb?utm_source=desktop&utm_medium=timeline](https://www.jianshu.com/p/e50babec45cb?utm_source=desktop&utm_medium=timeline) RcolorBrewer包

# 2019-07-20 R语言用ggstatsplot包做方差分析和绘图

[https://www.jianshu.com/p/6547fa7e97c1?utm_source=desktop&utm_medium=timeline](https://www.jianshu.com/p/6547fa7e97c1?utm_source=desktop&utm_medium=timeline)

[https://github.com/IndrajeetPatil/ggstatsplot](https://github.com/IndrajeetPatil/ggstatsplot)

# 用R画圈圈

# https://qa.1r1g.com/sf/ask/480391971/  
# geom_path will do open circles, geom_polygon will do filled circles  
  
signalCircle <- function(cutoff_yy= 0,label="50%",center = c(0,0),diameter = 1,   
                         npoints = 10000,circle_color="black",cirlce_fill="yellow"){  
    
  r = diameter / 2  
  tt <- seq(0,2*pi,length.out = npoints)  
  xx <- center[1] + r * cos(tt)  
  yy <- center[2] + r * sin(tt)  
    
  circle_df <- data.frame(x = xx, y = yy)  
  
    
# 画一个图  
# 添加注释：https://ask.hellobi.com/blog/learn_R/14237  
  
P1 <-ggplot(circle_df) +  
  geom_polygon(data=subset(circle_df,y<=cutoff_yy),  
               aes(x,y),fill="yellow")+  
  geom_path(data=circle_df,aes(x,y),color="black",size=2)+  
  # scale_color_manual(values = c("black"))+  
  # guides(color=FALSE)+  
  theme_void()+  
  annotate("text",x=0,y=0,label=label,size=20) +  
  # ggtitle("50%")+theme(plot.title =element_text(hjust = 0.5,vjust = 1))+  
  coord_fixed()  
  
return(P1)  
}  
#################################################  
# signalCircle(cutoff_yy = -4 , label= "10%",center = c(0,0), diameter = 10,npoints = 50000)  
  
library(cowplot)  
P1 <- signalCircle(cutoff_yy = -4 , label= "10%",center = c(0,0), diameter = 10,npoints = 50000)  
P2 <- signalCircle(cutoff_yy = -3 , label= "20%",center = c(0,0), diameter = 10,npoints = 50000)  
P3 <- signalCircle(cutoff_yy = 0 , label= "50%",center = c(0,0), diameter = 10,npoints = 50000)  
P4 <- signalCircle(cutoff_yy = 3 , label= "80%",center = c(0,0), diameter = 10,npoints = 50000)  
P5 <- signalCircle(cutoff_yy = 4 , label= "90%",center = c(0,0), diameter = 10,npoints = 50000)  
plot_grid(P1,P2,P3,P4,P5,nrow=1)  

# 重命名作用域中的所有变量

## Rename all variables in scope

This probably fits in an earlier section on RStudio Keyboard shortcuts but I think it deserves a section of its own. So you decide to rename one of your objects and then you realize that this object appears like twenty other times in your code and so you have to go and edit those twenty instances also – sound familiar?

Try highlighting the object name and then Ctrl-Alt-Shift-M (or Ctrl-Option-Shift-M). You’ll immediately see that any changes you now make to your object will be changed everywhere that object appears in your current scope. You’re welcome

# R语言绘画网络

## `network` 版

library(network) # 生成一个3节点网络 net <- network.initialize(3) # 画出来 plot(net,vertex.cex=10)

![](https://yufree.cn/cn/2020-06-24-r-network-analysis_files/figure-html/unnamed-chunk-1-1.png)

# 添加一条边 add.edge(net,2,3) # 画出来 plot(net,vertex.cex=10, displaylabels=T)

![](https://yufree.cn/cn/2020-06-24-r-network-analysis_files/figure-html/unnamed-chunk-1-2.png)

# 添加两个点 add.vertices(net,2) # 画出来 plot(net,vertex.cex=10, displaylabels=T)

![](https://yufree.cn/cn/2020-06-24-r-network-analysis_files/figure-html/unnamed-chunk-1-3.png)

# 模拟一个5*12的数据框 df <- matrix(rnorm(60),5) # 用邻接矩阵直接生成网络 dfcor <- cor(df) # 去掉低相关性边 dfcor[dfcor<0.5] <- 0 netcor <- as.network(dfcor,matrix.type = 'adjacency') plot(netcor)

![](https://yufree.cn/cn/2020-06-24-r-network-analysis_files/figure-html/unnamed-chunk-1-4.png)

# 增加节点/边属性 set.vertex.attribute(netcor, "class", length(netcor$val):1) set.edge.attribute(netcor,"color",length(netcor$mel):1) # 可视化属性 plot(netcor,vertex.cex=5,vertex.col=get.vertex.attribute(netcor,"class"),edge.col=get.edge.attribute(netcor,'color'))

![](https://yufree.cn/cn/2020-06-24-r-network-analysis_files/figure-html/unnamed-chunk-1-5.png)

## `igraph` 版

library(igraph) # 生成一个3节点网络 net <- graph.empty(n=3, directed=TRUE) # 画出来 plot(net)

![](https://yufree.cn/cn/2020-06-24-r-network-analysis_files/figure-html/unnamed-chunk-2-1.png)

# 添加两条边 new_edges <- c(1,3, 2,3) net <- add.edges(net, new_edges) # 画出来 plot(net)

![](https://yufree.cn/cn/2020-06-24-r-network-analysis_files/figure-html/unnamed-chunk-2-2.png)

# 添加两个点 net <- add.vertices(net, 2) # 画出来 plot(net)

![](https://yufree.cn/cn/2020-06-24-r-network-analysis_files/figure-html/unnamed-chunk-2-3.png)

# 模拟一个5*12的数据框 df <- matrix(rnorm(60),5) # 用邻接矩阵直接生成网络 dfcor <- cor(df) # 去掉低相关性边 dfcor[dfcor<0.5] <- 0 net <- graph.adjacency(dfcor,weighted=TRUE,diag=FALSE) plot(net)

![](https://yufree.cn/cn/2020-06-24-r-network-analysis_files/figure-html/unnamed-chunk-2-4.png)

# 增加节点/边属性 V(net)$name <- letters[1:vcount(net)] E(net)$color <- "red" E(net)[ weight < 0.7 ]$width <- 2 E(net)[ weight < 0.7 ]$color <- "green" # 可视化属性 plot(net)

![](https://yufree.cn/cn/2020-06-24-r-network-analysis_files/figure-html/unnamed-chunk-2-5.png)

网络可视化只是网络分析的基础，很多基于网络稳定性分析还有网络群组分析都是可以基于更基础的概率图模型来进行，这些分析都有明确的背景问题来源，但涉及的知识点非常多，从统计物理到图论到随机过程，不过如果你带着自己的问题去探索，总会有新的发现。

# R语言学习1：R中的匿名函数、闭包与函数工厂

[https://blog.csdn.net/hdyshr/article/details/82744681](https://blog.csdn.net/hdyshr/article/details/82744681)

R函数式编程语言

R语言是一门学习路线陡峭的编程语言，其中大大小小的沟壑无数。作为函数式编程语言，首先需要对R的函数进行深入的学习。

1.  为什么要进行函数式编程？R函数编程初步
    

简单来说，在R语言中采用函数式编程就是为了提高效率同时减少错误。下面采用例子的方式进行说明：

首先我们建立一个随机的数据框df

set.seed(1014) df <- data.frame(replicate(6, sample(c(1:10, -99), 6, replace = TRUE))) names(df) <- letters[1:6] df 该数据如下图

为对该数据框中的缺失值（-99）进行替换（替换为R标准的缺失值NA），我们可以采用如下代码：

dfa[dfa == -99] <- NA 显然，该方法针对每列需重复6次，且每次复制粘贴语句需修改代码中的两个字母（复制粘贴并修改字母是很多初学者都会做的，但根据经验犯错概率也是相当高的）。

针对该问题，我们采用编写函数的方式对缺失值进行处理。

fix_missing <- function(x) { x[x == -99] <- NA x }

fix_missing(dfa) 运行该段代码，则返回缺失值处理后的dfa，如下图

> fix_missing(df$a) [1] 1 10 7 2 1 6 此时，该函数减少了出错误的可能性，即规范了“将某列中的-99赋值为NA”的过程，但如果此时仍采用复制粘贴6遍的方式处理每一列，仍可能出错，如下：

dfa <- fix_missing(dfa) dfb <- fix_missing(dfb) dfc <- fix_missing(dfc) dfd <- fix_missing(dfd) dfe <- fix_missing(dfe) dff <- fix_missing(dfg) 最后一行在手动修改过程中依然出错。此时的解决方法就是使用lapply函数（R中最重要的函数之一），对数据框df中的每列数据（本质为list，“lapply”也即“list apply”，是对每列数据应用相同的函数进行计算），具体实现如下：

df <- lapply(df, fix_missing) 此时，fix_missing函数被应用于df数据框中的每一列中，但输出结果和我们想象中存在差别，数据框df被赋值成为list的数组

可采用如下两种方式进行修改：

# method 1

df <- as.data.frame(lapply(df, fix_missing))

# method 2

df[] <- lapply(df, fix_missing) 方法1：将缺失值处理后的list数组重新整合为data.frame

方法2：利用原有的df，获得处理缺失值后的dataframe。

个人而言，从语句简洁和内存占用两方面考虑，我会选择方法2.（当然，方法2更能体现R程序员对R运行机制的理解和自身水平）

当仅需对部分列进行处理时，采用lapply也很方便，如下

df[1:4] <- lapply(df[1:4], fix_missing)  总而言之，学会使用函数和lapply()的组合，可以极大提高编程及后续的运行效率。

注：

#1. lapply() 使用C语言实现，因此效率较高。采用R语言的循环语句也可以实现类似的功能，代码如下：

out <- vector("list", length(df)) for(i in seq_along(df)) { out[[i]] <- fix_missing(df[[i]]) } out <- as.data.frame(out) names(out) <- letters[1:6]

2.  最后我们讲解下lapply的另一方便应用。在数据分析中，如果想获取同一数据集的多个指标（如中位数、均值和标准差），一种方法是依次调用多个函数，如下：
    

median(dfa) mean(dfa) sd(dfa) 但如果要继续计算dfb列的结果，那就又再次进入了复制粘贴重复代码的漩涡了。此时需要用到的技术就是R语言中强大的列表存储函数功能，即可将函数名存储在列表中，而后采用lapply()对列表中的每个函数都进行一次运算，代码如下：

summary_rewrite <- function(x) { funs <- c(median, mean, sd) lapply(funs, function(f) f(x, na.rm = TRUE)) } summary_rewrite(df$a)

2.  匿名函数和闭包
    

如果对python编程有初步经验，那么一定对python中lambda函数印象深刻，R中也有类似的匿名函数可以使用。使用匿名函数进行编程可省去大量重复命名函数的痛苦（很多时候编程中最痛苦的事情就是命名了...）。

上一节中讲过lapply()的用法，即

lapply(数据框/列表数组，函数名)

但很多时候往往只想对列表数组中每个列表进行很简单的操作，那根本没有必要再写一个新函数并且命名（有时也实在不好命名），那就可以采用匿名函数。比如我要实现一个功能是计算每列的均值，并且给均值平方，那么实现的代码如下：

lapply(df, function(x) mean(x, na.rm = TRUE)^2) 该语句中就采用了匿名函数，当函数体较为简单时，使用匿名函数可以提高编程效率。

当在lapply外使用匿名函数时需要注意的是需要采用括号，将函数体和输入区分开，如下：

(function(x) 3) (3) (function(x) x + 100) (100) 以上两行代码完全是为了理解原理，实际使用中很少构造这样恶心的东西。实际上，匿名函数最重要的应用之一就是构造闭包，此处需要加重，闭包！！！

如果你有JAVA或者JS的编程经验，那么你一定对闭包有着深刻的理解，或者深恶痛绝，然而在函数编程驱动的R语言中，闭包发挥的作用还是挺大的，深刻地理解R语言的闭包并学会使用，是由R语言调包小白升级成为“会编一点”的R语言大白的重要一步。

一个伟人说过：闭包就是分家单过的儿子（子函数），但是他把爸爸（父函数）的家（父函数的数据和功能-工作环境）席卷了一空，连带把爸爸也接走了。——（By SteveHuxtable in 大二）

比方说我有一项工作是要计算某个数字减n的平方，如果按照朴素的想法，我们会构造一个函数如下

minN_then_square <- function(x, n) { (x - n)^2 } minN_then_square(10, 9) 但这个函数客观来说不够优雅，如果你的需求是求分别减去1,2,3，...，10后的平方结果，那么代码又会变为冗杂的

minN_then_square(10, 1) minN_then_square(10, 2) minN_then_square(10, 3) minN_then_square(10, 4) minN_then_square(10, 5) minN_then_square(10, 6) minN_then_square(10, 7) minN_then_square(10, 8) minN_then_square(10, 9) 这还算好，但如果需求是分别求10到100分别减去1,2,3，...，10后的平方结果呢，灾难出现了，解决方法1则是开始运用循环语句，不过不够优雅，解决方法二就是采用闭包及工厂模式（优雅并高效）。

minN_then_square <- function(N) { function(x) { (x - N) ^ 2 } }

min1_then_square <- minN_then_square(1) min2_then_square <- minN_then_square(2) min3_then_square <- minN_then_square(3) 此时的min1_then_square就是一个闭包。它带有两方面内容：1）父环境定义的运算； 2）N=1这一数据

此时的min1_then_square()就可以直接实现减1后平方的功能，如下：

闭包就是将父函数的数据和运算封装到一起的新函数。

下面进入关键的函数工厂的讲解。

为啥要使用函数工厂的设计模式？（当然如果你懂啥是设计模式，那就不需要再学了）

如上文所说，有些问题需要遍历数组，寻找一个方程某个系数的合适的值（如机器学习中的梯度下降算法），在这种情况下，我们需要一方面保持函数的结构的稳定，另一方面又要将大量的数代入函数进行计算。此时，如果没有稳定的新函数生成模式，那么代码会冗杂，同时易出错。举例来说，就好像可口可乐公司要尝试新logo印出来打印在饮料瓶上应该多大最合适，这个工作一定是已经制作好了打印机，而后用打印机重复性地将不同大小的logo打印在饮料瓶上，而不是每次都要重新安装一次打印机。

其实上文中，已经涉及了函数工厂的思想，后续文章会对函数工厂和闭包应用进行更深的讲解。

附：

1.  由于还没有讲解变量和函数的运行环境，那么我们就简单讲下相关内容。
    

在R语言中，一个变量的存在范围是有限的，比如在某个函数中创建的变量i，在这个函数以外就无法访问，如下

global env i = 10

output_i <- function(x) { # local i in func i <- x i }

output_i(100) #输出100 i #输出10 可见，无论在output_i函数为i赋值为多少，当脱离函数的局部环境返回全局环境是，i依然是10.

也可在局部环境中对全局环境中的变量进行修改，其方法就是将“<-”改为"<<-"，但这种修改是极其危险的。

global env i = 10

output_i <- function(x) { # local i in func i <<- x i }

output_i(100) #输出100 i #输出100 讨论至此，那么闭包究竟是什么呢？回归基本概念，闭包就是在创建时将父函数空间中的变量和运算打包封装的函数。每当创建一个闭包（子函数）时父函数的变量和运算都会被复制一份给闭包，且这些变量和运算是不会被垃圾回收的。

我们写一个简单的闭包，对闭包的概念进行解释

a simple one multi10 <- function() { i = 10

function() {  
    i <<- i * 10  
    i  
}

}

multi10_1 <- multi10() multi10_2 <- multi10() 上段代码展示了闭包的写法，闭包multi10_1和multi10_2这两个闭包实现了对数据i和函数的封装。两个闭包有着不同的环境，两个闭包中的变量i不会共享。为了实验，我们执行闭包函数以查看结果。

multi10_1() # [1] 100 multi10_1() # [1] 1000 multi10_2() # [1] 100 可见，当闭包multi10_1()中的变量i已经为1000后，另一个闭包中的i仍为10（运行函数后变为100）。

至此，我们已经对匿名函数、函数作用域，闭包等概念有了了解。在后续的R函数相关内容讲解中，匿名函数和闭包会有大量应用。

该内容会在每周一和周四夜间更新。

参考书目：

1.  《高级R语言编程指南》, Hadley Wickham, 2016. ———————————————— 版权声明：本文为CSDN博主「Steve_Huxtable」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。 原文链接：[https://blog.csdn.net/hdyshr/article/details/82744681](https://blog.csdn.net/hdyshr/article/details/82744681)
    

查看R版本：

version

我们首先要知道自己的R包安装到了什么地方?

> .libPaths() 现在的R包应该的位置

[1] "/usr/local/lib/R-X11/site-library" [2] "/usr/local/Cellar/r-x11/4.0.1/lib/R/library"

> R.home() [1] "/usr/local/Cellar/r-x11/4.0.1/lib/R" Sys.which("R") R "/usr/local/bin/R"

# 升级R版本之后，R包的迁移

产看自己旧有包的位置

.//usr/local/lib/R/3.5/site-library/tidyverse .//usr/local/lib/R/3.5/site-library/tidyverse/R/tidyverse

update.packages(ask = FALSE, checkBuilt = TRUE)

# 最后解决方法

完全卸载自己的R语言 brew uninstall r-x11 重新从官网下载进行安装，没有使用brew进行安装

安装tidy verse报错，

Error: package or namespace load failed for ‘tidyverse’ in loadNamespace(j <- i[[1L]], c(lib.loc, .libPaths()), versionCheck = vI[[j]]):

使用命令

install.packages("pillar", type = "binary")

解决问题

实际上系统自带的命令通常安装在 /usr/bin/ 目录下，而用户自己安装的命令通常在 /usr/local/bin/ 目录下，这通常是因为普通安装命令都是在 /usr/local/bin/ 下有写的权限的。

安装了一些插件

AlignAssign devtools::install_github("seasmith/AlignAssign")

R是一种函数式的语言

“万物皆对象”是指R的基本数据结构的地位都是相同的，任何东西包括函数都可以认为是对象，都能作为参数传入到函数中。而“面向对象”指的是一种编程泛型，已经成为一个专有的名词。

开发一些R包需要对特殊的对象重定义S3(下一章会讲)的方法，需要对大量程序代码最大化的重用和封装(S4(后面会讲到))，那么这时候你同样需要用到R语言的面向对象的编程。

一句话，随着R语言的发展，R面向对象编程一定是一个大的趋势。

# What is the meaning of the “.” (dot) in R?

dot can be placeholder in magrittr

[https://bbs.pinggu.org/thread-3742150-1-1.html](https://bbs.pinggu.org/thread-3742150-1-1.html)

改变barplot的粗细和空间大小

genotype_plot <- ggbarplot( pheo_data, x = "Genotype", y = "Log10_Colonies", add = "mean_se", palette = "simpsons", position = position_dodge(0.8), add.params = list(group = "Genotype"), label = T, label.pos = "out", lab.vjust = -0.7, lab.nb.digits = 2, color = "black", fill = "Genotype", ylim = c(0, 6.5) ) + labs(title = "DC3000") + theme_classic(base_size = 15) + theme( axis.text = element_text(color = "black", face = "bold"), aspect.ratio = 1.5 / 1, axis.text.x = element_text(angle = 45, hjust = 1), axis.title.x = element_blank(), legend.position = "none" ) + scale_fill_grey(start = 0, end = 0.9)

genotype_plot

theme( axis.text = element_text(color = "black", face = "bold"), aspect.ratio = 1.5 / 1, axis.text.x = element_text(angle = 45, hjust = 1), axis.title.x = element_blank(), legend.position = "none" ) + scale_fill_grey(start = 0, end = 0.9)

好的参考资料

[https://www.datanovia.com/en/lessons/anova-in-r/](https://www.datanovia.com/en/lessons/anova-in-r/)

# Visualization: box plots with p-values  
pwc <- pwc %>% add_xy_position(x = "gender")  
bxp +  
  stat_pvalue_manual(pwc) +  
  labs(  
    subtitle = get_test_label(res.aov, detailed = TRUE),  
    caption = get_pwc_label(pwc)  
    )

stat_pvalue_manual {ggpubr}

Add Manually P-values to a ggplot Description Add manually p-values to a ggplot, such as box blots, dot plots and stripcharts. Frequently asked questions are available on Datanovia ggpubr FAQ page, for example:

[https://www.datanovia.com/en/blog/how-to-add-p-values-onto-a-grouped-ggplot-using-the-ggpubr-r-package/](https://www.datanovia.com/en/blog/how-to-add-p-values-onto-a-grouped-ggplot-using-the-ggpubr-r-package/)

scripts：add p-values onto grouped ggplots.Rmd

效果图：

library(tidyverse)  
library(ggpubr)  
library(rstatix)

# analysis

# Transform `dose` into factor variable  
df <- ToothGrowth  
df$dose <- as.factor(df$dose)  
head(df, 3)

stat.test <- df %>%  
  group_by(dose) %>%  
  t_test(len ~ supp) %>%  
  adjust_pvalue(method = "bonferroni") %>%  
  add_significance("p.adj")  
stat.test

# Create a box plot  
bxp <- ggboxplot(  
  df, x = "dose", y = "len",   
  color = "supp", palette = c("#00AFBB", "#E7B800")  
  )  
  
# Add p-values onto the box plots  
stat.test <- stat.test %>%  
  add_xy_position(x = "dose", dodge = 0.8)  
  
stat.test  
  
bxp + stat_pvalue_manual(  
  stat.test,  label = "p", tip.length = 0  
  )  
  
# Add 10% spaces between the p-value labels and the plot border  
bxp + stat_pvalue_manual(  
  stat.test,  label = "p", tip.length = 0  
  ) +  
  scale_y_continuous(expand = expansion(mult = c(0, 0.1)))

# Use adjusted p-values as labels  
# Remove brackets  
bxp + stat_pvalue_manual(  
  stat.test,  label = "p.adj", tip.length = 0,  
  remove.bracket = TRUE  
  )  
  
# Show adjusted p-values and significance levels  
# Hide ns (non-significant)  
bxp + stat_pvalue_manual(  
  stat.test,  label = "{p.adj}{p.adj.signif}",   
  tip.length = 0, hide.ns = TRUE  
  )

# Additional statistical test  
stat.test2 <- df %>%  
  t_test(len ~ dose, p.adjust.method = "bonferroni")  
  
stat.test2

# Add p-values of `stat.test` and `stat.test2`  
# 1. Add stat.test  
stat.test <- stat.test %>%  
  add_xy_position(x = "dose", dodge = 0.8)  
  
bxp.complex <- bxp + stat_pvalue_manual(  
  stat.test,  label = "p", tip.length = 0  
  )  
  
# 2. Add stat.test2  
# Add more space between brackets using `step.increase`   
stat.test2 <- stat.test2 %>% add_xy_position(x = "dose")  
  
bxp.complex <- bxp.complex +   
  stat_pvalue_manual(  
    stat.test2,  label = "p", tip.length = 0.02,  
    step.increase = 0.05  
  ) +  
  scale_y_continuous(expand = expansion(mult = c(0.05, 0.1)))  
  
# 3. Display the plot  
bxp.complex

# Bar plots  
bp <- ggbarplot(  
  df, x = "supp", y = "len", fill = "dose",  
  palette = "npg", add = "mean_sd",  
  position = position_dodge(0.8)  
  )  
bp

stat.test <- df %>%  
  group_by(supp) %>%  
  t_test(len ~ dose)  
stat.test   
  
  
# Bar plots with p-values  
stat.test <- stat.test %>%  
  add_xy_position(x = "supp", fun = "mean_sd", dodge = 0.8)  
bp +   
  stat_pvalue_manual(  
    stat.test, label = "p.adj", tip.length = 0.01,  
    bracket.nudge.y = -2  
    ) +  
  scale_y_continuous(expand = expansion(mult = c(0, 0.1)))

参考来自：

[https://d.cosx.org/d/421969-barplot-y-axis-gap](https://d.cosx.org/d/421969-barplot-y-axis-gap)

效果图：

library(tidyverse)

# analysis

# 准备数据，来自楼主代码：  
set.seed(123)  
vl <- c(rnorm(10) + 4, rnorm(8) + 50)  
grp <- c(rep("A", 5),   # 实验有 4 个分组  
         rep("B", 4),  
         rep("C", 4),  
         rep("D", 5))  
lbs <- c(paste0("A", 1:5),   # 每组数据量不一  
         paste0("B", 1:4),  
         paste0("C", 1:4),  
         paste0("D", 1:5))  
colors <- c(rep("red", 5),  # 打算每组用不同的颜色  
            rep("darkgreen", 4),  
            rep("blue", 4),  
            rep("orange", 5))  
dat <- data.frame(id = 1:18,  
                  group = grp,  
                  label = lbs,  
                  color = colors,  
                  value = vl)  
  
dat

# 修改数据  
ygap <- 12  
yshift <- 30  
dat$value_new <- ifelse(dat$value > ygap, dat$value - yshift, dat$value)  
  
dat

  
sp <- c(0, rep(.2, 4), 1,  
        rep(.2, 3), 1,  
        rep(.2, 3), 1,  
        rep(.2, 4))  
  
sp  
  
# 对新数据作条形图  
barplot(value_new ~ label,  
        col = colors,  
        space = sp,  
        border = "white",  
        axes = FALSE, axisnames = FALSE,  
        ylim = c(0, 56 - yshift),  
        data = dat)  
  
# 加一条白色横线  
abline(h = ygap, col = "white", lwd = 6)  
  
# x 轴，来自楼主代码  
atidx <- c(.5 + 1.2 * 0:4,  
           .5 + 1.2 * 4 + 2 + 1.2 * 0:3,  
           .5 + 1.2 * 4 + 2 + 1.2 * 3 + 2 + 1.2 * 0:3,  
           .5 + 1.2 * 4 + 2 + 1.2 * 3 + 2 + 1.2 * 3 + 2 + 1.2 * 0:4)  
  
  
axis(1,   
     lwd = 2,  
     tck = -.01,  
     # lwd.ticks = 2,  
     at = atidx,  
     # tick = FALSE,  
     labels = FALSE, )  
text(x = atidx,  
     y = par("usr")[3] - 3,  
     labels = dat$label,  
     xpd = NA,  
     ## Rotate the labels by 35 degrees.  
     srt = 30,  
     cex = .75)  
  
# y 轴  
yat <- pretty(dat$value_new)  
ylab <- ifelse(yat > ygap, yat + yshift, yat)  
axis(2, at=yat, labels=ylab)  
plotrix::axis.break(2, ygap, style="slash")  
box()  

df <- structure(list(ID = c("ID1", "ID1", "ID1", "ID2", "ID2", "ID2",   
"ID3", "ID3", "ID3"), category = c("length", "type", "color",   
 "length", "type", "color", "length", "type", "color"),   
 value = c("100",   
 "L", "Blue", "100", "M", "Blue", "150", "M", "Blue")),   
 class = "data.frame", row.names = c(NA, -9L))  
  
df

  
# create a new column that combines category and value  
df = df %>% unite(cat_val, category, value, remove = F)  
  
# create vectorised function that counts matches (on that new value)  
f = function(x,y) sum(df$cat_val[df$ID == x] == df$cat_val[df$ID == y])  
f = Vectorize(f)  
  
data.frame(t(combn(unique(df$ID), 2))) %>%  # create combinations of IDs (as a dataframe)  
  mutate(matches = f(X1, X2))               # apply function  

Rstudio提供了一个更加方便的工具：snippets

点击Rstudio的Tools -> Global Options -> Code -> Tab Editing -> Snippets -> "Edit Snippets" ，然后拉到最下面，输入下面的template（具体内容可个性化的修改）：

snippet template_header  
    ## ---------------------------  
    ##  
    ## Script name:   
    ##  
    ## Purpose of script:  
    ##  
    ## Author: Dr. Timothy Farewell  
    ##  
    ## Date Created: `r paste(Sys.Date())`  
    ##  
    ## Copyright (c) Timothy Farewell, `r paste(format(Sys.Date(), "%Y"))`  
    ## Email: hello@timfarewell.co.uk  
    ##  
    ## ---------------------------  
    ##  
    ## Notes:  
    ##     
    ##  
    ## ---------------------------  
      
    ## set working directory for Mac and PC  
      
    setwd("~/Google Drive/")        # Tim's working directory (mac)  
    setwd("C:/Users/tim/Google Drive/")     # Tim's working directory (PC)  
      
    ## ---------------------------  
      
    options(scipen = 6, digits = 4) # I prefer to view outputs in non-scientific notation  
    memory.limit(30000000)      # this is needed on some PCs to increase memory allowance, but has no impact on macs.  
      
    ## ---------------------------  
      
    ## load up the packages we will need:  (uncomment as required)  
      
    require(tidyverse)  
    require(data.table)  
    # source("functions/packages.R")       # loads up all the packages we need  
      
    ## ---------------------------  
      
    ## load up our functions into memory  
      
    # source("functions/summarise_data.R")   
      
    ## ---------------------------

保存后，若想调用，就在script中输入template_header，然后tab键即可调用了

个人觉得很好用哈。。。

[https://www.cnblogs.com/leezx/p/14374326.html](https://www.cnblogs.com/leezx/p/14374326.html)

dplyr dplyr常用函数【最常用的也就是group_by和summarise配合使用了，其他的普通代码都能实现】

arrange

arrange(aapl, -Volume) # 对appl数据按照字段Volume进行降序排序

aapl %>% arrange(-Volume) # 管道符 %>% 可读性更强

select

aapl %>% select(Date, Close, Volume) # 选取 Date、Close和Volume三列

aapl %>% select(-c("Open", "High", "Low")) # 排除Open、High、Low，选择剩下的字段的数据

filter

aapl %>% filter(Close>=150) # #从数据中选择appl股价大于150美元的交易数据

aapl %>% filter((Close>=150) & (Close>Open)) # 股价大于150美元 且 收盘价大于开盘价 的交易数据

mutate

aapl %>% mutate(maxDif = High-Low, log_maxDif=log(maxDif)) # 将最好价High减去最低价Low的结果定义为maxDif，并取log

aapl %>% mutate(n=row_number()) # 得到记录的位置(行数)

group_by

weather %>% group_by(city) group_by()也是我最喜欢用的函数之一，如果单纯用group_by()对数据框进行操作的话，是看不出数据框有啥变化的，但是如果接着用其他函数操作的话，就是相当于对数据框进行分组操作了，如下：

以Species分组，得Sepal.Length列中值大于6的行，进而统计其标准差

group_by(iris, Species) %>% filter(Sepal.Length > 6) %>% summarise(SD = sd(Sepal.Length))

summarise

weather %>% group_by(city) %>% summarise(mean_temperature = mean(temperature)) # 按照城市分组，按照城市分别计算平均温度

使用pivot_longer 和pivot_wider函数

plyr plyr重要函数【mapvalues是唯一常用的函数】 plyr包里的revalue()或mapvalues() 将向量中所有值为x的实例改为值y。 library(plyr) revalue(str, c("beta"="two", "gamma"="three")) mapvalues(str, from = c("beta", "gamma"), to = c("two", "three"))

Tidyverse tibble vs dataframe

如果你是用R base，那就data.frame吧如果你是要用tidyverse，那就果断tibble，当然tiverse也支持data.frame二者基本是一样的数据结构，tibble多了一些优化设计，只是让你用起来更好，并没有增加使用负担。再一个就是，tidyverse是大势所趋，是比R base好用了数倍不止，比Python的pandas还好用，我建议用tidyverse入门R语言。

dataframe是R原生的，很老了，有很多毛病，例如性能一般、语法书写臃肿、可读性不强，后来有第三方出于以上考虑改进了dataframe，就派生出两个典型系列的包data.table和tibble，data.table侧重性能，tibble侧重语法可读性（优雅，主要是tibble有一系列配套的Rstudio全家桶）。另外补充，tibble是支持嵌套表的，dataframe和data.table并没有。近期，data.table和tibble有融合的趋势，Rstudio团队和一些其他团队，让tibble能尽量使用data.table的引擎（底层是C语言）。

summarise和mutate函数都可以对一个数据框的某一列(而不是整个数据框)进行修改和汇总，两者的主要区别在于返回结果的方式不同，其中summarise函数返回一个只包含修改或汇总后数据的数据框，而mutate函数则返回一个由原始数据和修改或汇总后数据两部分构成的数据框(mutate函数与基础包的transform函数相似，两者的区别在于；muate函数可以对刚刚建立起来的列进行计算，而transform函数只能针对数据的原始列进行计算

require(plyr)  
set.seed(1) # 保证每次产生的数据框的唯一性  
dfx <- data.frame(  
  group = c(rep('A', 8), rep('B', 15), rep('C', 6)),  
  sex = sample(c("M", "F"), size = 29, replace = TRUE),  
  age = sample(20:30, size = 29, replace = TRUE),  
  worktime = sample(1:5, size = 29, replace = TRUE)  
)  
### 数据修改  
summarise(dfx, age = age + 1) # 返回一个只含一列age的数据框  
mutate(dfx, age = age + 1) # 返回一个和dfx列数一样的4列数据框，但age列的数值已经修改  
### 数据汇总  
summarise(dfx, mean.age = mean(age), sd.age = sd(age)) # 返回一个只含汇总结果的2列数据框  
mutate(dfx, mean.age = mean(age), sd.age = sd(age)) # 返回一个由dfx和汇总结果组成的4列数据框

plyr包是apply家族函数的升级版本，使用plyr包可以实现：在一个函数内同时完成“Split - Apply - Combine”，并且，plyr包实现R类型（vector, list, data.frame）之间的分组变换，基本上可以取代Base包中的apply家族函数。

1、查看已加载的包

(.packages())

注意外面的括号和前面的点不能省。

包被安装后，在使用前需要加载。加载包使用命令 library(包名)，比如library(codetools)。

查看有哪些包是被加载的，使用命令(.packages()) ，注意小括号和点号不能省略。

2、卸除已加载的包

如卸除RMySQL包

detach(“package:RMySQL”)

注意是卸除，不是卸载，也就是说不是把包从R运行环境中彻底删除，只是不希望该包被加载使用。

在包使用函数冲突，检验函数依赖时比较有用。

要将已经加载的包卸除。注意不是卸载删除，只是不加载这个包。在包函数冲突时需要。使用命令detach("package:包名")。或则detach("package:包名", unload=TRUE)

[https://www.cnblogs.com/ljhdo/p/4907570.html](https://www.cnblogs.com/ljhdo/p/4907570.html)

plyr包是apply家族函数的升级版本，使用plyr包可以实现：在一个函数内同时完成“Split - Apply - Combine”，并且，plyr包实现R类型（vector, list, data.frame）之间的分组变换，基本上可以取代Base包中的apply家族函数。

plyr包对核心函数的命名采用统一的格式：**ply，所有的函数名都由5个字符组成，且最后三个字符是ply，函数名的第一个字符代表输入数据的类型，第二个字符代表输出数据的类型，R类型的简写是：

d：data.frame l：list a：array，vector，matrix r：代表replicate，重复多次 m：多输入 _：舍弃输出结果

一，plyr包函数 plyr包用于在R中实现split-apply-combine的模式，这中模式在数据分析中是极其常见的，通过把数据分解为小的分片，然后在分片上做操作，最后把结果组合在一起，以解决复杂的分析问题。因此，当遇到复杂的数据分析问题时，一般都需要把复杂的问题分组，然后在每个分组上做操作，最终把每个分组上的结果组合到一起。plyr包的函数很多，除了**ply的核心函数之外，还有一些辅助函数，在处理数据时，都十分有用。

1，ddply

plyr包中最常用的函数是ddply()函数，该函数对数据框进行操作，对每一行调用一个函数，并返回数据框类型：

ddply(.data, .variables, .fun = NULL, ...) 参数注释：

.data：函数处理的数据框； .variables：要进行拆分的变量名称，传递变量的格式是： .(col_name)，就是把进行分组的变量名包含在.()中； .fun：应用到每行的函数 ...：传递到fun的其他参数 对于参数fun，有两种赋值方式：

第一种： 如果使用colwise()函数，那么这使ddply函数把参数fun应用于每一列，除了参数.variable指定的数据列之外，例如：

ddply(diamonds,.(color),colwise(mean)) 第二种： 使用summarize函数对指定的列执行操作，更为灵活，例如：

> ddply(diamonds,.(color),summarize,avg_price=mean(price),avg_carat=mean(carat)) color avg_price avg_carat 1 D 3169.954 0.6577948 2 E 3076.752 0.6578667 ..... 2，each函数

plyr包的each()函数，能够把多个函数整合到一个函数中，每一个函数必须只能返回一个数值：

each(...) 使用each()函数，可以使函数aggregate()同时调用多个函数：

> aggregate(cbind(price,carat)~cut+color,diamonds,each(mean,sum)) cut color price.mean price.sum carat.mean carat.sum 1 Fair D 4291.061 699443.000 0.9201227 149.9800000 2 Good D 3405.382 2254363.000 0.7445166 492.8700000 ...... 3，rename函数

按照名字对变量重命名：

rename(x, replace, warn_missing = TRUE, warn_duplicated = TRUE) 参数注释：

x： 重命名的对象 replace：命名的向量，格式是：c(new_name=old_name,...) 使用rename函数对数据框的变量进行重命名，例如：

rename(mtcars, c("disp" = "displacement")) 4，arrange函数

按照数据框的变量对数据框排序，注意，arrange()函数不会保留行名称（row.names）

arrange(df, ...) 例如，按照变量cyl和disp，对数据框mtcars进行排序：

# sort mtcars data by cylinder and displacement

mtcars[with(mtcars, order(cyl, disp)), ]

# Same result using arrange: no need to use with(), as the context is implicit

arrange(mtcars, cyl, disp) 5，mutate函数

对数据框进行转换，或增加新的变量，或替换已经存在的变量，该函数和transfrom函数十分相似，不过，mutate()函数是递进式的，这使得后期的转换可以使用早期创建的变量。

# Things transform can't do

mutate(airquality, Temp = (Temp - 32) / 1.8, OzT = Ozone / Temp) 6，name_rows函数

在设计时，没有plyr函数会保留行名称（row names）。如果想保留行名称，可以使用name_rows()把行名称转换为显式的列值，在执行为相应的plyr操作之后，再使用name_rows把列值转换为行名称。

name_rows(df) 参数df ：数据框对象，拥有 rownames，或者显式的列名 .rownames

二，拆分-应用-组合 在R语言中，分组聚合可以通过三步实现：拆分-应用-合并（Split-Apply-Combine）。例如，对玩家的游戏成绩进行统计和分析，创建示例数据：

> players_scores <- data.frame( player=rep(c('Tom','Dick','Jim'),times=c(2,5,3)), score=round(runif(10,1,100),-1) ) 1，分组数据

计算每个玩家的平均得分，首先对玩家分组，需要用到split()函数，按照特定的字段对数据进行分组：

split(x, f, drop = FALSE, ...) 参数注释：

x：数据框或向量，是被分组的数据； f：因子类型，按照f对x进行分组； 函数的返回值是一个列表对象，每一个列表项都是包含分组数据的向量。

例如，split(score,player)函数的作用是按照player字段把数据框中的score拆分成一组，也就是说，player 相同的score是同一个分组，填充到同一个列表项中：

复制代码

> (scores_by_player <- with(players_scores,split(score,player))) $Dick [1] 70 20 30 70 70

$Jim [1] 80 90 50

$Tom [1] 80 90 复制代码 2，应用函数

当数据分割之后，对每个分组计算平均分。使用lapply()函数，对于每个列表项，应用mean()函数，计算单个列表项的平均值，例如：

list_mean_by_player <- lapply(scores_by_player,mean) 3，组合数据

组合数据是为了显示数据，在显示最终的数据时，通常把列表转换为向量。lapply()函数返回的结果是一个列表对象，每一个列表项都是一个向量，因此可以使用unlist()函数，把列表转换为向量，例如：

> unlist(list_mean_by_player) Dick Jim Tom 52.00000 73.33333 85.00000 三，使用apply家族函数实现分组聚合 在apply家族函数中，每个函数都用于特定的数据类型：

apply函数只能用于矩阵， lapply函数能够用于向量和列表（list），其工作原理是把一个函数应用于一个列表中的每个元素上，并且把结果作为列表返回； sapply处理列表，返回向量。 mapply函数，把调用的函数应用到多个列表的每一个元素中。 tapply函数用于分组聚合运算，在研究数据时，有时需要对数据按照特定的字段进行分组，然后统计各个分组的数据，这就是SQL语法中的分组聚合。 在数据分析中，使用Base包实现”拆分-应用-合并“ 显得十分繁琐，可以使用tapply()函数一次完成所有的三个步骤，一气呵成：

with(players_scores,tapply(score,player,mean)) tapply()函数常用的参数共有三个，第一个参数是数据框对象或向量，第二个参数是因子列表，也就是分组字段，第三个参数是指对单个分组应用的函数：

tapply(X, INDEX, FUN = NULL, ...) by()函数和aggregate()函数是tapply()函数的包装函数，功能相同，接口稍微不同。

by(data, INDICES, FUN, ..., simplify = TRUE) aggregate(x, by, FUN, ..., simplify = TRUE, drop = TRUE) 四，使用plyr包实现分组聚合 函数daply的作用是分割数据框，对每个分组应用聚合函数，最后把每个分组的聚合值组合起来，以数组的形式返回：

daply(.data, .variables, .fun = NULL, ...) 参数注释：

.data：数据框，存储用于分析的数据； .variables：分组字段，指定分组字段的格式是 .(col_name)； .fun：应用于每个分组的函数，有两种方式，上文有详细介绍。 为了计算每个player的平均得分，可以使用daply()函数，例如，

unlist(daply(players_scores,.(player),summarize,varScore=mean(score))) 在示例中，daply()函数返回的类型是list，通过unlist()函数转换为向量。至于为什么返回的是list，而不是数组，我也很疑惑。

# In the remote desktop use

module load gcc  
module load r  
module load rstudio  
rstudio

ssh -Y halstead-a319

Interactive Jobs

qsub -I -q standby -l nodes=1:ppn=20 -l walltime=04:00:00 -X

srun -N 2 --ntasks-per-node=8 --pty bash

sinteractive -A li2627 -N2 -n20  
sinteractive -A standby

to know the detail about the module, for example

module show bowtie2

哈佛的 STAT110 是一门非常受欢迎的初等概率课程，它也在 edX 上有免费的公开课；授课老师 Joe Blitzstein 和 Jessica Hwang 最近将相应的教科书免费发布出来了（[http://probabilitybook.net](http://probabilitybook.net)；墙外），书中有配套的初等 R 代码，可供巩固理解概率论中的一些概念，或用模拟验证理论结果

[http://stat110.net](http://stat110.net)

[https://bookdown.org/wangminjie/R4EDA/intro.html](https://bookdown.org/wangminjie/R4EDA/intro.html)

[https://guangchuangyu.github.io/statistics_notes/index.html](https://guangchuangyu.github.io/statistics_notes/index.html)

R是函数式语言

r作为一个结合了函数式编程和面向对象的实现

R 作为一种向量化的编程语言，一大特征便是以向量计算替代了循环计算，使效率大大提升。apply函数族正是为解决数据循环处理问题而生的 —— 面向不同数据类型，生成不同返回值的包含8个相关函数的函数族。

理解 R 计算 一切皆是对象。 一切皆是函数调用。

在 R 中, 单纯地在循环中增加括号, 就能够使得循环的速度下降.

这样的情况下, 就应该取考虑映射 (mapping), 即在一系列数据上重复地去使用同一个函数, 即把该函数映射到数据上.

如果你熟悉了apply族函数，那么将数据转为并行运算是轻而易举的事情。plyr包则可看作是apply族函数的扩展，使之更容易运用，功能更为强大。