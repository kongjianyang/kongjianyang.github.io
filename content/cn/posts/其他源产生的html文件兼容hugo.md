---
title: "其他源产生的html文件兼容hug"
date: 2022-05-07T19:10:27-04:00
author: KJY
slug: html
draft: false
toc: true
categories:  
  - hugo
tags:        
  - article
---

迁移博客系统之后之前一些产生的html文件不能在hugo系统中显示了，例如从rmd或者jupyter生产的html文件，尝试之后发现问题是生产的html文件没有frontmatter，加上之后就能解决问题。

参考：[[SOLVED\] Using HTML for content pages instead of Markdown - support - HUGO (gohugo.io)](https://discourse.gohugo.io/t/solved-using-html-for-content-pages-instead-of-markdown/3374/2)

所以在html文件上加下如下内容就能使之显示。

```
+++
title = "R语言元编程"
date = "2020-04-17T12:15:02-00:00"
categories = "R"
tags = "R"
+++
<!DOCTYPE html>

<html>
```

Front-matter 是文件最上方以 `---` 分隔的区域，用于指定个别文件的变量，举例来说：

```
---
title: Hello World
date: 2013/7/13 20:46:25
---
```

# 补充知识

仅仅使用 markdown 格式写完文章是不够的，还需要在 .md 文档前面声明文档的信息，告诉 Hugo 这篇文章的标题、写作时间，这个时候就需要用到 Hugo Front Matter Formats 元数据格式。

`Front Matter`一般放在文章的最顶部，Hugo支持三种书写格式，

1. `TOML`使用`+++`来包裹内容
2. `YAML`使用`---`来包裹内容
3. `JSON`使用`{`和`}`来包裹内容

可配置的内容见Hugo官方文档: [front-matter](https://gohugo.io/content-management/front-matter/)。

在使用`hugo new`来创建文章时，会查找`archetypes`下的内容并填充到文章内容，查找`archetypes`原型内容的顺序如下:

1. archetypes/posts.md
2. archetypes/default.md
3. themes/my-theme/archetypes/posts.md
4. themes/my-theme/archetypes/default.md

建议修改原型中的内容为自己需要的内容，这样不用每次创建文章都需要手动去`Front Matter`中添加或删除一下字段属性。

更多的相关操作请查阅Hugo官方文档: [archetypes](https://gohugo.io/content-management/archetypes/)。



