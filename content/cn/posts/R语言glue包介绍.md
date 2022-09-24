---
title: "R语言glue包介绍"
date: 2021-04-22T14:42:27-05:00
author: KJY
slug: glue
draft: false
toc: true
categories:
  -glue
tags:
  - article
---



`glue` 提供了轻巧、快速和无依赖的可解释字符串，`glue` 通过将 `R` 表达式嵌入到花括号中，然后对其求值并将其插入字符串中。

glue包可用于自定义变量，然后通过传参的方式，对字符串部分内容进行自适应修改。

例如：可将日期赋值为：date = as.Date("2019-12-05")，然后通过字符串拼接的形式，实现文件名称自动更新，glue("The day is {date}."。

## **安装**

```
install.packages("glue")
# or
install.packages("glue")
# install.packages("devtools")
devtools::install_github("tidyverse/glue")
```

## **使用**

### **1\. 导入**

### **2\. 简单使用**

将变量直接传递到字符串中

```
> name <- "Fred"
> glue('My name is {name}.')
My name is Fred.
```

通过将变量名放置在一对花括号之间，`glue` 会将变量名替换为相应的值

字符串可以写成多行的形式，最后会自动将这些行连接起来

```
> name <- "Fred"
> age <- 50
> anniversary <- as.Date("1991-10-12")
> glue('My name is {name},',
+      ' my age next year is {age + 1},',
+      ' my anniversary is {format(anniversary, "%A, %B %d, %Y")}.')
My name is Fred, my age next year is 51, my anniversary is 星期六, 十月 12, 1991.
```

在 `glue` 中使用命名参数来指定临时变量

```
> glue('My name is {name},',
+      ' my age next year is {age + 1},',
+      ' my anniversary is {format(anniversary, "%A, %B %d, %Y")}.',
+      name = "Joe",
+      age = 40,
+      anniversary = as.Date("2001-10-12"))
My name is Joe, my age next year is 41, my anniversary is 星期五, 十月 12, 2001.
```

### **3\. glue\_data 搭配管道符**

`glue_data()` 搭配管道符非常有用

```
> head(mtcars)
                   mpg cyl disp  hp drat    wt  qsec vs am gear carb
Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1

> head(mtcars) %>% glue_data("{rownames(.)} has {hp} hp")
Mazda RX4 has 110 hp
Mazda RX4 Wag has 110 hp
Datsun 710 has 93 hp
Hornet 4 Drive has 110 hp
Hornet Sportabout has 175 hp
Valiant has 105 hp
```

也可以搭配 `dplyr` 使用

```
> head(iris) %>%
+     mutate(description = glue("This {Species} has a petal length of {Petal.Length}"))
  Sepal.Length Sepal.Width Petal.Length Petal.Width Species                           description
1          5.1         3.5          1.4         0.2  setosa This setosa has a petal length of 1.4
2          4.9         3.0          1.4         0.2  setosa This setosa has a petal length of 1.4
3          4.7         3.2          1.3         0.2  setosa This setosa has a petal length of 1.3
4          4.6         3.1          1.5         0.2  setosa This setosa has a petal length of 1.5
5          5.0         3.6          1.4         0.2  setosa This setosa has a petal length of 1.4
6          5.4         3.9          1.7         0.4  setosa This setosa has a petal length of 1.7
```

### **4\. 字符串**

前导空格和第一行以及最后一行的换行符会自动被修剪

```
> glue("
+     A formatted string
+     Can have multiple lines
+       with additional indention preserved
+     ")
A formatted string
Can have multiple lines
  with additional indention preserved
```

可以在首行或尾行多添加一个换行符来实现空行

```
> glue("
+ 
+   leading or trailing newlines can be added explicitly
+ 
+   ")

leading or trailing newlines can be added explicitly

```

在行尾使用 `\\` 可以将两行合并

```
> glue("
+     A formatted string \\
+     can also be on a \\
+     single line
+     ")
A formatted string can also be on a single line
```

如果要字符串中使用花括号，需要使用双花括号

```
> name <- "Fred"
> glue("My name is {name}, not {{name}}.")
My name is Fred, not {name}.
```

双花括号需要连用

可以使用 `+` 连接字符串

```
> x <- 1
> y <- 3
> glue("x + y") + " = {x + y}"
x + y = 4
```

### **5\. 指定分隔符**

`glue` 默认将花括号之间的字符作为变量名或者表达式，我们可以通过设置 `.open` 和 .`close` 参数来指定分隔符

```
> one <- "1"
> glue("The value of $e^{2\\pi i}$ is $<<one>>$.", .open = "<<", .close = ">>")
The value of $e^{2\pi i}$ is $1$.
```

### **6\. SQL 语句**

`glue` 还提供了 `glue_sql` 函数，用于格式化 `SQL` 语句，例如

```
> con <- DBI::dbConnect(RSQLite::SQLite(), ":memory:")
> colnames(iris) <- gsub("[.]", "_", tolower(colnames(iris)))
> DBI::dbWriteTable(con, "iris", iris)
> var <- "sepal_width"
> tbl <- "iris"
> num <- 2
> val <- "setosa"
> glue_sql("
+   SELECT {`var`}
+   FROM {`tbl`}
+   WHERE {`tbl`}.sepal_length > {num}
+     AND {`tbl`}.species = {val}
+   ", .con = con)
<SQL> SELECT `sepal_width`
FROM `iris`
WHERE `iris`.sepal_length > 2
  AND `iris`.species = 'setosa'
```

还可以配合 `DBI::dbBind()` 进行参数化查询

```
> sql <- glue_sql("
+     SELECT {`var`}
+     FROM {`tbl`}
+     WHERE {`tbl`}.sepal_length > ?
+   ", .con = con)
> query <- DBI::dbSendQuery(con, sql)
> DBI::dbBind(query, list(num))
> DBI::dbFetch(query, n = 4)
  sepal_width
1         3.5
2         3.0
3         3.2
4         3.1
```

还支持更复杂的查询，比例嵌套子查询

```
> sub_query <- glue_sql("
+   SELECT *
+   FROM {`tbl`}
+   ", .con = con)
> 
> glue_sql("
+   SELECT s.{`var`}
+   FROM ({sub_query}) AS s
+   ", .con = con)
<SQL> SELECT s.`sepal_width`
FROM (SELECT *
FROM `iris`) AS s
```

还可以在 `IN` 声明之后添加 `*` 来接受多个值

```
> glue_sql("SELECT * FROM {`tbl`} WHERE sepal_length IN ({vals*})",
+          vals = 1, .con = con)
<SQL> SELECT * FROM `iris` WHERE sepal_length IN (1)
> glue_sql("SELECT * FROM {`tbl`} WHERE sepal_length IN ({vals*})",
+          vals = 1:5, .con = con)
<SQL> SELECT * FROM `iris` WHERE sepal_length IN (1, 2, 3, 4, 5)
> glue_sql("SELECT * FROM {`tbl`} WHERE species IN ({vals*})",
+          vals = "setosa", .con = con)
<SQL> SELECT * FROM `iris` WHERE species IN ('setosa')
> glue_sql("SELECT * FROM {`tbl`} WHERE species IN ({vals*})",
+          vals = c("setosa", "versicolor"), .con = con)
<SQL> SELECT * FROM `iris` WHERE species IN ('setosa', 'versicolor')
```

### **7\. 字符串向量的折叠**

可以使用 `glue_collapse` 将任意长度的字符串向量折叠为长度为 1 的字符串向量

```
glue_collapse(x, sep = "", width = Inf, last = "")
```

-   `x` ：字符串向量  
    
-   `sep` ：用来分隔向量中元素的字符串  
    
-   `width` ：折叠之后加上 `...` 之后的最大长度，  
    
-   `last` ： 如果 `x` 至少有 `2` 个元素，则用于分隔最后两个元素的字符串  
    

```
> glue_collapse(glue("{1:10}"))
12345678910
> glue_collapse(glue("{1:10}"), width = 7)
1234...
> glue_collapse(1:4, ", ", last = " and ")
1, 2, 3 and 4
```

### **8\. 单个元素的引用**

下面三个对单个元素引用函数可以搭配 `glue_collapse` 使用

-   `single_quote(x)`：用单引号包裹字符串元素
-   `double_quote(x)`：用双引号包裹字符串元素
-   `backtick(x)`：用反引号包裹字符串元素

```
> glue('Values of x: {glue_collapse(backtick(x), sep = ", ", last = " and ")}')
Values of x: `1`, `2`, `3`, `4` and `5`
> glue('Values of x: {glue_collapse(single_quote(x), sep = ", ", last = " and ")}')
Values of x: '1', '2', '3', '4' and '5'
> glue('Values of x: {glue_collapse(double_quote(x), sep = ", ", last = " and ")}')
Values of x: "1", "2", "3", "4" and "5"
```

### **9\. 为输出着色**

`glue` 可以搭配 `crayon` 包定义的一些用于终端输出着色的函数，来为我们的输出文本着色

先导入 `crayon`

`glue` 提供了 `glue_col()` 和 `glue_data_col()` 两个着色函数

![](https://pic1.zhimg.com/v2-e96cfd2df07422aaf3c26bb8d80b4b88_b.jpg)

我们可以设置白底黑字

```
> white_on_grey <- bgBlack $ white
> glue_col("{white_on_grey
+     Roses are {red {colors()[[552]]}}
+     Violets are {blue {colors()[[26]]}}
+     `glue_col()` can show {red c}{yellow o}{green l}{cyan o}{blue r}{magenta s}
+     and {bold bold} and {underline underline} too!
+     }")
```

