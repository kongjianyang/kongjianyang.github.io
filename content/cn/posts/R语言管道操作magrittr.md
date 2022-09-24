---
title: "R语言管道操作Magritte"
date: 2019-04-27T13:42:27-05:00
author: KJY
slug: Magritte
draft: false
toc: true
categories:
  - test
tags:
  - article

---



主要参考文章：

[R语言中管道操作符 %>%, %T>%, %$% 和 %<>% - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/339107871)

[The Four Pipes of magrittr | R-bloggers](https://www.r-bloggers.com/2021/09/the-four-pipes-of-magrittr/)

`magrittr`包有两个主要目标:

- 第一是减少代码开发时间，提高代码的可读性和维护性
- 第二是让你的代码更短

- lhs %>% rhs # pipe syntax for `rhs(lhs)`
- lhs %>% rhs(a = 1) # pipe syntax for `rhs(lhs, a = 1)`
- lhs %>% rhs(a = 1, b = .) # pipe syntax for `rhs(a = 1, b = lhs)`
- lhs %<>% rhs # pipe syntax for `lhs <- rhs(lhs)`
- lhs %$% rhs(a) # pipe syntax for `with(lhs, rhs(lhs$a))`
- lhs %T>% rhs # pipe syntax for `{ rhs(lhs); lhs }`

一、**%>%** （向右操作符，forward-pipe operator）

**%>%** （向右操作符，forward-pipe operator）是最常用的一种操作符，就是把左侧准备的数据或表达式，传递给右侧的函数调用或表达式进行运行，可以连续操作就像一个链条一样。现实原理如下图所示，使用%>%把左侧的程序的数据集A传递右侧程序的B函数，B函数的结果数据集再向右侧传递给C函数，最后完成数据计算。

![](https://pic3.zhimg.com/v2-d9336bd3046ca1cf069d6665ff826bea_b.jpg)

```
mtcars %>% filter(mpg > 30) %>% select(mpg:wt)
mpg cyl disp hp drat wt
Fiat 128 32.4 4 78.7 66 4.08 2.200
Honda Civic 30.4 4 75.7 52 4.93 1.615
Toyota Corolla 33.9 4 71.1 65 4.22 1.835
Lotus Europa 30.4 4 95.1 113 3.77 1.513
```

lambda函数也可以使用

```
## return 10 rows if there are more than 10, 5 if there are 6-10 rows, and
## everything otherwise
library(tidyverse)
mtcars %>% filter(mpg > 20) %>% select(mpg:wt) %>% {
  print(nrow(.))
  if (nrow(.) > 10)
    head(., 10)
  else if (nrow(.) >5)
    head(., 5)
  else
    .
}
[1] 14
mpg cyl disp hp drat wt
Mazda RX4 21.0 6 160.0 110 3.90 2.620
Mazda RX4 Wag 21.0 6 160.0 110 3.90 2.875
Datsun 710 22.8 4 108.0 93 3.85 2.320
Hornet 4 Drive 21.4 6 258.0 110 3.08 3.215
Merc 240D 24.4 4 146.7 62 3.69 3.190
Merc 230 22.8 4 140.8 95 3.92 3.150
Fiat 128 32.4 4 78.7 66 4.08 2.200
Honda Civic 30.4 4 75.7 52 4.93 1.615
Toyota Corolla 33.9 4 71.1 65 4.22 1.835
Toyota Corona 21.5 4 120.1 97 3.70 2.465
```

二、**%T>%**（向左操作符，tee operator)

%T>%（向左操作符，tee operator)，其实功能和 %>% 基本是一样的，只不过它是把左边的值做为传递的值，而不是这一步计算得到的值。这种情况的使用场景也是很多的，比如，你在数据处理的中间过程，需要打印输出或图片输出，这时整个过程就会被中断，用向左操作符，就可以解决这样的问题。

**%T>%**现实原理如下图所示，使用%T>%把左侧的程序的数据集A传递右侧程序的B函数，B函数的结果数据集不再向右侧传递，而是把B左侧的A数据集再次向右传递给C函数，最后完成数据计算。(也就是跳过了中间的B，中间的B不参与后续的结果)

![](https://pic4.zhimg.com/v2-51b0a15a9758bfdd145edfc398aaacc7_b.jpg)

```
library(magrittr)
iris %T>% plot() %>% group_by(Species) %>% summarize(MaxSepalLength=max(Sepal.Length), MinSepalLength = min(Sepal.Length))
```

三、 **%$%** (解释操作符，exposition pipe-operator)

> The exposition pipe operator `%$%` allows a user to avoid breaking a pipeline when needing to refer to column names.
>
> The exposition pipe works like a pipe-able version of the base R `with()` functions, and the same left-hand side objects are accepted as inputs.

**%$%** 的作用是把左侧数据的属性名传给右侧，让右侧的调用函数直接通过名字，就可以获取左侧的数据。比如，我们获得一个data.frame类型的数据集，通过使用 %$%，在右侧的函数中可以直接使用列名操作数据。

现实原理如下图所示，使用%$%把左侧的程序的数据集A传递右侧程序的B函数，同时传递数据集A的属性名，作为B函数的内部变量方便对A数据集进行处理，最后完成数据计算。

![](https://pic3.zhimg.com/v2-19f9040c3fc128de05b2d89bf2cb2f6e_b.jpg)

下面定义一个10行3列的data.frame，列名分别为x,y,z，获取x列大于5的数据集。使用 %$% 把列名x直接传到右侧进行判断。这里.代表左侧的完整数据对象。一行代码就实现了需求，而且这里不需要显示的定义中间变量。

```
set.seed(123)
data.frame(x=1:10,y=rnorm(10),z=letters[1:10]) %$% .[x>5,]
```

![](https://pic4.zhimg.com/v2-9d92388178b30b1af22b993c756377b3_b.jpg)

注意这样是不行的

```
data.frame(x=1:10,y=rnorm(10),z=letters[1:10]) %>% .[x>5,]
```

如果不使用%$%，我们通常的代码写法为：

```
library(magrittr)
set.seed(123)
df<-data.frame(x=1:10,y=rnorm(10),z=letters[1:10])
df[df$x>5,]
```

这样也行

```
a <- data.frame(x=1:10,y=rnorm(10),z=letters[1:10]) 
a %>% with(a, x>5)
```

还有一个例子

```
 iris %$% plot(Sepal.Length, Sepal.Width)
```

四、**%<>%** (复合赋值操作符，compound assignment pipe-operator)

> This one is fairly simple: it just reassigns the result of the pipe chain to the starting variable.

%<>%复合赋值操作符， 功能与 %>% 基本是一样的，多了一项额外的操作，就是把结果写回到最左侧的对象（覆盖原来的值）。比如，我们需要对一个数据集进行排序，那么需要获得排序的结果，用%<>%就是非常方便的。

现实原理如下图所示，使用%<>%把左侧的程序的数据集A传递右侧程序的B函数，B函数的结果数据集再向右侧传递给C函数，C函数结果的数据集再重新赋值给A，完成整个过程。

![](https://pic2.zhimg.com/v2-b486611d54e825720a868679436f2831_b.jpg)

>  Note that this only seems to work for sure it’s the first operator in the sequence.

```
x <- c(1,2,3,4)
x %<>% sum()
x
```

