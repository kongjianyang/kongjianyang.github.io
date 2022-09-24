---
title: "R语言str_replace多匹配"
date: 2021-03-26T14:42:27-05:00
author: KJY
slug: str_replace
draft: false
toc: true
categories:
  - ChIPseeker
tags:
  - article
---



主要参考这个回答：[r - stringr str_replace on multiple patterns and replacements? - Stack Overflow](https://stackoverflow.com/questions/60129058/stringr-str-replace-on-multiple-patterns-and-replacements)



```R
library(stringr)
library(purrr)
reduce2(c('b', 'd'), c('B', 'D'),  .init = 'abcdef', str_replace)
#[1] "aBcDef"
```

这种方法在大批量替换rowname的时候很有用，所以解析一下。

在purrr包中

`map`表示映射，可以在一个或多个列表/向量的每个位置上应用相同函数进行计算。`map`函数的映射对象只有一个。

![map.png](https://img-blog.csdnimg.cn/img_convert/ff19dbc1bbe38c449e69ddf80bf8e27e.png)

> map(.x, .f, …)
> `.x`: 列表或向量；
> `.f`: 映射函数；
> `...`: 映射函数的其他参数



`map2`函数是`map`函数的变形，映射对象有两个，需要注意**两个列表/向量的长度必须相同**。

![map2.png](https://img-blog.csdnimg.cn/img_convert/b8f081be8f494858e688d96363e74a8e.png)

> map2(.x,.y, .f, …)
> `.x`: 列表或向量；
> `.y`: 列表或向量,与`.x`等长；
> `.f`: 映射函数；
> `...`: 映射函数的其他参数

`pmap`函数是`map`函数的变形，映射对象为多个，需要注意**多个列表/向量的长度必须相同**。

![pmap.png](https://img-blog.csdnimg.cn/img_convert/2e33ab5b423a06c5859cb0b9937b6c9f.png)

> pmap(.l, .f, …)
> `.l`: 列表向量/列表；
> `.f`: 映射函数；
> `...`: 映射函数的其他参数

`reduce`函数表示规约，计算向量中相邻的两个元素，结果再与第三个元素计算，…，最后计算出一个值。
![reduce.png](https://img-blog.csdnimg.cn/img_convert/2e7a923e99da55eda55b62726cfb51d7.png)

> reduce(.x, .f, …)
> `.x`: 列表向量/列表；
> `.f`: 规约函数；
> `...`: 函数的其他参数

```
reduce(1:5, sum)
# [1] 15 : 1+2+3+4+5
```



## reduce2

`reduce2`函数可以同时对两个向量进行规约计算，注意**第二个向量长度需要比第一个向量小1**。

> reduce2(.x, .y,.f, …)
> `.x`: 列表向量/列表；
> `.y`: 列表向量/列表，长度比`.x`小1；
> `.f`: 规约函数；
> `...`: 函数的其他参数



`reduce2(x, y, f)`中的`x`是要进行连续运算的数据列表或向量， 而`y`是给这些运算提供不同的参数。 如果没有`.init`初始值， `f`仅需调用`length(x)-1`次， 所以`y`仅需要有`length(x)-1`个元素； 如果有`.init`初始值， `f`需要调用`length(x)`次， `y`也需要与`x`等长。

​	

```R
reduce2(1:4, c(1,1,1), function(x,y,z) x+y-z)
# [1] 7
```

计算逻辑为第一次：1+2-1=2，第二次2+3-1=4，第三次4+4-1=7。

