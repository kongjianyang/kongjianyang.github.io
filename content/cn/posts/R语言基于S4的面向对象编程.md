---
title: "R语言基于S4的面向对象编程"
date: 2022-03-31T13:42:27-05:00
author: KJY
slug: S4
draft: false
toc: true
categories:
  - test
tags:
  - article

---

参考资料：

[R 学习笔记: S4 编程基础 - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/21396190)



不同的语言进行面向对象编程中, 有许多东西是共同的. 就像浩巍说的, 编程就是一通百通. 如果了解 Python 的面向对象编程, 里面的很多思想也能使用在 R 语言面向对象编程中.

- 类 (class) 是面向对象编程的基础. 类就像是一个包装的盒子, 把对象的所有的属性都包含在其中. 可以形象地说, 类有点像一个有多种口味可供选择的冰激凌机器.
- 变量 (variable) 是描述对象的具体特征的数据, 是类的属性, 可以是数字或者字符等各种类型, 在 R 语言的 S4 类中被称为存储槽 (slot). 不同的变量, 就是冰激凌机器中的不同口味的冰激凌.
- 方法 (method) 是作用于类对象的各种操作, 也是类的属性, 具体实现就是各种方程. 方法也对应于冰激凌机器上产出不同口味冰激凌的不同的按钮. 对于不同的类可以有相似的方法, 例如对不同的类都可以有 print 函数来输出类的内容. 需要注意的是, 在 R 语言的 S4 类中, 类的方法本身不属于类本身, 而是独立的方程, 这点和 Python 等语言面向对象编程有差别. 但是, 在 R 语言的 RC 类 (Reference Class) 中方法本身则属于类.

面向对象编程有三个重要特点: 封装, 继承和多态性. 封装的好处是把同属一个类的不同的属性能够包装在一起, 不会和外部的变量等相互影响. 那么在 R 的 S4 面向对象编程中, 也应该注意的是, 尽量不要直接引用类的 slot, 最好是通过方法来引用, 也就是通过按键来获得冰激凌, 而不是直接打开储藏盖去取. 不过, 直接引用确实是一个很方便的方式, 在能够保证正确的情况下也可以适当采用. 继承和多态性则有利于代码的重用, 减少由于采用重复相同的代码, 而在代码发生改变的时候造成不同的相关类之间出现不一致. 类的继承关系需要在编程之前妥善设计好, 这样才能有效地发挥面向对象编程的优势.

R语言的类有S3类和S4类，S3类用的比较广，创建简单粗糙但是灵活，而S4类比较精细，具有严格的类结构，从其他语言过来的用户可能会习惯一些。S4对象系统具有明显的结构化特征，更适合面向对象的程序设计。

**S4**的工作机制和S3类似，但是更加正式。S4和S3有两点主要的区别：首先S4对类有正规的定义，来描述该类的属性和继承关系；另外S4有特定的函数来定义范型和方法。S4还有多重派遣特性，即S4的范型函数可以根据任意多个参数的类来选择多个方法，而不仅仅是根据一个参数的类。

一些程序员认为S3类不具有面向对象编程固有的安全性。例如，你可以任意修改S3类，哪怕是不合法的修改。相比而言，S4类更加安全。

所有的S4相关代码均存在methods包中，S4非常复杂，但是好在有很多权威的资料供我们参考。如：

