---
title: python的global函数以及LEGB原则
author: Liang
date: '2018-11-24'
slug: python的global函数以及LEGB原则
categories:
  - 大蟒笔记
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
## 1. 起因

两小段代码的故事：
```
def myFunc():
    B = 10
    def inFunc(A):
        global B
        B = A ** 5
    return B
B = 25
myFunc()
print B
```

```
def myFunc():
    B = 10
    def inFunc(A):
        global B
        B = A ** 5
    inFunc(B)
    return B
B = 25
myFunc()
print B
```
你能不运行代码直接告诉这两个小代码的结果么？

## 2. 解释

python中的局部变量和全局变量。

全局变量：所有函数之外定义的变量
局部变量：函数内部定义的变量 或者代码块里的变量

1.函数内部的变量名如果第一次出现，且出现在=前面，即被视为定义了一个局部变量，不管全局域中有没有该变量名，函数中使用的将是局部变量。

(即声明了一个新的局部变量。如果这个变量名字和全部变量名字相同，那么局部变量名字会覆盖全局变量名字）

```
#[demo1]
num = 100  
def func():  
    newValue = 123   #一个全新的局部变量newValue 
    print(newValue)  

func()  #输出局部变量newValue 即新的局部变量


#[demo2]
num = 100  
def func():  
    num= 123  #声明一个全新的局部变量num，虽然名字和外界的全部变量相同 但是是新的一个变量且是局部有效的。屏蔽了外面的同名的全部变量
    print(num)  

func()  #输出局部变量num=123 即新的局部变量。
```

2.如果局部变量用到了一个变量。该变量是全局存在的，但是局部并没有声明这么一个变量。那么此时**参与运算的是全局变量**。**但是这个参与运算是不能被赋值的，因为你赋值的时候按照python的语法那就是新生成一个局部变量，而且你在右侧使用的话。那就是会报错**。

```
#[demo1]
num = 100  
def func():  
    x = num+200  #使用值做参数，那么其实是copy一份num全部变量的值
    print(x)
    print(id(num))  #id值

func()  #输出300  即没有局部变量声明 那么使用就是全局变量
print(id(num))  #id值


#[demo2]

list = [100] 
def func():  
    list.append(200) #直接使用变量，那么得到了全局变量 操作全局变量。
    print(list)
    print(id(list))

func()  #输出[100,200]
```

3.如果你想在局部变量修改全局变量。
因为本身是不能的，你修改然后赋值的时候会出现矛盾。即你涉及到赋值var = xxx 修改的时候，那么会被语法解析会声明一个新的局部变量var。当然对象类型除外，你可以直接操作他的元素。

```
#[demo1]
num = 100  
def func():  
    num= 123   #本来你的意图是赋值给全局变量Num,但是此处会被解析为声明一个全新的局部变量num
    print(id(num))  

func()  #输出局部变量newValue 即新的局部变量，即123
print(id(num))
```
那么怎么办？才能在局部变量赋值修改全局变量

[关键字 global]

```
#[demo1]
Num = 100  
def func():  
    global Num  #声明这个Num是全局的哦。如果全局变量已经有这个Num变量那就是指的它 如果全局没这个Num那就新定义一个全局变量。
    Num  = 200  #此时此刻 凡是在函数内部Num的意思始终是指全局变量。不可能有个局部变量叫Num的。
    print(Num )  

func()  
print(Num ) #输出200 说明修改的就是全局变量啊

#[demo2]
def func():  
    global Num  #声明这个Num是全局的哦。而且恰恰是此时没有一个全局变量是Num。那么如果全局没这个Num那就新定义一个Num的全局变量。
    Num  = 200  
    print(Num )  

func()  
print(Num ) #输出200 说明新定义了一个全局变量Num
```
## 3.总结
通过之前2中对于全局变量和局部变量的理解，我们现在尝试理解一下1中的问题。
```
def myFunc():
    B = 10
    def inFunc(A):
        global B
        B = A ** 5
    return B
B = 25
myFunc() #调用myFunc()时，没有输入全局变量，调用的全部是局部变量，B = 10，同时B=10没有进入inFunc()函数，所以输出结果是10
print B #应用的是全局变量，没有被更改，输出是25
```
解释下一个函数：
```
def myFunc():
    B = 10
    def inFunc(A):
        global B
        B = A ** 5
    inFunc(B)
    return B
B = 25
myFunc() #调用函数myFunc()，使用局部变量 B=10，B = 10之后进入inFunc()函数，这时使用global函数，将B改变为全局变量，因为这时没有对B进行定义，只是创造了一个新的全局变量，注意这里的A其实是原来的B=10，所以创造的新的全局变量B等于100000，而myFunc()内部有局部变量B=10，输出的则是内部变量=10
print B #这时B已经改变为100000，输出100000
```
另外一个bonus的问题：
```
def myFunc(B):
    global A
    B = A ** 2
    return B * A
A = 5 
C = myFunc(A) # 函数myFunc()调用全局变量是A=5， 局部变量A=5，所以B=25，则return的是125
print C
```
