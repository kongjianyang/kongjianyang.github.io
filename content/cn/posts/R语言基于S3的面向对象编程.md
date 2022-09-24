---
title: "R语言基于S3的面向对象编程"
date: 2022-03-29T14:32:27-05:00
author: KJY
slug: R_S3
draft: false
toc: true
categories:
  - bioinfo
tags:
  - article
---



参考这篇文章：

[R语言面向对象编程 (dataxujing.github.io)](https://dataxujing.github.io/R_oop/S3.html#s3)



## S3对象的介绍

在R语言中，基于S3对象的面向对象编程，是一种基于泛型函数的实现方式。**泛型函数**是一种特殊的函数，根据传入对象的类型决定调用那个具体的方法。基于S3对象实现面向对象编程，不同其他语言的面型对象编程，是一种动态函数调用的模拟实现。S3对象被广泛应用于R的早期的开发包中。

**R的S3系统有三个组成部分:属性(attribute)(尤其是class属性)、泛型函数(genericfunction)和方法(method)**

## 创建S3对象

注意：本文会用到pryr,为了方便我们检查对象的类型，引入pryr包作为辅助工具。

```
library(pryr)

#通过变量创建S3对象
x <- 1
attr(x,'class') <- 'foo'
x
```

```
## [1] 1
## attr(,"class")
## [1] "foo"
```

```
## [1] "foo"
```

```
## [1] "foo"
```

```
#用pryr包的otype函数,检查x的类型
otype(x)
```

```
## [1] "S3"
```

通过structure()函数创建S3对象

```
y <- structure(2,class="foo")

y
```

```
## [1] 2
## attr(,"class")
## [1] "foo"
```

```
## [1] "foo"
```

```
## [1] "foo"
```

```
## [1] "S3"
```

创建一个多类型的S3对象，S3独享没有明确结构关系，一个S3对象可以有多个类型，S3对象的class属性可以是一个向量，包括多种类型

```
x <- 1
attr(x,"class") <- c("foo","bar") # 给了x对象两个class属性
class(x)
```

```
## [1] "foo" "bar"
```

```
## [1] "S3"
```

如果分配至少一个class属性，就是S3对象，如果没有class属性，就是base对象。

## 泛型函数和方法调用

对于S3对象的使用，通常用UseMethod()函数来定义一个泛型函数的名称，通过传入参数的class属性，来确定方法调用。

**R的S3系统有三个组成部分:属性(attribute)(尤其是class属性)、泛型函数(genericfunction)和方法(method)**

由泛型函数、方法和基于类的分派方式所构成的系统就是R的S3系统。之所以叫作S3是由于它起源于S语言的第三个版本,语言S-PLUS是R语言的前身。许多常见的R函数都是S3泛型函数,它们可以支持多种不同的类方法函数。比如说,summary和head就会调用UseMethod函数以识别对象的类属性。

每一个S3方法的名称都包含两个部分。前一部分指明该方法对应的函数,后一部分则指明类属性（attitubute）。这两个部分的名称用英文句点.分隔。

可以用attributes函数查看一个对象的属性。

定义一个teacher的泛型函数

-   用UseMethod()定义teacher泛型函数
    
-   用teacher.xxx的语法格式定义teacher对象的行为（类属性）
    
-   其中teacher.default是默认行为
    

```
# 用UseMethod()定义teacher泛型函数
teacher <- function(x,...) UseMethod("teacher") # 这时teacher也变成了一个对象
# 用pryr包中ftype()函数，检查teacher类型
ftype(teacher)
[1] "s3" "generic"

# 定义teacher内部函数, 都是teacher的属性
teacher.lecture <- function(x,...) print("讲课")
teacher.assignment <- function(x,...) print("布置作业")
teacher.correcting <- function(x,...) print("批改作业")
teacher.default <- function(x,...) print("你不是teacher")
teacher.character <- function(x, ...) print("请先定义")
```

警告：因为点号.是S3实现泛型函数的方法，为了防止歧义，应避免在普通变量名中使用.号。普通变量命名推荐使用 para_name, paraName，类名使用 ParaName。

方法调用通过传入参数的class属性，来确定不同方法调用

-   定义一个变量a，并设置a的class属性为lecture
    
-   把变量a传入到teacher泛型函数中
    
-   函数teacher.lecture()函数的行为被调用
    

```
a <- "teacher" # 这时a是个字符串
teacher(a)
# 给老师变量设置行为
attr(a,"class") <- 'lecture' # 给a一个类属性 lecture
# 执行老师的行为
teacher(a)
[1] “讲课”


attributes(a)

# $class
# [1] "lecture"
```

当然我们可以直接调用teacher中定义的行为，如果这样做就失去了面向对象封装的意义

```
teacher.lecture()
[1] "讲课"
teacher.lecture(a)
[1] "讲课"
teacher()
[1] "你不是teacher"
```

另外一个例子



```
## 第一步：定义一个泛型函数，这个函数的函数体只有一个固定的语句
doit = function(...) UseMethod("doit")

## 第二步：设置针对特定CLASS的动作函数
doit.character = function(...) {
    cat("With STRING class attribute\n")
}
doit.integer = function(...) {
    cat("With INTEGER class attribute\n")
}
doit.God = function(...) {
    cat("With God class attribute\n")
}
### 第三步：设置一个默认的动作函数
doit.default = function(...) {
    cat("UNKNOWN class attribute\n")
}


##上面三个步骤就完成了doit泛型函数的设置。看看效果吧：
a = "ABCDE"

doit(a) # 这里a本来是string
## With STRING class attribute

attr(a, "class") = "integer"
class(a) #[1] "integer"
doit(a)
## With INTEGER class attribute

attr(a, "class") = "God"
doit(a)
## With God class attribute

a = as.factor(a)
doit(a)
## UNKNOWN class attribute
```

这里面还有一个问题：针对特定类型的动作函数并没有用于识别数据类型的代码，函数调用的形式都是一样的，doit函数怎么知道该执行那个操作？关键就在于UseMethod这个函数。这个函数只能在函数体内使用，它可以有两个参数：

**UseMethod(generic, object)**

generic 是泛型函数的名称（字符串）， object 是用于确定动作函数的对象，如果缺省将使用泛型函数的第一个参数，UseMethod取其CLASS属性。如果要用其他参数进行类型判断，只需修改泛型函数。下面修改后的泛型函数使用第二个参数进行动作函数选择：

```
doit("abc", 1:10)
## With STRING class attribute

doit(1:10, "abc")
## With INTEGER class attribute

doit = function(...) {
    xx = list(...)
    UseMethod("doit", xx[[2]])
}
# 注意下面结果与修改泛型函数前的差别
doit(1:10, "abc")
## With STRING class attribute
```



## 查看S3对象的函数

当我们使用S3队形进行面向对象封装后，可以使用methods()函数来查看S3对象中的定义的内部行为函数。

```
# 查看teacher对象
> teacher
function(x,...) Usemethod("teacher")

# 查看teacher对象的内部函数
> methods(teacher)
[1] teacher.assignment teacher.correcting teacher.default teacher.lecture

#通过methods()的generic.function参数，来匹配泛型函数名字
> methods(generic.function = predict)
[1] predict.ar* ......
```

通过methods()的class参数，来匹配类的名字

```
> methods(class=lm)
[1]add1.lm* ......
```

用getAnywhere()函数,查看所有函数

```
#查看teacher.lecture函数

>getAnywhere(teacher.lecture)

# A single object matching ‘teacher.lecture’ was found
# It was found in the following places
#   .GlobalEnv
#   registered S3 method for teacher
# with value
# 
# function(x,...) print("讲课")
```

使用getS3method()函数，也同样可以查看不可见的函数

## S3对象的继承关系

S3独享有一种非常简单的继承方式，用NextMethod()函数来实现。

定义一个node泛型函数

```
node <- function(x) UseMethod("node",x)
node.default <- function(x) "Default node"

father函数
node.father <- function(x) c("father")

son函数，通过NextMethod()函数只想father函数
node.son <- function(x) c('son',NextMethod())

#定义n1
n1 <- structure(1,class=c("father"))
# 在node函数中传入n1,执行node.father()函数
node(n1)
[1] "father"

# 定义n2，设置class属性为两个
<- structure(1,class=c("son","father"))
# 在node函数中传入n2,执行node.son()函数和node.father()函数
node(n2)
# [1] "son" "father"
```

通过对node()函数传入n2的参数，node.son()先被执行，然后通过NextMethod()函数继续执行了node.father()函数。这样其实就模拟了，子函数调用父函数的过程，实现了面向对象编程中的继承。

另外一个更详细的例子

```
doit = function(...) UseMethod("doit")
doit.character = function(...) {
    cat("With STRING class attribute\n")
    NextMethod()
}

doit.integer = function(...) {
    cat("With INTEGER class attribute\n")
    NextMethod()
}

doit.God = function(...) {
    cat("With God class attribute\n")
    NextMethod()
}

doit.default = function(...) {
    cat("UNKNOWN class attribute\n")
}

## 多CLASS属性对象
x = "abc"
class(x) = c("UNKNOWN", "integer", "character", "God")
doit(x)
# With INTEGER class attribute
# With STRING class attribute
# With God class attribute
# UNKNOWN class attribute

# 或者同样的

x = "abcd"
attr(x, "class") <- c("UNKNOWN", "integer", "character", "God")
doit(x)
# With INTEGER class attribute
# With STRING class attribute
# With God class attribute
# UNKNOWN class attribute
```

\- 循环最外层从CLASS属性向量第一个“已知”类属性开始，依次嵌套

\- default方法在循环最内层，而且不管有几个“未知”类属性，它只执行一次

\- 循环层次和“未知”类属性的位置无关

## S3对象的缺点

从上面S3对象的介绍上来看，S3对象并不是完全的面向对象实现，而是一种通过泛型函数模拟的面向对象的实现。

-   S3用起来简单，但在实际的面向对象编程的过程中，当对象关系有一定的复杂度，S3对象所表达的意义就变得不太清楚
    
-   S3封装的内部函数，可以绕过泛型函数的检查，以直接被调用
    
-   S3参数的class属性，可以被任意设置，没有预处理的检查
    
-   S3参数，只能通过调用class属性进行函数调用，其他属性则不会被class()函数执行
    
-   S3参数的class属性有多个值时，调用时会被按照程序赋值顺序来调用第一个合法的函数
    

所以，S3只是R语言面向对象的一种简单的实现。

## 与python区别



Python是面向对象的语言，类的定义很简介，一个类的属性和方法都是在一个代码块中，很容易让人理解。但是R不一样了，R的类属性和方法是分离的，需要泛型函数将他们连接起来。Python是实实在在对对象进行编程，不存在方法派送的问题，而R中的S3似乎更像是面向函数的编程。

一个python中的类的例子

```
>>> class Student(object):
...     def __init__(self,name,age):
...             self.name = name
...             self.age = age
...
>>>
>>> bart = Student('zth',20)
>>>
>>> bart.name
'zth'
>>> bart.age
20
```

## 实用的例子



```
j <- list(name = "Joe", salary=5000, union=T)

class(j) <- "employee" ## 创建了类，employee

print.employee <- function(wrkr){
cat("Name:", wrkr$name, "\n")
cat("Salary: ", wrkr$salary, "\n")
cat("Union member: ", wrkr$union, "\n")
}

print(j)


# Name: Joe 
# Salary:  5000 
# Union member:  TRUE 
```


如果使用python来写

```
class employee(object):
  def __init__(self,name,salary):
    self.name = name
    self.salary = salary

j = employee("Joe", 5000)
```

或者这样写

```
class Employee:
   '所有员工的基类'
   empCount = 0
 
   def __init__(self, name, salary):
      self.name = name
      self.salary = salary
      Employee.empCount += 1
   
   def displayCount(self):
     print "Total Employee %d" % Employee.empCount
 
   def displayEmployee(self):
      print "Name : ", self.name,  ", Salary: ", self.salary
```

另一个例子

```text
# 创建类
## 使用函数创建了一个类，一句话创建类
my_person <- function(ln, a, ht){
  structure(list(lastName = ln, age = a, height = ht), class = "my_person")
} 

## 创建第一个泛型函数
display <- function(obj) UseMethod("display")
# 创建方法
display.my_person <- function(obj){
  cat("Last name : ", obj$lastName, "\n")
  cat("Age       : ", obj$age, "\n")
  cat("Height    : ", obj$height, "\n")
}


## 创建第二个泛型函数，如果泛型函数的方法又多个参数，务必加上...
nYear <- function(obj,...) UseMethod("nYear")
# 创建方法
nYear.my_person <- function(obj,n){
  obj$age <- obj$age + n
  cat("Age after",n,"years is:", obj$age, "\n")
}

# 由类创建对象
Tom <- my_person("Godden", 19, 176)

# 第一个泛型函数派送
display(Tom)
## Last name :  Godden 
## Age       :  19 
## Height    :  176

# 第二个泛型函数派送
nYear(Tom,7)
## Age after 7 years is: 26
```