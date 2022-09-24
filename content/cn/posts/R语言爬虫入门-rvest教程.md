---
title: R语言爬虫入门-rvest教程
author: Liang
date: '2018-11-24'
slug: R语言爬虫入门-rvest教程
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

安装包

```{r}
# install.packages("rvest")
```

查看rvest包的详细信息


```{r}
library(help = rvest)
```

###包的用法：

- read_html() 读取html文档的函数，其输入可以是线上的url，也可以是本地的html文件，甚至是包含html的字符串也可以。

- html_nodes() 选择提取文档中制定元素的部分。可以使用css selectors，例如html_nodes(doc, "table td")；也可以使用xpath selectors，例如html_nodes(doc, xpath = "//table//td")。

- html_tag() 提取标签名称；html_text() 提取标签内的文本；html_attr() 提取指定属性的内容；html_attrs() 提取所有的属性名称及其内容；

- html_table() 解析网页数据表的数据到R的数据框中。

- html_form(),set_values()和submit_form() 分别表示提取、修改和提交表单。

在中文网页中我们经常会遇到乱码的问题，这里提供了两个函数来解决：guess_encoding()用来探测文档的编码，方便我们在读入html文档时设置正确的编码格式，repair_encoding()用来修复html文档读入后的乱码问题。

还有一些函数，用来模拟网上的浏览行为，如html_session(),jump_to(),follow_link(),back(),forward(),submit_form()等等。


```{r}
library(rvest)
web<-read_html("https://book.douban.com/top250?icn=index-book250-all",encoding="UTF-8")
position <- web %>% html_nodes("p.pl") %>% html_text()
web
position
```

第一行是加载Rvest包。

第二行是用read_html函数读取网页信息（类似Rcurl里的getURL），在这个函数里只需写清楚网址和编码（一般就是UTF-8）即可。

第三行是获取节点信息。用%>%符号进行层级划分。web就是之前存储网页信息的变量，所以我们从这里开始，然后html_nodes()函数获取网页里的相应节点。在下面代码里我简单的重现了原网页里的一个层级结构。可以看到，实际上我们要爬取的信息在25个class属性为pl的<p>标签里的文本。


<p class=pl>
       [清] 曹雪芹 著 / 人民文学出版社 / 1996-12 / 59.70元    
</p>
而对于这样的结构，在htmlnodes()函数里的写法就是简单的 "p.pl"，其中“.”表示class属性的值，如果是id属性则用“#”，如果大家学过CSS选择器就很好理解了，是完全一致的。

最后我们用html_text()函数表示获取文本信息，否则返回的是整个<p>标签。总体上用以下一行代码就可以实现：


# Example 2

到天气网(http://lishi.tianqi.com/)抓取特定页面的数据, 首先需要在浏览器中调试js代码，chrome中按F12即可查看。通过搜索关键字：日期，最高气温 ...任何一个都行，得到以下信息。可以发现我们所需要的数据都在<div class="tqtongji2">盒子中，而每一行数据又都在ul中。所以，我们可以通过这两个特征来提取数据。

获取<div class="tqtongji2">以及ul中内容的R代码如下：
```{r}
library(rvest)
library(plyr)
city <- 'guangzhou'
date <- '201709'
baseUrl <- 'http://lishi.tianqi.com/'
Url <- paste(baseUrl, city, '/', date, '.html', sep = '')

content <- Url %>%
  read_html(encoding='GBK') %>%
  html_nodes('div.tqtongji2') %>%
  html_nodes("ul") %>%
  html_text()

head(content)
```

发现数据之间用rntt之类的隔开。而'rntt'这些里面有：回车符，换行符和制表符。他们的共同点就是全都是空格。所以我们可以通过空格来进行分列，提取相应的数据。
```{r}
content <-  content %>% strsplit("\\s{4,}")
content
```


为了美观和方便操作，我们把它转换为数据框的形式：
```{r}
content <- ldply(content[-1])
names(content) <- c('date', 'highDegree', 'lowDegree', 'weather', 'windDirection', 'windForce')
content
```

https://segmentfault.com/a/1190000011498596

# Example 3 R 爬虫之 rvest 包 ：穿越表单 + 图片下载器

什么是会话？会话的出现是为了跟踪 cookie，保证 cookie 长期有效，只有当会话被关闭时，cookie 便会失效。你可以把会话（Session）想象成在浏览器中打开的页面窗口，你之所以可以在这个窗口执行很多操作，这是因为服务器端知道你的 cookie 中存在有效的 SessionID，所以服务器会一直通过你的请求，把资源给你。

为什么要创建会话？后面我们将实现表单穿越时，需要保证是在会话窗口执行。

怎么创建会话？使用 html_session( ) 函数。

```{r}
u <- "https://movie.douban.com/"
session <- html_session(u)
```


什么是表单？HTML 中的表单被用来搜集用户的不同类型的输入。例如，登录表单、搜索框表单等。HTML 表单 <form> 包含表单元素，表单元素是指不同类型的 input 元素、复选框（box）、单选（radio）、提交按钮（submit）等。

怎么穿越表单？分为以下几步：

提取出你所需要的表单：html_form( )
填写你的表单：set_values(form, name1=value1, name2=value2)
提交表单，发送给服务器：submit_form(session, form)

```{r}
forms <- session %>% html_form()
forms
form <- forms[[1]] # forms 中的第一个列表是我们的目标列表
form
```

在上面的结果中，只有`<imput text> 'search_text' : `的冒号后为空，这表明 'search_text' 还没有填充任何值，而我们的填充任务就是把它填上。比如说我要搜索“美人鱼”，那么我就在set_values( ) 中指定一个 search_text 参数，令它的值为“美人鱼”。

那么，现在我们的表单已经填充好了，只需要把它提交给服务器了。
```{r}
filled_form <- set_values(form, search_text = "美人鱼")
session2 <- submit_form(session, filled_form)
session$url # 查看初始 session 的 url
session2$url # 查看提交表单后，返回的新会话 session2 的 url
iconv(URLdecode(session2$url), "UTF8")
```

显然，在提交表单后，我们访问的链接发生了变化。

PS：session2$url 之所以会有一堆 `%A %B` 之类的符号，是因为我们搜索的文本是中文，所以提交请求时，链接中的中文被再次编码。执行下面语句，便可以将链接变成我们能看懂的形式：
