---
title: "R语言data.table学习"
date: 2020-05-05T23:57:39-04:00
author: KJY
slug: data.table
draft: false
toc: true
categories:  
  - R
tags:        
  - article
---



关于data.table和pandas之间的比较：[A data.table and pandas small stroll · Home (atrebas.github.io)](https://atrebas.github.io/post/2020-06-14-datatable-pandas/)

关于data.table和dplyr之间的比较：[A data.table and dplyr tour · Home (atrebas.github.io)](https://atrebas.github.io/post/2019-03-03-datatable-dplyr/)

## 介绍

`data.frame`是R内置的、默认的数据框类型（即一个具有行和列的数据表）。从外部导入的数据一般都以`data.frame`数据框格式在R里面进行处理和分析。

`data.table`作为一种高级数据类型，首先继承了`data.frame`基础数据类型，其[官方文档](https://link.zhihu.com/?target=https%3A//cran.r-project.org/web/packages/data.table/data.table.pdf)已经明确说明“`data.table`是`data.frame`的扩展（extension）”。



`data.table`具备很多独特而出色的性质，与其他数据类型（如`data.frame`、`tibble`/`tbl_df`）相比具有很多优势。

- **高效：轻松、快速处理GB级别的大数据，并且融合了SQL数据库的语法风格**
- **极简：只需很短的代码就能完成数据的行、列、分组、合并、重塑等相关操作**
- **丰富：数据类型自带筛选、计算、分组、合并等多种方法，无需借助其他函数**

此外，一部分R用户需要在数据框里面“嵌套表”，由于`data.frame`无法实现而十分推崇`tibble`（`tbl_df`）。其实，这一点不仅`tibble`能实现，`data.table`也完全能实现。

Jan Gorecki 曾对比过不同开源软件及程序包在数据处理方面的性能，结果发现，`data.table`在数据处理效率上秒杀一大批工具包，甚至轻松超越Python的`pandas`包和R语言的`dplyr`包（结果如下图，测试数据规模为5 GB）。而当数据规模达到50 GB，`pandas`和`dplyr`都已经hold不住了（报错或内存溢出），但`data.table`依然稳居榜首（详见：[数据处理工具性能大比拼](https://link.zhihu.com/?target=https%3A//h2oai.github.io/db-benchmark/)）。



使用`data.table`包并不意味着排斥或弃用其他R包——相反，`data.table`包是能够和`tidyverse`、`dplyr`等著名R包**兼容并存、相辅相成**的。



这里需要明确几个事实：

- `tidyverse`本身只是一系列常用包的集合（包括`dplyr`、`ggplot2`、`lubridate`、`stringr`、`tibble`、`tidyr`等），并且载入时会为用户默认载入某些常用包，但它本身并没有什么实质性的函数（不信可以查看它的帮助文档）。
- 管道操作符（`%>%`）非常好用，也与`data.table`完全兼容，但它本身既不是`tidyverse`包里的，也不是`dplyr`包里的，而是`magrittr`包里的。
- `dplyr`包的各种数据操作或处理函数，完全适用于`data.frame`、`tibble`/`tbl_df`、`data.table`等数据类型，因此`data.table`与`dplyr`并不冲突（比如，我个人也喜欢用`dplyr::left_join()`函数对`data.table`数据进行匹配拼接处理）。

总之：

- `tidyverse`是建议安装的一个综合性R包（并不必然与`tibble`相联系）
- `dplyr`是建议掌握的一个数据处理R包（并不必然与`tibble`相联系）
- `data.table`是强烈建议掌握的一个兼具数据类型和数据处理功能的R包
- 这三者是可以兼容并包、组合使用的

data.table包提供了一个非常简洁的通用格式：DT[i,j,by]，一句话概括：**用 i 选择行，用 j 操作列，根据 by 分组**。

其中，j 表达式非常强大和灵活，可以选择、修改、汇总、计算新列，甚至可以接受任意表达式。需要记住的最关键一点是：**只要返回等长元素或长度为 1 元素的 list，每个 list 元素将转化为结果 data.table 的一列。**



注意:

data.table之后，一些常规的data.frame的操作就失效了，譬如：

data[,-1]、data[,1]这样的操作就不是这么用的了。

## 使用data.table包操作数据

**data.table包提供了一个加强版的data.frame，它运行效率极高，而且能够处理适合内存的大数据集，它使用\[\]实现了一种自然地数据操作语法**。使用下面命令进行安装：

```
install.packages("data.table")
```

载入包：

```
library(data.table)
#> 
#> 载入程辑包：'data.table'
#> The following objects are masked from 'package:reshape2':
#> 
#>     dcast, melt
```

注意，`data.table`包提供了加强版的`dcast()`和`melt()`，它们的功能更强大、性能更高，内存使用也更高效。

创建`data.table`与创建`data.frame`类似：

```
dt = data.table(x = 1:3, y = rnorm(3), z = letters[1:3])
dt
#>    x      y z
#> 1: 1  0.906 a
#> 2: 2 -0.154 b
#> 3: 3  0.608 c
```

检查它的结构：

```
str(dt)
#> Classes 'data.table' and 'data.frame':   3 obs. of  3 variables:
#>  $ x: int  1 2 3
#>  $ y: num  0.906 -0.154 0.608
#>  $ z: chr  "a" "b" "c"
#>  - attr(*, ".internal.selfref")=<externalptr>
```

可以看到，`dt`的类是`data.table`和`data.frame`，也就是说`data.table`继承了`data.frame`的一些行为，但增强了其他部分。

\*\*`data.table`的基本语法是`dt[i, j, by]，简单说就是使用`i`选择行，用`by`分组，然后计算`j`**。接下来我们看看`data.table\`继承了什么，增强了什么。

首先，我们仍然载入之前用到的产品数据，不过这里我们使用`data.table`包提供的`fread()`函数，它非常高效和智能，默认返回`data.table`。

```
product_info = fread("../../R/dataset/product-info.csv")
product_stats = fread("../../R/dataset/product-stats.csv")
product_tests = fread("../../R/dataset/product-tests.csv")
toy_tests = fread("../../R/dataset/product-toy-tests.csv")
```

如果查看表格信息，你会发现它和`data.frame`没什么两样：

```
product_info
#>     id      name  type   class released
#> 1: T01    SupCar   toy vehicle      yes
#> 2: T02  SupPlane   toy vehicle       no
#> 3: M01     JeepX model vehicle      yes
#> 4: M02 AircraftX model vehicle      yes
#> 5: M03    Runner model  people      yes
#> 6: M04    Dancer model  people       no
```

再看结构：

```
str(product_info)
#> Classes 'data.table' and 'data.frame':   6 obs. of  5 variables:
#>  $ id      : chr  "T01" "T02" "M01" "M02" ...
#>  $ name    : chr  "SupCar" "SupPlane" "JeepX" "AircraftX" ...
#>  $ type    : chr  "toy" "toy" "model" "model" ...
#>  $ class   : chr  "vehicle" "vehicle" "vehicle" "vehicle" ...
#>  $ released: chr  "yes" "no" "yes" "yes" ...
#>  - attr(*, ".internal.selfref")=<externalptr>
```

与`data.frame`不同，如果只提供一个参数用来构建子集，`data.table`是选择行而不是列：

```
product_info[1]
#>     id   name type   class released
#> 1: T01 SupCar  toy vehicle      yes

product_info[1:3]
#>     id     name  type   class released
#> 1: T01   SupCar   toy vehicle      yes
#> 2: T02 SupPlane   toy vehicle       no
#> 3: M01    JeepX model vehicle      yes
```

如果提供的是负数，那么将删除指定的行：

```
product_info[-1]
#>     id      name  type   class released
#> 1: T02  SupPlane   toy vehicle       no
#> 2: M01     JeepX model vehicle      yes
#> 3: M02 AircraftX model vehicle      yes
#> 4: M03    Runner model  people      yes
#> 5: M04    Dancer model  people       no
```

**data.table提供了许多特殊符号，它们是data.table的重要组成**。`.N`是最常用的符号之一，它表示当前分组中，对象的数目（就不用调用`nrow`函数啦）。在`[]`使用它指提取最后一行。

```
product_info[.N]
#>     id   name  type  class released
#> 1: M04 Dancer model people       no
product_info[c(1, .N)]
#>     id   name  type   class released
#> 1: T01 SupCar   toy vehicle      yes
#> 2: M04 Dancer model  people       no
```

在对`data.table`构建子集时，能够自动根据语义计算表达式，因此可以直接使用列名，像`with()`和`subset()`那样。

比如：

```
product_info[released == "yes"]
#>     id      name  type   class released
#> 1: T01    SupCar   toy vehicle      yes
#> 2: M01     JeepX model vehicle      yes
#> 3: M02 AircraftX model vehicle      yes
#> 4: M03    Runner model  people      yes
```

方括号内的第1个参数是行筛选器，第2个则对筛选后的数据进行适当的计算。

例如提取列：

```
product_info[released == "yes", id]
#> [1] "T01" "M01" "M02" "M03"
```

在这里使用`"id"`结果不同，返回的必然是个data.table。

```
product_info[released == "yes", "id"]
#>     id
#> 1: T01
#> 2: M01
#> 3: M02
#> 4: M03
```

第二个参数可以是表达式，例如生成一张表，反应每种`type`和`class`组合中`released`取`yes`的数量：

```
product_info[released == "yes", table(type, class)]
#>        class
#> type    people vehicle
#>   model      1       2
#>   toy        0       1
```

**要注意，给第2个参数提供list()，结果仍然转换为data.table**：

```
product_info[released == "yes", list(id, name)]
#>     id      name
#> 1: T01    SupCar
#> 2: M01     JeepX
#> 3: M02 AircraftX
#> 4: M03    Runner
```

我们可以替换原有列，生成新的data.table：

```
product_info[, list(id, name, released = released == "yes")]
#>     id      name released
#> 1: T01    SupCar     TRUE
#> 2: T02  SupPlane    FALSE
#> 3: M01     JeepX     TRUE
#> 4: M02 AircraftX     TRUE
#> 5: M03    Runner     TRUE
#> 6: M04    Dancer    FALSE
```

还可以创建新列：

```
product_stats[, list(id, material, size, weight, density = size/weight)]
#>     id material size weight density
#> 1: T01    Metal  120   10.0   12.00
#> 2: T02    Metal  350   45.0    7.78
#> 3: M01 Plastics   50     NA      NA
#> 4: M02 Plastics   85    3.0   28.33
#> 5: M03     Wood   15     NA      NA
#> 6: M04     Wood   16    0.6   26.67
```

**为了简化，data.table使用.()作为list()的缩写，这两者等价**：

```
product_info[, .(id, name, type, class)]
#>     id      name  type   class
#> 1: T01    SupCar   toy vehicle
#> 2: T02  SupPlane   toy vehicle
#> 3: M01     JeepX model vehicle
#> 4: M02 AircraftX model vehicle
#> 5: M03    Runner model  people
#> 6: M04    Dancer model  people

product_info[released == "yes", .(id, name)]
#>     id      name
#> 1: T01    SupCar
#> 2: M01     JeepX
#> 3: M02 AircraftX
#> 4: M03    Runner
```

提供排序索引可以对记录排序：

```
product_stats[order(size, decreasing = TRUE)]
#>     id material size weight
#> 1: T02    Metal  350   45.0
#> 2: T01    Metal  120   10.0
#> 3: M02 Plastics   85    3.0
#> 4: M01 Plastics   50     NA
#> 5: M04     Wood   16    0.6
#> 6: M03     Wood   15     NA
```

**前面都是在构建子集后，又创建新的data.table**。这样挺麻烦的，因此`data.table`包提供了对列进行原地赋值的符号`:=`，例如`product_stats`开始是这样的：

```
product_stats
#>     id material size weight
#> 1: T01    Metal  120   10.0
#> 2: T02    Metal  350   45.0
#> 3: M01 Plastics   50     NA
#> 4: M02 Plastics   85    3.0
#> 5: M03     Wood   15     NA
#> 6: M04     Wood   16    0.6
```

使用`:=`直接在上面数据框创建新列：

```
product_stats[, density := size / weight]
```

虽然没有任何返回，但数据已经被修改了：

```
product_stats
#>     id material size weight density
#> 1: T01    Metal  120   10.0   12.00
#> 2: T02    Metal  350   45.0    7.78
#> 3: M01 Plastics   50     NA      NA
#> 4: M02 Plastics   85    3.0   28.33
#> 5: M03     Wood   15     NA      NA
#> 6: M04     Wood   16    0.6   26.67
```

使用`:=`替换已有的列：

```
product_info[, released := released == "yes"]
product_info
#>     id      name  type   class released
#> 1: T01    SupCar   toy vehicle     TRUE
#> 2: T02  SupPlane   toy vehicle    FALSE
#> 3: M01     JeepX model vehicle     TRUE
#> 4: M02 AircraftX model vehicle     TRUE
#> 5: M03    Runner model  people     TRUE
#> 6: M04    Dancer model  people    FALSE
```

### 使用键获取值

**索引支持**是data.table另一个独特功能，即我们可以创建键（key），使用键获取记录及其高效。

例如，使用`setkey()`将`id`设置为`product_info`中的一个键：

同样的，函数无任何返回，但我们已经为原始数据设置了键，而且原来的数据看起来也没变化：

```
product_info
#>     id      name  type   class released
#> 1: M01     JeepX model vehicle     TRUE
#> 2: M02 AircraftX model vehicle     TRUE
#> 3: M03    Runner model  people     TRUE
#> 4: M04    Dancer model  people    FALSE
#> 5: T01    SupCar   toy vehicle     TRUE
#> 6: T02  SupPlane   toy vehicle    FALSE
```

但键已生成：

```
key(product_info)
#> [1] "id"
```

现在我们可以用它来获取数据了，比如提供一个id值：

```
product_info["M01"]
#>     id  name  type   class released
#> 1: M01 JeepX model vehicle     TRUE
```

也可以使用`setkeyv()`来设置键，但它只接受字符向量：

```
setkeyv(product_stats, "id")
```

**当key是一个动态变化的向量时，这个函数会非常好用**。

```
product_stats["M02"]
#>     id material size weight density
#> 1: M02 Plastics   85      3    28.3
```

如果两个表格有相同的键，我们可以轻松把他们连接到一起：

```
product_info[product_stats]
#>     id      name  type   class released material size weight density
#> 1: M01     JeepX model vehicle     TRUE Plastics   50     NA      NA
#> 2: M02 AircraftX model vehicle     TRUE Plastics   85    3.0   28.33
#> 3: M03    Runner model  people     TRUE     Wood   15     NA      NA
#> 4: M04    Dancer model  people    FALSE     Wood   16    0.6   26.67
#> 5: T01    SupCar   toy vehicle     TRUE    Metal  120   10.0   12.00
#> 6: T02  SupPlane   toy vehicle    FALSE    Metal  350   45.0    7.78
```

**data.table的键可以不止一个**。例如使用`id`和`date`定位`toy_tests`中的记录：

```
setkey(toy_tests, id, date)
```

现在提供key中的两个元素就可以获取记录了

```
toy_tests[.("T01", 20160201)]
#>     id     date sample quality durability
#> 1: T01 20160201    100       9          9
```

如果提供第一个元素，会返回匹配的多个值：

```
toy_tests["T01"]
#>     id     date sample quality durability
#> 1: T01 20160201    100       9          9
#> 2: T01 20160302    150      10          9
#> 3: T01 20160405    180       9         10
#> 4: T01 20160502    140       9          9
```

key不能错序，因此不能单独提供第2个元素以及反序排列。

```
toy_tests[20160201]
#>      id date sample quality durability
#> 1: <NA>   NA     NA      NA         NA

toy_tests[.(20160202,"T01")]
#> Error in bmerge(i, x, leftcols, rightcols, io, xo, roll, rollends, nomatch, : x.'id' is a character column being joined to i.'V1' which is type 'double'. Character columns must join to factor or character columns.
```

### 对数据进行分组汇总

`by`是data.table中另一个重要参数（即方括号内的第3个参数），它可以将数据按照`by`值进行分组，并对分组计算第2个参数。

接下来，我们学习如何通过by以简便的方式实现数据的分组汇总。

最简单的用法是计算每组的记录条数：

```
product_info[, .N, by = released]
#>    released N
#> 1:     TRUE 4
#> 2:    FALSE 2
```

分组的变量可以不止一个，例如由`type`和`class`确定一个分组：

```
product_info[, .N, by = .(type, class)]
#>     type   class N
#> 1: model vehicle 2
#> 2: model  people 2
#> 3:   toy vehicle 2
```

可以对每个分组进行统计计算，这里计算防水和非防水产品的质量得分均值：

```
product_tests[, mean(quality, na.rm = TRUE), by = .(waterproof)]
#>    waterproof    V1
#> 1:         no 10.00
#> 2:        yes  5.75
```

可以看到结果存储在V1列中，我们可以手动指定列名：

```
product_tests[, .(mean_quality = mean(quality, na.rm = TRUE)), by = .(waterproof)]
#>    waterproof mean_quality
#> 1:         no        10.00
#> 2:        yes         5.75
```

注意操作需要�放在`list`中进行（`.()`）。

我们可以将多个\[\]按顺序连接起来，形成工作流（类似管道`%>%`）。

下面的例子中，首先使用通用键id将product\_info和product\_tests连接起来，然后筛选已发布的产品，再按type和class进行分组，最后计算每组的quality和durability的均值。

```
type_class_test0 = product_info[product_tests][released == TRUE,
                                               .(mean_quality = mean(quality, na.rm=TRUE),
                                                 mean_durability = mean(durability, na.rm=TRUE)),
                                               by = .(type, class)]

type_class_test0
#>     type   class mean_quality mean_durability
#> 1:   toy vehicle          NaN            10.0
#> 2: model vehicle            6             4.5
#> 3: model  people            5             NaN
```

在返回的data.table中，by所对应的组合中的值是唯一的，虽然实现了目标，但结果中没有设置键：

```
key(type_class_test0)
#> NULL
```

**这种情况下，我们可以使用keyby来确保结果的data.table自动将keyby对应的分组向量设置为键**。一般data.table会保持原来的顺序返回，有时候我们想要设定排序，keyby也可以实现，所以是一举两得：

```
type_class_test = product_info[product_tests][released == TRUE, 
                                              .(mean_quality = mean(quality, na.rm = TRUE),
                                                mean_durability = mean(durability, na.rm = TRUE)),
                                              keyby = .(type, class)]
type_class_test
#>     type   class mean_quality mean_durability
#> 1: model  people            5             NaN
#> 2: model vehicle            6             4.5
#> 3:   toy vehicle          NaN            10.0
key(type_class_test)
#> [1] "type"  "class"
```

下面可以直接用键来获取值：

```
type_class_test[.("model", "vehicle"), mean_quality]
#> [1] 6
```

**对大数据集使用键进行搜索，能够比迭代使用逻辑比较快得多，因为键搜索利用了二进制搜索，而迭代在不必要的计算上浪费了时间**。

下面举例说明，首先创建有1000万行的数据，其中一列是索引列id，其他两列是随机数：

```
n = 10000000
test1 = data.frame(id = 1:n, x = rnorm(n), y = rnorm(n))
```

现在查找id为876543的行，看要花多少时间：

```
system.time(row <- test1[test1$id == 876543, ])
#>  用户  系统  流逝 
#> 0.132 0.018 0.150
```

作为对比，我们使用`data.table`来完成这个任务，使用`setDT()`将数据框转换为`data.table`，该函数可以原地转换，不需要复制，并可以设定键。

```
setDT(test1, key = "id")
class(test1)
#> [1] "data.table" "data.frame"
```

现在我们搜索相同的元素：

```
system.time(row <- test1[.(876543)])
#>  用户  系统  流逝 
#> 0.001 0.000 0.000
```

结果一致，但data.table用的时间要少得多。

### 重塑data.table

data.table扩展包为data.table对象提供了更强更快得`dcast()`和`melt()`函数。

例如将toy\_tests的每个产品质量得分按照年和月进行对齐

```
toy_tests[, ym := substr(date, 1, 6)]
toy_quality = dcast(toy_tests, ym ~ id, value.var = "quality")
toy_quality
#>        ym T01 T02
#> 1: 201602   9   7
#> 2: 201603  10   8
#> 3: 201604   9   9
#> 4: 201605   9  10
```

`data.table::dcast()`提供了更强大的多变量支持：

```
toy_tests2 = data.table::dcast(toy_tests, ym ~ id, value.var = c("quality", "durability"))
toy_tests2
#>        ym quality_T01 quality_T02 durability_T01 durability_T02
#> 1: 201602           9           7              9              9
#> 2: 201603          10           8              9              8
#> 3: 201604           9           9             10              8
#> 4: 201605           9          10              9              9
```

看到没，data.table可以自动将id值与质量分类连接起来。

此时`ym`是键：

```
key(toy_tests2)
#> [1] "ym"
```

我们可以利用它提取数据：

```
toy_tests2["201602"]
#>        ym quality_T01 quality_T02 durability_T01 durability_T02
#> 1: 201602           9           7              9              9
```

### 使用原地设置函数

我们知道R存在复制修改机制，这在进行大数据计算时开销很大，`data.table`提供了一系列支持语义的`set`函数，它们可以原地修改data.table，因此避免不必要的复制。

仍以`product_stats`为例，我们可以使用`setDF()`函数不要任何复制就可以将data.table变成data.frame。

```
product_stats
#>     id material size weight density
#> 1: M01 Plastics   50     NA      NA
#> 2: M02 Plastics   85    3.0   28.33
#> 3: M03     Wood   15     NA      NA
#> 4: M04     Wood   16    0.6   26.67
#> 5: T01    Metal  120   10.0   12.00
#> 6: T02    Metal  350   45.0    7.78

setDF(product_stats)

class(product_stats)
#> [1] "data.frame"
```

`setDT()`可以将任意的data.frame转换为data.table，并设置键。

```
setDT(product_stats, key = "id")
class(product_stats)
#> [1] "data.table" "data.frame"
```

使用`setnames()`可以对列重命名：

```
setnames(product_stats, "size", "volume")

product_stats
#>     id material volume weight density
#> 1: M01 Plastics     50     NA      NA
#> 2: M02 Plastics     85    3.0   28.33
#> 3: M03     Wood     15     NA      NA
#> 4: M04     Wood     16    0.6   26.67
#> 5: T01    Metal    120   10.0   12.00
#> 6: T02    Metal    350   45.0    7.78
```

如果给行添加索引，使用：

```
product_stats[, i := .I]
product_stats
#>     id material volume weight density i
#> 1: M01 Plastics     50     NA      NA 1
#> 2: M02 Plastics     85    3.0   28.33 2
#> 3: M03     Wood     15     NA      NA 3
#> 4: M04     Wood     16    0.6   26.67 4
#> 5: T01    Metal    120   10.0   12.00 5
#> 6: T02    Metal    350   45.0    7.78 6
```

为方便，索引一般在第1列，所以我们要修改列的顺序：

```
setcolorder(product_stats, c("i", "id", "material", "weight", "volume", "density"))
product_stats
#>    i  id material weight volume density
#> 1: 1 M01 Plastics     NA     50      NA
#> 2: 2 M02 Plastics    3.0     85   28.33
#> 3: 3 M03     Wood     NA     15      NA
#> 4: 4 M04     Wood    0.6     16   26.67
#> 5: 5 T01    Metal   10.0    120   12.00
#> 6: 6 T02    Metal   45.0    350    7.78
```

### data.table的动态作用域

我们不仅可以直接使用列，也可以提前定义注入`.N`、`.I`和`.SD`来指代数据中的重要部分。

为演示，我们先创建新的data.table，命名为`market_data`，其中date列是连续的。

```
market_data = data.table(date = as.Date("2015-05-01") + 0:299)
head(market_data)
#>          date
#> 1: 2015-05-01
#> 2: 2015-05-02
#> 3: 2015-05-03
#> 4: 2015-05-04
#> 5: 2015-05-05
#> 6: 2015-05-06
```

向调用函数一样，我们给data.table添加数据列：

```
set.seed(123)

market_data[, `:=`(
    price = round(30 * cumprod(1 + rnorm(300, 0.001, 0.05)), 2),
    volume = rbinom(300, 5000, 0.8)
)]
```

注意这里的price和volumn都是服从正态分布的随机数：

```
head(market_data)
#>          date price volume
#> 1: 2015-05-01  29.2   4021
#> 2: 2015-05-02  28.9   4000
#> 3: 2015-05-03  31.2   4033
#> 4: 2015-05-04  31.3   4036
#> 5: 2015-05-05  31.5   3995
#> 6: 2015-05-06  34.3   3955
```

我们以图形的方式展示数据：

```
plot(price ~ date, data = market_data,
     type = "l",
     main = "Market data")
```

数据准备好后，我们看看动态作用域如何让事情变得简单。

看下时间范围：

```
market_data[, range(date)]
#> [1] "2015-05-01" "2016-02-24"
```

将数据整合缩减为月度数据：

```
monthly = market_data[,
                      .(open = price[[1]], high = max(price),
                        low = min(price), close = price[[.N]]),
                      keyby = .(year = year(date), month = month(date))]

head(monthly)
#>    year month open high  low close
#> 1: 2015     5 29.2 37.7 26.1  28.4
#> 2: 2015     6 28.1 37.6 28.1  37.2
#> 3: 2015     7 36.3 41.0 32.1  41.0
#> 4: 2015     8 41.5 50.0 30.9  30.9
#> 5: 2015     9 30.5 34.5 22.9  27.0
#> 6: 2015    10 25.7 33.2 24.6  29.3
```

计算过程为：**先根据by表达式将原始数据分割，分割后的每个部分都是原始数据的一个子集，并且原始数据和子集都是data.table。然后在每个子集data.table的语义中计算j表达式**。

下面代码没有按组聚合数据，而是画了每年的价格图：

```
oldpar = par(mfrow = c(1, 2))
market_data[, {
    plot(price ~ date, type = "l",
         main = sprintf("Market data (%d)", year))
}, by = .(year = year(date))]
par(oldpar)
```

这里我们没有为`plot()`设定data参数，图像也成功绘制，这是因为该操作是在data.table的语义中进行的。

此外,j表达式还可以用于构建模型的代码，下面是一个批量拟合线性模型的例子。这里使用`diamonds`数据集。

```
data("diamonds", package = "ggplot2")

setDT(diamonds)
head(diamonds)
#>    carat       cut color clarity depth table price    x    y    z
#> 1:  0.23     Ideal     E     SI2  61.5    55   326 3.95 3.98 2.43
#> 2:  0.21   Premium     E     SI1  59.8    61   326 3.89 3.84 2.31
#> 3:  0.23      Good     E     VS1  56.9    65   327 4.05 4.07 2.31
#> 4:  0.29   Premium     I     VS2  62.4    58   334 4.20 4.23 2.63
#> 5:  0.31      Good     J     SI2  63.3    58   335 4.34 4.35 2.75
#> 6:  0.24 Very Good     J    VVS2  62.8    57   336 3.94 3.96 2.48
```

该数据集包含超过5万条钻石信息的记录，每条记录了钻石的10个属性，现在我们队cut列中的每种切割类型都你拟合一个线性回归模型，由此观察每种切割类型中carat与depth是如何反映log(price)的信息。

```
diamonds[, {
    m = lm(log(price) ~ carat + depth)
    as.list(coef(m))
}, keyby = .(cut)]
#>          cut (Intercept) carat    depth
#> 1:      Fair        7.73  1.26 -0.01498
#> 2:      Good        7.08  1.97 -0.01460
#> 3: Very Good        6.29  2.09 -0.00289
#> 4:   Premium        5.93  1.85  0.00594
#> 5:     Ideal        8.50  2.13 -0.03808
```

**动态作用域允许我们组合使用data.table内部或外部预定义的符号**。举例，我们定义一个函数，计算market\_data中由用户定义的列的年度均值：

```
average = function(column){
    market_data[, .(average = mean(.SD[[column]])),
                by = .(year = year(date))]
}
```

这里我们使用`.SD[[x]]`提取x列的值，这跟通过名字从列表中提取成分或元素相同。

下面计算每年的平均价格：

```
average("price")
#>    year average
#> 1: 2015    32.3
#> 2: 2016    32.4
```

每年平均数量：

```
average("volume")
#>    year average
#> 1: 2015    4000
#> 2: 2016    4003
```

我们可以利用此包专门的语法创造一个列数动态变化的组合，并且组合中的列是由动态变化的名称决定的。

这里我们假设添加额外的3列数据，每一列都是原始价格加了随机噪声生成的。不用重复调用`market_date[, price1 := ...]`，而是使用`market_data[, (columns) := list(...)]`来动态设定列，其中`columns`是一个包含列名的字符向量，`list(...)`是每个列对应的值：

```
price_cols = paste0("price", 1:3)
market_data[, (price_cols) := lapply(1:3,
                                     function(i) round(price + rnorm(.N, 0, 5), 2))]
head(market_data)
#>          date price volume price1 price2 price3
#> 1: 2015-05-01  29.2   4021   30.6   27.4   33.2
#> 2: 2015-05-02  28.9   4000   29.7   20.4   36.0
#> 3: 2015-05-03  31.2   4033   34.3   26.9   27.2
#> 4: 2015-05-04  31.3   4036   29.3   29.0   28.0
#> 5: 2015-05-05  31.5   3995   36.0   32.1   34.8
#> 6: 2015-05-06  34.3   3955   30.1   31.0   35.2
```

另一方面，如果表格有很多列，并且需要对它们的子集进行一些计算，也可以用类似的语法来解决。

举例，我们现在需要对每个价格列调用`na.locf()`以去掉缺失值，先获取所有的价格列：

```
cols = colnames(market_data)

price_cols = cols[grep("^price", cols)]

price_cols
#> [1] "price"  "price1" "price2" "price3"
```

然后我们用类似的语法，并添加一个参数`.SDcols = price_cols`，这是为了让`.SD`中的列只是我们想要的那些价格列。

```
market_data[, (price_cols) := lapply(.SD, zoo::na.locf), .SDcols =  price_cols]

head(market_data)
#>          date price volume price1 price2 price3
#> 1: 2015-05-01  29.2   4021   30.6   27.4   33.2
#> 2: 2015-05-02  28.9   4000   29.7   20.4   36.0
#> 3: 2015-05-03  31.2   4033   34.3   26.9   27.2
#> 4: 2015-05-04  31.3   4036   29.3   29.0   28.0
#> 5: 2015-05-05  31.5   3995   36.0   32.1   34.8
#> 6: 2015-05-06  34.3   3955   30.1   31.0   35.2
```
