---
title: "R中的fuzzyjoin包介绍"
date: 2019-11-12T14:32:27-05:00
author: KJY
slug: R_fuzzyjoin
draft: false
toc: true
categories:
  - bioinfo
tags:
  - article

---

假设字符串x最少需要插入a次、删除b次、替换c次才能与字符串y相同，则x、y之间的
距离
即a、b、c的加权总和。比如将”kitten”转化为”sitting”，需要把“k”替换为“s”，把“e”替换为“i”，并在尾部插入“g”，所以共需1次插入、0次删除、2次替换，按照默认权重两者之间
距离 英该为3。

在R语言中，我们可以使用adist(x, y = NULL, costs = NULL, counts = FALSE,
…)的形式，计算字符串之间的距离。其中：

-   costs即插入（insertions）、删除（deletions）、替换（substitutions）次数的权重
-   counts表示是否输出插入、删除、替换次数
-   partial表示是否只进行局部匹配

<!-- -->

    library(tidyverse)
    
    ## ── Attaching packages ─────────────────────────────────────────────────── tidyverse 1.3.1 ──
    
    ## ✓ ggplot2 3.3.3     ✓ purrr   0.3.4
    ## ✓ tibble  3.1.1     ✓ dplyr   1.0.5
    ## ✓ tidyr   1.1.3     ✓ stringr 1.4.0
    ## ✓ readr   1.4.0     ✓ forcats 0.5.1
    
    ## ── Conflicts ────────────────────────────────────────────────────── tidyverse_conflicts() ──
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()
    
    drop(attr(adist("kitten", "sitting", counts = TRUE), "counts"))
    
    ## ins del sub 
    ##   1   0   2
    
    adist("kitten", "sitting", counts = TRUE) %>%
      attr(., "counts") %>%
      drop()
    
    ## ins del sub 
    ##   1   0   2
    
    adist("lasy", "1 lazy 2", partial = TRUE)
    
    ##      [,1]
    ## [1,]    1

我们可以通过agrep、agrepl函数，进行模糊查找，这两个函数支持的参数与grep家族函数的参数类似，此外还拥有两个特有参数：

costs即插入、删除、替换次数的权重，参考adist的帮助文档
max.distance即可以接受的最大距离，可以是插入、删除、替换的最大次数，也可以是三者之和（alll）的最大值，还可以是三者加权总和（cost）的最大值

    agrep("lasy", c(" 1 lazy 2", "1 lasy 2"), max = list(sub = 1), value = TRUE)
    
    ## [1] " 1 lazy 2" "1 lasy 2"
    
    agrep("laysy", c("1 lazy", "1", "1 LAZY"), max = 2, value = TRUE)
    
    ## [1] "1 lazy"

上文我们已经介绍了使用正则表达式的匹配规则，以及
agrep家族函数的模糊查找规则，类似的我们可以通过aregexec函数，进行模糊匹配。

    x <- c("1 lazy", "1", "1 LAZY")
    
    aregexec("laysy", x, max.distance = 2)
    
    ## [[1]]
    ## [1] 3
    ## attr(,"match.length")
    ## [1] 4
    ## 
    ## [[2]]
    ## [1] -1
    ## attr(,"match.length")
    ## [1] -1
    ## 
    ## [[3]]
    ## [1] -1
    ## attr(,"match.length")
    ## [1] -1

> The fuzzyjoin package is a variation on dplyr’s join operations that
> allows matching not just on values that match between columns, but on
> inexact matching.

fuzzyjoin是基于dplyr的非精确匹配

    # install.packages("fuzzyjoin")
    library(dplyr)
    library(fuzzyjoin)
    data(misspellings)
    
    df1 <- tibble(col1 = c("apple", "banana", "carrot"),
                  col2 = as.numeric(0:2),
                  col3 = as.numeric(0:2))
    
    df2 <- tibble(col4 = c("app", "carr"), col5 = c(5, 9), matched = rep(TRUE, 2))
    
    df1
    
    ## # A tibble: 3 x 3
    ##   col1    col2  col3
    ##   <chr>  <dbl> <dbl>
    ## 1 apple      0     0
    ## 2 banana     1     1
    ## 3 carrot     2     2
    
    df2
    
    ## # A tibble: 2 x 3
    ##   col4   col5 matched
    ##   <chr> <dbl> <lgl>  
    ## 1 app       5 TRUE   
    ## 2 carr      9 TRUE
    
    ci_str_detect <- function(x, y){str_detect(x, regex(y, ignore_case = TRUE))}
    
    fuzzy_left_join(df1, df2, match_fun = ci_str_detect, by = c("col1" = "col4"))
    
    ## # A tibble: 3 x 6
    ##   col1    col2  col3 col4   col5 matched
    ##   <chr>  <dbl> <dbl> <chr> <dbl> <lgl>  
    ## 1 apple      0     0 app       5 TRUE   
    ## 2 banana     1     1 <NA>     NA NA     
    ## 3 carrot     2     2 carr      9 TRUE

# 一些额外内容

%T&gt;%现实原理如下图所示，使用%T&gt;%把左侧的程序的数据集A传递右侧程序的B函数，B函数的结果数据集不再向右侧传递，而是把B左侧的A数据集再次向右传递给C函数，最后完成数据计算。

    mtcars %>%
      group_by(cyl) %T>% print() %>%
      sample_frac(0.1) %T>% print() %>%
      summarise(res = mean(mpg))
    
    ## # A tibble: 32 x 11
    ## # Groups:   cyl [3]
    ##      mpg   cyl  disp    hp  drat    wt  qsec    vs    am  gear  carb
    ##    <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
    ##  1  21       6  160    110  3.9   2.62  16.5     0     1     4     4
    ##  2  21       6  160    110  3.9   2.88  17.0     0     1     4     4
    ##  3  22.8     4  108     93  3.85  2.32  18.6     1     1     4     1
    ##  4  21.4     6  258    110  3.08  3.22  19.4     1     0     3     1
    ##  5  18.7     8  360    175  3.15  3.44  17.0     0     0     3     2
    ##  6  18.1     6  225    105  2.76  3.46  20.2     1     0     3     1
    ##  7  14.3     8  360    245  3.21  3.57  15.8     0     0     3     4
    ##  8  24.4     4  147.    62  3.69  3.19  20       1     0     4     2
    ##  9  22.8     4  141.    95  3.92  3.15  22.9     1     0     4     2
    ## 10  19.2     6  168.   123  3.92  3.44  18.3     1     0     4     4
    ## # … with 22 more rows
    ## # A tibble: 3 x 11
    ## # Groups:   cyl [3]
    ##     mpg   cyl  disp    hp  drat    wt  qsec    vs    am  gear  carb
    ##   <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
    ## 1  21.4     4   121   109  4.11  2.78  18.6     1     1     4     2
    ## 2  19.7     6   145   175  3.62  2.77  15.5     0     1     5     6
    ## 3  18.7     8   360   175  3.15  3.44  17.0     0     0     3     2
    
    ## # A tibble: 3 x 2
    ##     cyl   res
    ##   <dbl> <dbl>
    ## 1     4  21.4
    ## 2     6  19.7
    ## 3     8  18.7