[Bioconductor 中开发课程资料](https://links.jianshu.com/go?to=http%3A%2F%2Fwww.bioconductor.org%2Fhelp%2Fcourse-materials%2F2010%2FAdvancedR%2FS4InBioconductor.pdf)

## S4 框架介绍

S4的泛型函数分离了方法的定义和实现，也就是常说的接口和调用分离。即通过S4对象系统，把原来的函数定义和调用2步法，分成了4步进行：

1.  定义数据对象类型
    
2.  定义接口类（泛型函数）
    
3.  定义方法类
    
4.  把数据对象以参数传入到泛型函数，调用实现函数
    

| CLASS                                 | 泛型类                                     | 方法类                                                    |
| ------------------------------------- | ------------------------------------------ | --------------------------------------------------------- |
| setClass()：定义                      | setGeneric()                               | setMethod()                                               |
| class:类名                            | 创建新泛型类或将现有函数转换为泛型类       | 通过联系泛型类、class中的参数，并利用function实现函数调用 |
| slots: 属性和类型                     | name ：泛型类名                            | f ：泛型类名                                              |
| prototype: 属性的默认值               | def：函数定义                              | definition：方法定义                                      |
| contains: 定义父类，继承源头          | signature ： the method dispatch signature | signature：class类名                                      |
| validity: 属性的类型检查              |                                            |                                                           |
| sealed: 同名类是否能被再定义          |                                            |                                                           |
| new():通过类名和slots中的参数创建对象 |                                            |                                                           |

## 定义类并创建对象

如上表所示，S4的类(class)可以通过setClass()实现，而new()则可以通过类名和slots中的参数创建跟该类相关的对象。

对于 S4 类的定义, 其定义中只包含类的名称和其变量, 也就是 slot, 而不包括方法. 定义 S4 类要使用 setClass 函数.

```R
# 创建Class - Person
# slot和attr类似，都是属性
setClass("Person", slots = list(name = "character", age = "numeric"))

# 创建Class - Employee，利用contains表明参数继承自Person。
setClass("Employee", slots = list(boss = "Person"), contains = "Person")

# 设置基于Class - Person的对象
alice <- new("Person", name = "Alice", age = 40)

# 设置基于Class - Employee的对象
john <- new("Employee", name = "John", age = 20, boss = alice)
str(alice)
str(john) # 可以看到jhon多了一个slot，即@boss，boss是alice
```

```R
# Formal class 'Employee' [package ".GlobalEnv"] with 3 slots
#   ..@ boss:Formal class 'Person' [package ".GlobalEnv"] with 2 slots
#   .. .. ..@ name: chr "Alice"
#   .. .. ..@ age : num 40
#   ..@ name: chr "John"
#   ..@ age : num 20
```



但是在创建类的时候, 应该指定每个 slots 的类型, 最好是可以限定的基本类型, 如 numeric, character, 等 atomic 类型. 而最好不要是 list 等类型, 因为我们可以向 list 中添加任何类型的数据, 这样就使得类的变量变得不可控, 也不好建立合适的方法. slots 接受一个 vector 或者 list, 把变量名和其类型名对应起来即可.

```R
setClass(
    Class = "IcecreamMachine",
    slots = c(
        strawberry = "numeric",
        chocolate  = "numeric",
        mango      = "numeric"
    )
)
```

通过prototype 设置初始值，当创建对象时，如果slots中的属性为空时，该对象会调用初始值作填入。

设定默认值的时候, prototype 接受一个 list, 其中变量名和默认值一一对应.

```R
# 创建Class - Person
setClass("Person", slots = list(name = "character", age = "numeric"), prototype = list(age = 20))

alice <- new("Person", name = "Alice")
str(alice)
```

通过setValidity设置类属性检查，当通过new()创建对象时，setValidity将对slots 中的参数进行检查、输出报告。

```R
setClass("Person", slots = list(name = "character", age = "numeric"), prototype = list(age = 20))

setValidity("Person",  
 function(object){
 if (object@age < 18)
 "he/she is too yong to get the job."
 })

new("Person", name = "Penny", age = 17) # this will get error

# Error in validObject(.Object) : invalid class “Person” object: he/she is too yong to get the job.
```

如果定义的S4类(class)中包含(继承)了S3类或基础类，该S4类(class)中将有一个包含底层基础类或S3对象的.Data slots：

```R
setClass("RangedNumeric",
 slots = list(min = "numeric", max = "numeric")，
 contains = "numeric")
rn <- new("RangedNumeric", 1:10, min = 1, max = 10)
str(rn)
```

在S3对象中，一般我使用$来访问一个对象的属性，但在S4对象中，我们只能用@来访问一个对象的属性。使用 "@" 符号可以直接获得 S4 对象的属性

```R
# 查看alice对象的name属性
alice@name
```

> Given an S4 object you can see its class with `is()` and access slots with `@` (equivalent to `$`) and `slot()` (equivalent to `[[`):

```R
# 查看alice对象的name属性
alice@name
# "Alice"

slot(alice, "age")
alice@age
# 40
# 40
```

## 构造泛型类和方法类

setGeneric()可以创建或将原有的类转换为泛型类，如果setGeneric()只是将原有的类转换为泛型，那么只需要setGeneric("names")就可以了；如果从头创建一个新的泛型，还需要提供一个名叫standardGeneric()的function，function里面就填泛型类的名字就可以：

```R
setGeneric("myGeneric", function(x) {
 standardGeneric("myGeneric")
})
```

S4的泛型函数通过调用setGeneric函数产生，该函数的用法如下：

```R
setGeneric(name, def = , group = list(), valueClass = character(), where = ,
    package = , signature = , useAsDefault = , genericFunction = , simpleInheritanceOnly = )
```

参数虽然很多，但常用两个：

- name: 表示泛型函数名称的字符串。这个函数必须已经定义，它将被转成泛型函数（如果它还不是泛型函数），而且该函数将被设为默认方法
- def: 这是可选项。如果name参数没有对应的已有函数，这一项必需提供。如果name已经有对应的函数，使用def项可以指定其他的函数作为泛型函数（偷梁换柱）。

泛型函数的方法使用setMethod函数进行定义：

```R
setMethod(f, signature = character(), definition, where = topenv(parent.frame()),
    valueClass = NULL, sealed = FALSE)
```

- f：泛型函数名称
- signature：识别指纹，即对象的类名称

setMethod()利用泛型的名称、与该方法相关联的类以及实现该方法的函数实现参数调用和函数运行。

可以使用getGenerics()获得所有S4泛型的列表；使用getClasses()获得所有S4类的列表；可以使用showMethods()列出所有S4方法。

## S4的泛型函数的定义和调用

该代码参考(copy)自[R的极客理想](https://links.jianshu.com/go?to=http%3A%2F%2Fblog.fens.me%2Fseries-r%2F)中的[R语言基于S4的面向对象编程](https://links.jianshu.com/go?to=http%3A%2F%2Fblog.fens.me%2Fr-class-s4%2F)，全文用深入浅出的方式介绍了S4泛型函数。

```R
# 定义几何图形类
setClass("geometric_figure", slots = list(name = "character",
 shape = "character"))

# 定义圆形类, 利用prototype定义默认属性参数
# 利用contains表明参数继承自geometric_figure。
setClass("Circle", slots = list(radius="numeric"),
 prototype = list(shape = "circle"),
 contains = "geometric_figure")

# 定义验证类，保证Circle 类中的属性正常
setValidity("Circle", function(object){
 if (object@radius <= 0)
 stop("The radius of circle is negative！")
})

# 面积计算 --------------------------------------------------------------------

# 定义计算面积的泛型函数接口
setGeneric("area",function(object){
 standardGeneric("area")
 })

# 定义面积的计算方法
setMethod("area","Circle",function(object){
 cat("The shape of", object@name, "is", object@shape,
 "\nThe Area of it is", pi*object@radius^2)
 })


# 周长计算 --------------------------------------------------------------------

# 定义计算周长的泛型函数接口
setGeneric("circum",function(object) standardGeneric("circum"))

# 定义计算周长的方法
 setMethod("circum","Circle",function(object){
 cat("The circumference of", object@name, "is",
 2*pi*object@radius)
 })

# 创建圆形实例
c <-new("Circle", name="c", radius=5)
# 函数调用 --------------------------------------------------------------------
# 上面利用setMethod定义了area和circum两个函数
                      
area(c)
circum(c)
```

上述过程已经创建了几何图形(geometric\_figure)类和面积|周长的泛型函数接口。如果想要计算其他图形，如椭圆、正方形、矩形，三角形、梯形等的周长和面积，只需要通过setClass()定义好继承类，然后再利用setMethod()定义好计算方法，最后就可以通过area()或者circum调用相关函数进行计算，自此就实现了接口和调用分离的S4函数调用全程。

S4的泛型函数实现有别于S3的实现，S4分离了方法的定义和实现，如在其他语言中我们常说的接口和实现分离。通过setGeneric()来定义接口，通过setMethod()来定义现实类。这样可以让S4对象系统，更符合面向对象的特征。

```R
# 这是普通方法
work<-function(x) cat(x, "is working")
work('Conan')
# Conan is working

# S4的方法
# 定义Person对象
setClass("Person",slots=list(name="character",age="numeric"))
# 定义泛型函数work，即接口
setGeneric("work",function(object) standardGeneric("work"))
# 定义work的现实，并指定参数类型为Person对象
setMethod("work", signature(object = "Person"), function(object) cat(object@name , "is working") )
# 创建一个Person对象a
a<-new("Person",name="Conan",age=16)
# 把对象a传入work函数
work(a)
# Conan is working
```

通过S4对象系统，把原来的函数定义和调用2步，为成了4步进行：

（1）定义数据对象类型

（2）定义接口函数

（3）定义实现函数

（4）把数据对象以参数传入到接口函数，执行实现函数

通过S4对象系统，是一个结构化的，完整的面向对象实现。

当我们使用S4对象进行面向对象封装后，我们还需要能查看到S4对象的定义和函数定义。

```R
library(pryr)
# 检查work的类型
ftype(work)
# "s4"      "generic"
# 直接查看work函数
work
# 查看work函数的现实定义
 showMethods(work)
# 查看Person对象的work函数现实
getMethod("work", "Person")
selectMethod("work", "Person")
# 检查Person对象有没有work函数
 existsMethod("work", "Person")
 hasMethod("work", "Person")
```



## 另一个更详细的例子：



```R
# 创造一个IcecreamMachine的类
setClass(
    Class     = "IcecreamMachine",
    slots     = c(
        strawberry = "numeric",
        chocolate  = "numeric",
        mango      = "numeric"
    ),
    prototype = list(
        strawberry = 0,
        chocolate  = 0,
        mango      = 0
    )
)

# 创造了一个IcecreamStore的类，并且IcecreamStore类包含IcecreamMachine
setClass(
    Class = "IcecreamStore",
    slots = c(place = "character"),
    contains = "IcecreamMachine"
)

```

R 语言提供了很多方便使用的自省函数, S4 类也有一些方便使用的函数.

- 查看类 slot 变量名, slotNames 函数.
- 获得类 slot, getSlots 函数.
- 获得类, getClass 函数.

```R
slotNames("IcecreamMachine")
#[1] "strawberry" "chocolate"  "mango"

getSlots("IcecreamMachine")
#strawberry  chocolate      mango 
# "numeric"  "numeric"  "numeric"

getClass("IcecreamMachine")
#Class "IcecreamMachine" [in ".GlobalEnv"]
#
#Slots:
#
#Name:  strawberry  chocolate      mango
#Class:    numeric    numeric    numeric
```

对于已经存在的方法原型, 可以直接使用 setMethod. 而对于自定义的方法则需要先设置方法原型, 使用 setGeneric 范式函数.



```R
# 定义getIcecream的泛型函数接口
setGeneric(
    name = "getIcecream",
    def  = function(object,...) {
        standardGeneric("getIcecream")
    })setMethod(
    f          = "getIcecream",
    signature  = "IcecreamMachine",
    definition = function(object, type) {
        slot(object, type) <- slot(object, type) - 1
        return(1)
    })

```

S4 类的方法和 S4 类的定义是独立的. S4 的方法要使用 setMethod 函数来定义.

```R
setMethod(
    f           = "show",
    signature   = "IcecreamMachine",
    definition = function(object) {
        cat("*** Wounderful Icecream Machine! ***\n")
        cat("Taste:\n")
        cat("\tStrawberry: ", object@strawberry, "\n") 
        cat("\tChocolate: ", object@chocolate, "\n") 
        cat("\tMango: ", object@mango, "\n") 
    }
)
```

直接获得某个方法的代码, 使用函数 getMethod.

```R
getMethod(f="show", signature="IcecreamMachine")
#Method Definition:

#function (object) 
#{
#    cat("*** Wounderful Icecream Machine! ***\n")
#    cat("Taste:\n")
#    cat("\tStrawberry: ", object@strawberry, "\n")
#    cat("\tChocolate: ", object@chocolate, "\n")
#    cat("\tMango: ", object@mango, "\n")
#}

#Signatures:
#        object
#target  "IcecreamMachine"
#defined "IcecreamMachine"
```

泛型函数通俗的就是同一个函数名， 遇到**不同的对象**产生不同的效果。

泛函是R语言中最主要的面向对象的体现，这点和python的差别挺大，在R中几乎看不到定义一个类，然后在类中定义方法的现象。R是通过泛函的形式，来实现对不同对象使用不同的方法。

S4的泛型函数通过**setGeneric()**来定义泛型接口，通过setMethod()来定义现实类。这样可以让S4对象系统，更符合面向对象的特征。下面的例子说明了什么泛型函数

```R
# 设定一个函数来 自我介绍 
# 普通函数 
selfIntroduce<- function(name){
  sprintf("my name is %s", name)
}
selfIntroduce("Sun wukong")
>"my name is Sun wukong" 
# 将函数定义为泛型函数，即接口
setGeneric("selfIntroduce",
           function(object){
             standardGeneric("selfIntroduce")
          }
)
selfIntroduce("Sun wukong")# 这时普通函数已经不能使用了， 泛型函数必须指定具体类的方法
#Error in (function (classes, fdef, mtable)  : 
# unable to find an inherited method for function ‘selfIntroduce’ for signature #‘"character"’ 

# 定义函数的现实，并指定参数类型为person对象时如何运行
setMethod("selfIntroduce", 
          signature(object = "person"),
          function(object){
            sprintf("my name is %s, i'm %d years old", object@name, object@age)
          }
)
selfIntroduce(zhangsan)
# "my name is zhangsan, i'm 26 years old"

# 增加一个函数的现实，指定参数类型为character对象时如何运行
setMethod("selfIntroduce", 
          signature(object = "character"),
          function(object){
            sprintf("my name is %s", object)
          }
)
selfIntroduce("Sun wukong")
# "my name is Sun wukong" 

# 查看类函数
> showMethods(selfIntroduce)
# Function: selfIntroduce (package .GlobalEnv)
# object="character"
# object="Person"

# 查看类函数定义
getMethod("selfIntroduce", "person")
# Method Definition:
# 
# function (object) 
# {
#     sprintf("my name is %s, i'm %d years old", object@name, 
#         object@age)
# }
# 
# Signatures:
#         object  
# target  "person"
# defined "person"
```

## S3中的泛函



```R
# 定义泛函
move <- function(x, ...) UseMethod('move') # 后面的字符串必须与前面函数名相同
# 定义各种方法
move.default <- function(x) print('I am moving')
move.dog <- function(x) print('I am running')
move.fish <- function(x) print('I am swimmning')

# 创建变量并指定类
onedog <- "a" # 这里赋值是多少不重要
attr(onedog,"class") <- "dog" # 将变量onedog指定为dog类，对应上面的move.dog函数
onefish <- "b"
attr(onefish,"class") <- "fish" # 将变量onefish指定为fish类，对应上面的move.fish函数
anything <- "c" # 不指定类，是一个字符串

# 检验变量所属类
class(onedog)
# [1] "dog"
class(onefish)
# [1] "fish"
class(anything)
# [1] "character"

# 调用泛函
move(onedog)
# [1] "I am running"
move(onefish)
# [1] "I am swimmning"
move(anything)
# [1] "I am moving"
move.dog(anything) # 因为这里函数没有对输入的x进行检验，所以接一个不是这个类的也没事
# [1] "I am running"
```



## 一个例子说明S3以及S4编程



```R
# S3 class

newstudent <- function(sid, sname, ssex){

  tmp <- list(id = sid, name = sname, sex = ssex)

  class(tmp) <- "student"

  return(tmp)

}

print.student <- function(st){

  cat(st$id, "\n")

  cat(st$name, "\n")

  cat(st$sex, "\n")

}

st = newstudent(11, "jack", "male")

#print(st)

st

# S4 class

setClass("student",

         representation(

           id = "numeric",

           name = "character",

           sex = "character"

         ))

# print is not a S4 generic. show methods are mapped to print for convenience, though. 

setMethod("show", "student",

          function(object){

            cat(object@id, "\n")

            cat(object@name, "\n")

            cat(object@sex, "\n")

          })

st = new("student", id = 41, name = "tom",  sex = "male")

#print(st)

st
```

