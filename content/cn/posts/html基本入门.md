---
title: "html基本入门"
date: 2019-08-27T13:42:27-05:00
author: KJY
slug: html_intro
draft: false
toc: true
categories:
  - test
tags:
  - article
---


HTML 不是一门编程语言，而是一种用于定义内容结构的_标记语言_。HTML 由一系列的**元素（elements）**组成，这些元素可以用来包围不同部分的内容，使其以某种方式呈现或者工作。 一对标签（ tags）可以为一段文字或者一张图片添加超链接，将文字设置为斜体，改变字号，等等。 例如，键入下面一行内容：

键入下面一行内容：

```
我的猫咪脾气非常暴躁
```

可以将这行文字封装成一个段落（**p**aragraph）元素来使其在单独一行呈现：

```
<p>我的猫咪脾气非常暴躁</p>
```

___

### HTML元素的剖析

让我们进一步探讨该段落元素。

![](https://www.runoon.com/wp-content/uploads/2021/01/element-p-1.png)

元素的主要部分如下：

1.  **开头标记：**它由元素的名称（在本例中为p）组成，并包装在开始和关闭**尖括号中**。这说明了元素开始或开始生效的位置-在这种情况下，段落开始了。
2.  **结束标记：**与开始标记相同，不同之处在于它在元素名称之前包含一个_正斜杠_。这说明了元素的结尾，在这种情况下，段落的结尾。未能添加结束标记是标准的初学者错误之一，并且可能导致奇怪的结果。
3.  **内容：**这是元素的内容，在这种情况下，只是文本。
4.  **元素：**开始标签，结束标签和内容共同组成元素。

元素也可以具有如下所示的属性：

![](https://www.runoon.com/wp-content/uploads/2021/01/attribute-1-1024x152.png)

属性包含有关您不想出现在实际内容中的元素的额外信息。在这里，`class`是属性_名称_ ，`editor-note`是属性_值_。通过该`class`属性，您可以为元素提供一个非唯一的标识符，该标识符可用于`class`样式信息和其他信息。

属性应始终具有以下内容：

1.  它与元素名称（如果元素已经具有一个或多个属性，则为上一个属性）之间的空格。
2.  属性名称后跟等号。
3.  用引号引起来的属性值。

**注意**：不包含ASCII空格（或任何字符`"` `'` `` ` `` `=` `<` `>`）的简单属性值可以不加引号，但是建议您对所有属性值加引号，因为这会使代码更一致和更易理解。

___

### 嵌套元素

您也可以将元素放入其他元素中-这称为**嵌套**。如果要说明“我们的猫脾气**非常**暴躁”，可以将“非常”一词包裹在一个[`<strong>`](https://www.runoon.com/html/tags/html-strong-tag.html)元素中，这意味着特别强调该词：

```
<p>我的猫咪脾气<strong>非常</strong>暴躁:)</p>
```

但是，要确保元素正确嵌套。在上面的示例中，我们[`<p>`](https://www.runoon.com/html/tags/html-p-tag.html)首先打开了元素，然后打开了`<strong>`元素；因此，我们必须先关闭`<strong>`元素，然后再关闭`<p>`元素。以下是不正确的：

```
# right
<p>我的猫咪脾气<strong>非常暴躁</strong></p>
# wong
<p>我的猫咪脾气<strong>非常</p>暴躁</strong>
```

这些元素必须正确地打开和关闭，以使它们清楚地位于彼此内部或外部。如果它们如上所示重叠，则您的Web浏览器将尝试对您要说的内容做出最佳猜测，这可能会导致意外结果。

___

### 空元素

一些元素没有内容，被称为**空元素**。采取[`<img>`](https://www.runoon.com/html/tags/html-img-tag.html)我们在HTML页面中已经拥有的元素：

```
<img src="/img/earth.jpg" alt="地球">
```

它包含两个属性，但是没有结束`</img>`标记，也没有内部内容。其目的是将图像嵌入HTML页面中。

___

### HTML文档剖析

总结了各个HTML元素的基础知识。现在，我们将研究如何将单个元素组合以形成整个HTML页面。让我们重新看一下`index.html`示例中放入的代码：

```
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>测试页面</title>
  </head>
  <body>
    <img src="/img/earth.jpg" alt="地球">
  </body>
</html>
```

在这里，我们有以下内容：

-   `<!DOCTYPE html>`— doctype。这是必需的序言。在HTML出现之初（大约1991/92年），doctype旨在充当指向一组规则的链接，HTML页面必须遵循这些规则才能被认为是好的HTML，这可能意味着自动错误检查和其他有用的东西。
-   `<html></html>`—[`<html>`](https://www.runoon.com/html/tags/html-html-tag.html)元素。该元素将所有内容包装在整个页面上，有时也称为根元素。
-   `<head></head>`—[`<head>`](https://www.runoon.com/html/tags/html-head-tag.html)元素。此元素充当您要包含在HTML页面上的所有内容的容器，_而不是_您要显示给页面查看器的内容。其中包括您想要出现在搜索结果中的关键字和页面描述，用于设置内容样式的CSS，字符集声明等内容。
-   `<meta charset="utf-8">`—该元素将文档应使用的字符集设置为UTF-8，其中包括绝大多数书面语言中的大多数字符。从本质上讲，它现在可以处理您可能要放在其上的任何文本内容。没有理由不进行设置，这样可以避免以后出现一些问题。
-   `<title></title>`— [`<title>`](https://www.runoon.com/html/tags/html-title-tag.html) 元素。这将设置页面的标题，即页面加载到的浏览器选项卡中显示的标题。当您添加书签/收藏夹时，它也用于描述页面。
-   `<body></body>`—[`<body>`](https://www.runoon.com/html/tags/html-body-tag.html)元素。其中包含您要向网络用户访问您的页面时显示给他们的_所有_内容，无论是文本，图像，视频，游戏，可播放的音轨还是其他内容。

一个更简单的例子

```
<html>                             ----根控制标记
    <head>                             ---头控制标记
        <title>这是标题</title>       ----标题标记
    </head>                            ----头控制标记
    <body>
                             ----- 我是Body！！！
    </body>
</html>                            ----根控制标记
```



___

### 图片元素

让我们`[<img>](https://www.runoon.com/html/tags/html-img-tag.html)`再次将注意力转移到元素上：

```
<img src="/img/earth.jpg" alt="地球"/>  
```

如我们之前所说，它将图像按其出现位置嵌入到我们的页面中。它通过`src`（source）属性执行此操作，该属性包含我们图像文件的路径。

我们还包括了`alt`（替代）属性。在此属性中，可能由于以下原因，为无法看到图像的用户指定描述性文本：

1.  有视力障碍的用户。有严重视力障碍的用户经常使用称为屏幕阅读器的工具向他们朗读替代文本。
2.  出现问题导致图像无法显示。例如，尝试故意更改`src`属性内的路径以使其不正确。如果您保存并重新加载页面，则应该在图像上看到以下内容：

```
地球
```

您编写的替代文本应为读者提供足够的信息，以使他们对图像所传达的内容有所了解。

___

### 标记文本

本段包含了一些最常用的文本标记 HTML 元素。

___

#### 标题（Heading）

标题元素可用于指定内容的标题和子标题。就像一本书的书名、每章的大标题、小标题，等。HTML 文档也是一样。HTML 包括六个级别的标题， [`<h1>`–`<h6>`](https://www.runoon.com/html/tags/html-h1-h6-tag.html) ，一般最多用到 3-4 级标题。

```
<h1>主标题</h1>
<h2>顶层标题</h2>
<h3>子标题</h3>
<h4>次子标题</h4>
```

可以尝试在 `<img>` 元素上面添加一个合适的标题。

注：可以发现 MDN 网站上 第一级标题的主题是隐藏的。不要使用标题元素来加大、加粗字体，因为标题对于 无障碍访问 和 搜索引擎优化 等问题非常有意义。要保持页面结构清晰，标题整洁，不要发生标题级别跳跃。

___

#### 段落（Paragraph）

如上文所讲，[`<p>`](https://www.runoon.com/html/tags/html-p-tag.html) 元素是用来指定段落的。通常用于指定常规的文本内容：

```
<p>这是一个段落</p>
```

试着添加一些文本到一个或几个段落中，并把它们放在你的 `<img>` 元素下方。

___

#### 列表（List）

Web 上的许多内容都是列表，HTML 有一些特别的列表元素。标记列表通常包括至少两个元素。最常用的列表类型为：

1.  **无序列表（Unordered List）**中项目的顺序并不重要，就像购物列表。用一个 [`<ul>`](https://www.runoon.com/html/tags/html-ul-tag.html) 元素包围。
2.  **有序列表（Ordered List）**中项目的顺序很重要，就像烹调指南。用一个 [`<ol>`](https://www.runoon.com/html/tags/html-ol-tag.html) 元素包围。

列表的每个项目用一个列表项目（List Item）元素 [`<li>`](https://www.runoon.com/html/tags/html-li-tag.html) 包围。

比如，要将下面的段落片段改成一个列表：

```
<p>这里聚集着来自五湖四海的技术人员、思考者和建造者，我们致力于……</p>
```

可以这样更改标记：

```
<p>这里聚集着来自五湖四海的</p>

<ul>
  <li>技术人员</li>
  <li>思考者</li>
  <li>建造者</li>
</ul>

<p>我们致力于……</p>
```

试着在示例页面中添加一个有序列表和无序列表。



一些常用标签

```
<h1~h6>:从大到小. 表示标题.
 
<p>: 段落标签. 包裹的内容被换行.并且也上下内容之间有一行空白.
 
<b> <strong>: 加粗标签.
 
<strike>: 为文字加上一条中线.
 
<em>: 文字变成斜体.
 
<sup>和<sub>: 上角标 和 下角表.
 
<br/>:换行. 单标签
 
<hr>:水平线
 
<div> :块，主要用于布局
 
<span>：内联标签
```



___

### 链接

链接非常重要 — 它们赋予 Web 网络属性。要植入一个链接，我们需要使用一个简单的元素 — [`<a>`](https://www.runoon.com/html/tags/html-hyperlink-a-tag.html) — a 是 “anchor” （锚）的缩写。要将一些文本添加到链接中，只需如下几步：

1.  选择一些文本。比如 “HTML教程”。
2.  将文本包含在 `<a>` 元素内，就像这样：`<a>HTML教程</a>`
3.  为此 `<a>` 元素添加一个 `href` 属性，就像这样：`<a href="">HTML教程</a>`
4.  把属性的值设置为所需网址：`<a href="https://www.runoon.com/html/">HTML教程</a>`

如果网址开始部分省略了 `https://` 或者 `http://`，可能会出现错误的结果。在完成一个链接后，可以试着点击它来确保指向正确。

`href` 这个名字可能开始看起来有点令人费解，代表超文本引用（ **h**ypertext **ref**erence）。

___



### html和css以及javascript的关系



HTML是超文本标记语言的简称，它是一种不严谨的、简单的标识性语言。它用各种标签将页面中的元素组织起来，告诉浏览器该如何显示其中的内容。

为什么说HTML是不严谨的呢？因为HTML标签即使不闭合，也并不会影响页面内容的组织。

CSS是用来修饰内容样式的（重在内容样式美化展示上）

CSS是层叠样式表的简称，它用来表现HTML文件样式的，简单说就是负责HTML页面中元素的展现及排版。

JavaScript是用来做交互的

JavaScript是一种脚本语言，即可以运行在客户端也能运行在服务器端。JavaScript的解释器就是JS引擎，JS引擎是浏览器的一部分。而JavaScript主要是用来扩展文档交互能力的，使静态的HTML具有一定的交互行为（比如表单提交、动画特效、弹窗等）。

如果把HTML比做身体，那CSS就好比是衣服，而JavaScript则意味着人能做的一些高级动作。

1、什么是HTML（超文本标记语言 **H**yper **T**ext **M**arkup **L**anguage），HTML 是用来描述网页的一种语言。
2、CSS(层叠样式表 *C*ascading *S*tyle *S*heets),样式定义如何显示 HTML 元素，语法为：selector {property：value} (选择符 {属性：值})
3、JavaScript是一种脚本语言，其源代码在发往客户端运行之前不需经过编译，而是将文本格式的字符代码发送给**浏览器**由浏览器解释运行

对于一个网页，HTML定义网页的结构，CSS描述网页的样子，JavaScript设置一个很经典的例子是说HTML就像 一个人的骨骼、器官，而CSS就是人的皮肤，有了这两样也就构成了一个植物人了，加上javascript这个植物人就可以对外界刺激做出反应，可以思 考、运动、可以给自己整容化妆（改变CSS）等等，成为一个活生生的人。

在 Web 开发中，后端有很多编程语言可以选择，但前端只有 JavaScript，JavaScript是所有浏览器唯一都支持的编程语言。JavaScript如此强势，尽量再不喜欢，不管是前端还是后端都要求有一定的javascript编程能力，但是有没有什么方法来简化Javascript的开发呢？答案是有的，各种javascript程序库应运而生，如jQuery、Prototype、MooTools。



```css
details {
  font: 16px "Open Sans", "Arial", sans-serif;
  width: 620px;
}

details > summary {
  padding: 2px 6px;
  width: 15em;
  background-color: #ddd;
  border: none;
  box-shadow: 3px 3px 4px black;
}

details > p {
  border-radius: 0 0 10px 10px;
  background-color: #ddd;
  padding: 2px 6px;
  margin: 0;
  box-shadow: 3px 3px 4px black;
}
```

```
<details>
<summary>Copyright 1999-2011.</summary>
<p> - by Refsnes Data. All Rights Reserved.</p>
<p>All content and graphics on this web site are the property of the company Refsnes Data.</p>
</details>
```

<details> <summary>Copyright 1999-2011.</summary> <p> - by Refsnes Data. All Rights Reserved.</p> <p>All content and graphics on this web site are the property of the company Refsnes Data.</p> </details>



目前，只有 Chrome 和 Safari 6 支持 <details> 标签。