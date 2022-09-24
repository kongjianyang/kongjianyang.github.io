---
title: "R语言必须掌握的包"
date: 2022-05-04T22:21:53-04:00
author: KJY
slug: R_packages
draft: false
toc: true
categories:  
  - R
tags:        
  - article
---

这是网络上收集的内容，具有一些参考价值

[qinwf/awesome-R: A curated list of awesome R packages, frameworks and software. (github.com)](https://github.com/qinwf/awesome-R)

但是对于我的日常来讲，会有以下一些包进行日常使用，可以常用常新

# 1. 数据导入

【精】readr：实现表格数据的快速导入。[https://readr.tidyverse.org](https://links.jianshu.com/go?to=https%3A%2F%2F%E6%89%8B%E5%86%8C)

readxl：读取Microsoft Excel电子表格数据

dplyr：提供了一个访问常见数据库的接口

data.table：data.table包的fread()函数可以快速读取大数据集

`rio`：一站式导入/导出几乎所有格式数据（使用`import()`/`export()`函数）

# 2. 数据整理



【精】tidyr：用于整理表格数据的布局

【精】dplyr：用于将多个数据表连接成一个整齐的数据集

purrr：函数式编程工具，在做数据整理时非常有用。



# 3. 数据可视化



【精】ggplot2及其扩展：ggplot2包提供了一个强大的绘图系统，并实现了以下扩展

ggthemes：提供扩展的图形风格主题

【精】ggpubr: 生成杂志期刊等出版物的图形的包，是ggplot的一个补充。

ggrepel：用于避免图形标签重叠,美化ggplot；

`cowplot`：`ggplot2`拓展工具箱（多图合并、图层叠加、添加标签等）

【精】`see`：`ggplot2`拓展工具箱（更丰富更美观的主题配色方案）[Model Visualisation Toolbox for easystats and ggplot2 • see](https://easystats.github.io/see/)

# 4. 数据转换



【精】dplyr：一个用于高效数据清理的R包。视频学习课程

magrittr：一个高效的管道操作工具包。

【精】pipeR: 比magrittr更好用的管道操作工具包 [Introduction | pipeR Tutorial (renkun-ken.github.io)](https://renkun-ken.github.io/pipeR-tutorial/index.html)

tibble：高效的显示表格数据的结构

【精】stringr：一个字符串处理工具集

data.table：用于快速处理大数据集

stringi：一个快速字符串处理工具