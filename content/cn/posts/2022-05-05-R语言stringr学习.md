---
title: "R语言stringr学习"
date: 2022-05-05T23:57:39-04:00
author: KJY
slug: strigr
draft: false
toc: true
categories:  
  - R
tags:        
  - article
---



stringr包被定义为一致的、简单易用的字符串工具集。所有的函数和参数定义都具有一致性，比如，用相同的方法进行NA处理和0长度的向量处理。



对于R语言本身的base包提供的字符串基础函数，随着时间的积累，已经变得很多地方不一致，不规范的命名，不标准的参数定义，很难看一眼就上手使用。字符串处理在其他语言中都是非常方便的事情，R语言在这方面确实落后了。stringr包就是为了解决这个问题，让字符串处理变得简单易用，提供友好的字符串操作接口。

R语言中处理字符串主要有stringi和stringr两种，更加推荐使用stringr,因为stringi命令太多太复杂了...

来自Hadley Wickham的评价

- `stringi` provides tools to do anything we could ever want to do with strings, where `stringr` provides tools to do the most common 95% of operations. This allows `stringr` to be much simpler, and the cost of some flexibility.
- Additionally `stringi` is implemented in C using the ICU string library, so it's very fast and very correct (it deals with unicode better than base R).
- Fortunately, `stringr` and `stringi` have very similar interfaces, so we should be able to move up from `stringr` to `stringi` very easily. The next version of `stringr` will use `stringi`, so `stringr` will get all the performance benefits (and bug fixes!), and we can continue to use the simple interface.



stringr包中所有的函数都已`str_`开头，让待处理字符做第一个参数，这样处理好处明显，方便使用以及记忆。

-   字符串长度

```
library(stringr)
char <- "我是R语言学习者"
str_length(char)
#> [1] 8
# 向量化
str_length(c("a", "R for data science", NA))
#> [1]  1 18 NA
```

-   连接字符串

R中字符串不像python中可以用加号连接字符串,如下所示:

R 版本

```
#base R
paste0('a','b')
#> [1] "ab"

#stringr
str_c("a","b")
#> [1] "ab"
str_c("a", "b", sep = ", ") #sep 参数控制分隔符
#> [1] "a, b"
```

Python 版本

多个字符串合并为一个字符,`stringr`中的函数都是向量化的，合并一个和多个字符都是同样道理。

```
#base R
paste0(c('a','b','d','e'),collapse = ',')
#> [1] "a,b,d,e"
#stringr
str_c(c('a','b','d','e'),collapse = ',')  #collapse 参数控制
#> [1] "a,b,d,e"
```

-   移除

在正则表达式中 有特殊含义,有时需要两个 ，多体会下面这段，代码实现移除“||”的功能。

```
str_remove(string = 'a||b',pattern = "\\|\\|")
#> [1] "ab"
```

另外常见的\\n, \\t需要被转义处理,在字符清洗,如小说语义分析,网页爬虫后整理等数据清洗过程中经常用到.

#### 截取字符

与`Excle`中`left`,`mid`,`right`函数功能类似

str\_sub() 函数 三个参数:

string:需要被截取的字符串

start: 默认1L,即从最开始截取

end:默认-1L,即截取到最后

```
#注意end 3 和 -3的区别
str_sub(string = '我是R语言学习者',start = 2,end = 3)
#> [1] "是R"
str_sub(string = '我是R语言学习者',start = 2,end = -3)
#> [1] "是R语言学"
```

#### 匹配字符

查看函数帮助文档,str\_match()按照指定pattern(正则表达式)查找字符。困难点在于正则表达式的编写。

```
str_match(string, pattern)
str_match_all(string, pattern)
str_extract(string, pattern)
str_extract_all(string, pattern, simplify = FALSE)
```

str\_extract()函数返回向量,str\_match()函数返回矩阵.

```
# 测试文字来源烽火戏诸侯的<剑来>
strings <- c('陈平安放下新折的那根桃枝,吹灭蜡烛,走出屋子后,坐在台阶上,仰头望去,星空璀璨.') 
str_extract(strings,'陈平安')
#> [1] "陈平安"
str_match(strings,'陈平安')
#>      [,1]    
#> [1,] "陈平安"
```

-   匹配中文

匹配中文的正则表达式\\\[-\]

```
str_extract_all(strings,'[\u4e00-\u9fa5]') #返回list
#> [[1]]
#>  [1] "陈" "平" "安" "放" "下" "新" "折" "的" "那" "根" "桃" "枝" "吹" "灭" "蜡"
#> [16] "烛" "走" "出" "屋" "子" "后" "坐" "在" "台" "阶" "上" "仰" "头" "望" "去"
#> [31] "星" "空" "璀" "璨"
```

-   匹配数字或英文

查找数字的正则表达式\[0-9\];查找英文的正则表达式:\[a-zA-Z\]

```
strings <- c('00123545','LOL league of legends')
str_extract_all(strings,'[0-9]')
#> [[1]]
#> [1] "0" "0" "1" "2" "3" "5" "4" "5"
#> 
#> [[2]]
#> character(0)
str_extract_all(strings,'[a-zA-Z]') 
#> [[1]]
#> character(0)
#> 
#> [[2]]
#>  [1] "L" "O" "L" "l" "e" "a" "g" "u" "e" "o" "f" "l" "e" "g" "e" "n" "d" "s"
```

#### 添加字符

str\_pad() 函数向字符串添加字符。像工作中处理月份的时候,1,2,3,4,5,6,7,8,9,10,11,12变成01,02,03,04,05,06,07,08,09,10,11,12.按照日期时间输出文件名称,如下所示:

