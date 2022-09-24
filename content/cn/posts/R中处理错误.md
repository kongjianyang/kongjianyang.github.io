---
title: "R中处理错误"
date: 2019-06-07T14:32:27-05:00
author: KJY
slug: R_errors
draft: false
toc: true
categories:
  - R
tags:
  - article
---





## 方案一：使用try语句

1.  使用方法  
    在R语言中，try语句的用法如下所示:

```
try(expr, silent = FALSE,
    outFile = getOption("try.outFile", default = stderr()))
```

可以看到，try语句共有三个参数，常用的是前两个参数。第一个参数`expr`为我们所要使用的表达式，第二个参数`silent`表示当错误出现时是否需要报告错误信息，其输入值应为逻辑变量，默认为`FALSE`，即选择不保持“沉默”，当错误出现时会立即报告错误信息。

如果参数`expr`所代表的表达式可以正确运行，则try语句的输出即为该表达式的运行结果，如果表达式无法正确运行，则try语句会输出一个“try-error”类的不可见对象，因此可以通过if语句对try语句的输出结果进行判断从而进行下一步的处理。

如果大段代码中有错误，想忽略错误，可以采用**try()**，但大段代码需放在**{ }**中：

你可以捕获**try()**的输出，如果程序运行成功，返回计算结果；如果程序运行不成功，则可以通过**class()**函数返回，错误类型 'try-error'。

2.  使用示例

```bash
A = list(a=1,b='abc',c=-2,d=3)                  # 运行log('abc')会报错，运行log(-2)会出现警告
B = list()
for (nm in names(A))
{
    x       <- A[[nm]]
    temp    <- try(log(x),silent=FALSE)
    if('try-error' %in% class(temp))            # 判断当前循环的try语句中的表达式是否运行正确
    {
       temp <- NA                               # 此处可以对运行错误的情况进行处理应对
    }
    B[[nm]] <- temp
}
```





## 方案二：使用tryCatch语句

1.  使用方法  
    相较于try语句，tryCatch语句更为全面，能够处理和应对更为复杂的问题。其不仅能够处理表达式出现错误error的情形，还能够处理出现警告warning的情况。主要用法如下所示：

```bash
tryCatch(
         { expr },
         warning = function(w) { warning-handler-code },
         error = function(e) { error-handler-code }, 
         finally = { cleanup-code }
         )
```

可以看到，tryCatch语句的内部可以被划分为四个不同的部分。  
第一个部分`{ expr }`为所要运行的表达式；  
第二个部分`warning = function(w) { warning-handler-code }`用于处理第一个部分出现警告warning时的情况；  
第三个部分`error = function(e) { error-handler-code }`用于处理第一个部分出现错误error时的情况；  
第四个部分`finally = { cleanup-code }`用于最后收尾，不管前面是否出现警告warning或者错误error，该部分的代码都会被执行。  
除了第一个部分不可缺省之外，其他几个部分都可以根据实际需要进行使用。  
2.使用示例

```bash
A = list(a=1,b='abc',c=-2,d=3)                   # 运行log('abc')会报错，运行log(-2)会出现警告
B = list()
for (nm in names(A))
{
    x    <- A[[nm]]
    temp <- tryCatch(
                     { log(x) },
                     warning = function(w) { message('Waring @ ',x) ; return(NA) },
                     error = function(e) { message('Error @ ',x) ; return(NA) },
                     finally = { message('next...') }
                     )
    B[[nm]] <- temp

```
