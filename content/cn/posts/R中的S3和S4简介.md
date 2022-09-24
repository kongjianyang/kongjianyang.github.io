---
title: R中的S3和S4简介
author: Liang
date: '2018-11-24'
slug: R中的S3和S4简介
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
R语言有四大类型系统：基础类型、S3类型、S4类型和RC类型。

R虽然被认为是一种函数式语言，但是同样支持面向对象编程，意味着R将对象作为程序的基本单元，将程序和数据封装其中，以提高软件的重用性，灵活性和扩展性。

# S3
S3是想了一种基于泛型函数的面对对象方式。泛型函数可以根据传入对象的类型决定调用哪种具体的方法。因为这样对于初学者而言更加容易理解
例如
```
result <- mean(v1)
```
要比
```
result = v1.mean()
```
更加容易理解。

S3对象是一个list并且有一个名为class的属性，举例说明创建一个foo类的对象并且用class查看他的类

```{r}
x <- 1
attr(x, "class") <- "foo"
x
```

```
[1] 1
attr(,"class")
[1] "foo"
```

```{r}
class(x)
```
```
[1] "foo"
```

S3没有正式的类型间关系的定义，一个对象可以有多个类型，表现为其class属性是一个向量


```{r}
class(x) <- c("foo", "bar")
class(x)
```
```
[1] "foo" "bar"
```
方法分派是指由泛型函数 (generic function) 来决定对某个对象使用的方法. 所有泛型函数都有类似的形式: 一个广义的函数名, 并调用 UseMethod() 来决定为对象分派哪个方法. 这也使得泛型函数的形式都很简单, 比如 mean()
```{r}
mean
```
```
function (x, ...) 
UseMethod("mean")
<bytecode: 0x103792920>
<environment: namespace:base>
```

UseMethod() 会根据对象的 class 属性来决定分派什么方法,所以方法必须以 generic.class 的方式命名才能被 UseMethod() 找到, 比如:

```
mean.numeric <- function(x, ...) sum(x)/length(x)
mean.data.frame <- function(x, ...) sapply(x, mean, ...)
mean.matrix <- function(x, ...) apply(x, 2, mean)
```
如果 class 属性是一个向量 c(”foo”, ”bar”), 则优先寻找mean.foo, 然后 mean.bar, 最后 mean.default.


```{r}
bar <- function(x) UseMethod("bar", x)
bar.default <- function(x) "default"
bar.y <- function(x) "y"
bar.z <- function(x) "z"
foo <- structure(1, class = "nonsense")
bar(foo)
```
```
[1] "default"
```
```{r}
foo <- structure(1, class = c("y", "z"))
bar(foo)
```

```
[1] "y"
```

由于 class 属性可以是向量, 所以 S3 中的继承关系自然地表现为 class 属性的前一个分量是后一个的子类.NextMethod() 函数可以使得一系列的方法被依次应用于对象上.
```{r}
bar <- function(x) UseMethod("bar", x)
bar.son <- function(x) c("I am son.", NextMethod())
bar.father <- function(x) c("I am father.")
foo <- structure(1, class = c("son", "father"))
bar(foo)
```
```
[1] "I am son."    "I am father."
```

# S4
我们可以使用 setClass() 函数来定义新的 S4 类型. 如新建一个类来表示会议的参与者 .representation 参数用于定义类的属性 (slot) 及其类型.


```{r}
setClass(Class = "Person", representation(name = "character", age = "numeric"))
```
S4 有比 S3 更为严格的继承关系, 用 contains 参数表示. 比如新建一个类表示会议的演讲者, 则演讲者类是参与者类的子类.子类自动继承父类所有的属性, 并可以定义新的属性.

```{r}
setClass(Class = "Reporter", representation(title = "character"), contains = "Person")
```

用 new() 函数新建某个类的对象. 此时 S4 会检查每个属性初值的类型是否符合定义类时所给的类型, 如果不符则不能创建对象.

```{r}
yuchen <- new("Reporter", name = "yuchen", age = 22, title = "R and OOP")
yuchen
```
```
An object of class "Reporter"
Slot "title":
[1] "R and OOP"

Slot "name":
[1] "yuchen"

Slot "age":
[1] 22
```

在 S3 中我们通常使用 $ 来访问一个对象的属性, 但是在 S4对象中我们使用@。或者当你已知属性名的时候, 可以使用 slot() 来查看.

```{r}
yuchen@name
slot(yuchen, "name")
```
```
[1] "yuchen"
[1] "yuchen"
```
编写泛型函数的方式和 S3 类似, 但是使用setGeneric() 函数. 该函数的第二个参数是一个定义了所有需要的参数的函数,且必须调用 standardGeneric() 函数.

```{r}
setGeneric("prepare", function(object) {
standardGeneric("prepare")
})
```

```
[1] "prepare"
```
编写方法的定义使用 setMethod() 函数, 并用 signature() 函数定义其所面向的类型.

```{r}
setMethod("prepare", signature(object = "Person"), function(object) {
cat("Got Materials.\n")
})
```
```
[1] "prepare"
```

```{r}
prepare(new("Person"))
```

```
Got Materials.
```

 is() 函数可以用来查看对象的类型, 而 getSlots() 可以查看类所有属性的定义.
showMethods() 用来查看泛型函数已经定义的方法.
 Bioconductor 和 Matrix 包都基于 S4 对象且遵循良好的编程方式, 可以作为进一步研究的材料.

内容参考知乎用户[王雨晨的回答](https://www.zhihu.com/people/wangyuchen/activities)。