```
str_pad(string = 1:12,width = 2,side = 'left',pad = '0')
#>  [1] "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12"
```

#### 去除空格

与`excel`中`trim`函数功能类似，剔除字符中的空格，但是不可以剔除字符中的空格

```
# side 可选 both  left right
str_trim(' ab af ',side = 'both')
#> [1] "ab af"
```

#### 分割字符

`str_split()`处理后的结果是列表

```
# 得到列表,需要向量化
str_split("a,b,d,e",pattern = ',')
#> [[1]]
#> [1] "a" "b" "d" "e"

str_split('ab||cd','\\|\\|') %>% unlist()
#> [1] "ab" "cd"
# same above
#str_split('ab||cd','\\|\\|') %>% purrr::as_vector()
```

当待处理的字符串是字符串向量时，得到的列表长度与向量长度一致

```
fruits <- c(
  "apples and oranges and pears and bananas",
  "pineapples and mangos and guavas"
)

str_split(fruits, " and ")
#> [[1]]
#> [1] "apples"  "oranges" "pears"   "bananas"
#> 
#> [[2]]
#> [1] "pineapples" "mangos"     "guavas"
```

#### 替换字符

`str_replace()`，`str_replace_all()`函数用来替换字符

```
fruits <- c("one apple", "two pears", "three bananas")
str_replace(fruits, "[aeiou]", "-")
#> [1] "-ne apple"     "tw- pears"     "thr-e bananas"
str_replace_all(fruits, "[aeiou]", "-")
#> [1] "-n- -ppl-"     "tw- p--rs"     "thr-- b-n-n-s"
```

#### 移除字符

`str_remove()`,`str_remove_all()`移除字符。本人常用该函数剔除文本中的空格。

```
fruits <- c("one apple", "two pears", "three bananas")
str_remove(fruits, "[aeiou]")
#> [1] "ne apple"     "tw pears"     "thre bananas"
str_remove_all(fruits, "[aeiou]")
#> [1] "n ppl"    "tw prs"   "thr bnns"
```

移除文本中空格

```
str_replace_all(string = ' d a  b ',pattern = ' ',replacement = '')
#> [1] "dab"
```

#### 字符排序

numeric 参数决定是否按照数字排序。

```
str_order(x, decreasing = FALSE, na_last = TRUE, locale = "en",
  numeric = FALSE, ...)

str_sort(x, decreasing = FALSE, na_last = TRUE, locale = "en",
  numeric = FALSE, ...)
```

```
str_order(letters)
#>  [1]  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25
#> [26] 26
str_sort(letters)
#>  [1] "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s"
#> [20] "t" "u" "v" "w" "x" "y" "z"
```

numeric参数

```
x <- c("100a10", "100a5", "2b", "2a")
str_sort(x)
#> [1] "100a10" "100a5"  "2a"     "2b"
str_sort(x, numeric = TRUE)
#> [1] "2a"     "2b"     "100a5"  "100a10"
```

#### 提取单词

从句子中提取单词。

-   参数

```
word(string, start = 1L, end = start, sep = fixed(" "))
```

-   案例

```
sentences <- c("Jane saw a cat", "Jane sat down")
word(sentences, 2, -1)
#> [1] "saw a cat" "sat down"
word(sentences[1], 1:3, -1)
#> [1] "Jane saw a cat" "saw a cat"      "a cat"
```

指定分隔符

```
# Can define words by other separators
str <- 'abc.def..123.4568.999'
word(str, 1, sep = fixed('..'))
#> [1] "abc.def"
word(str, 2, sep = fixed('..'))
#> [1] "123.4568.999"
```

#### 其他函数

-   str\_subset str\_which

`str_subset()`是对x\[str\_detect(x,pattern)\]的包装，`str_which()`是which(str\_detect(x,pattern))的包装。

```
fruit <- c("apple", "banana", "pear", "pinapple")
str_subset(fruit, "a")
#> [1] "apple"    "banana"   "pear"     "pinapple"
# 匹配字符首次出现的位置
str_which(fruit, "a") 
#> [1] 1 2 3 4
```

匹配字符串本身做行筛选。

```
#筛选出字母行
set.seed(24)
dt <- data.table::data.table(col=sample(c(letters,1:10),100,replace = T))
head(dt[str_which(col,pattern = '[a-z]')])
```

-   str\_dup()

`str_dup()`功能是复制字符串。

```
fruit <- c("apple", "pear", "banana")
str_dup(fruit, 2)
str_dup(fruit, 1:3)
str_c("ba", str_dup("na", 0:5))
```

-   str\_starts() str\_ends()

从str\_detect()包装得到.

```
str_starts('abd','a')
#> [1] TRUE
str_detect('abd','^a')
#> [1] TRUE

str_ends('abd','d')
#> [1] TRUE
str_detect('abd','d$')
#> [1] TRUE
```

-   大小写转换

`str_to_upper()`函数将全部字符转换为大写，`str_to_lower()`函数将全部字符转换为小写，`str_to_title()`将每个单词的首字母转换为大写，`str_to_sentence()`将一个字符的首字母转换为大写。

```
dog <- "The quick brown dog"
str_to_upper(dog)
#> [1] "THE QUICK BROWN DOG"
str_to_lower(dog)
#> [1] "the quick brown dog"
str_to_title(dog)
#> [1] "The Quick Brown Dog"
str_to_sentence("the quick brown dog")
#> [1] "The quick brown dog"
```