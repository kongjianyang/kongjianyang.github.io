---
title: "Snippet工具使用介绍"
date: 2019-11-23T14:42:27-05:00
author: KJY
slug: dash
draft: false
toc: true
categories:
  - tools
tags:
  - article
---

片段（Snippet）是一個編程用語，指的是原始碼、機器碼、文本中可重複使用的小區塊。通常它們是有正式定義的執行單位，以納入更大的編程模塊。也就是只需要输入少数的几个特定字符，编辑器便能帮我们自动补全为模板代码。目前几乎所有主流编辑器和 IDE 都支持这项功能，如 Eclipse, Sublime Text, Visual Studio Code 和 Atom。

市面上有很多的Snippet管理工具。

# Alfred

参考这个文章：[真正提升你的输入效率，从用好 Alfred 的这个功能开始：Alfred Snippets - 少数派 (sspai.com)](https://sspai.com/post/46034)

注：Snippets 为 Alfred 的付费功能，需购买 [Powerpack](https://www.alfredapp.com/powerpack/) 后才能使用。）

打开 Alfred 的设置菜单，找到 Features 里面的 Snippets，你可以看到下图这个设置面板：

![](https://cdn.sspai.com/2018/08/07/2bf59a786c43f7c7761d00a925e828e1.jpg)

设置

想要创建 Snippets，首先要建立一个 Collection（集合）。点击左侧 Collection 底部的 「+」号，输入集合的名字。

在设置中，你可以选择是否为这个 Collection 设置一个前缀或者后缀，这个功能的主要目的是为了方便区分，当你在使用时，通过输入前缀或者后缀可以快速显示某一个集合内的所有 Snippets。我们在这里给这个名为「Personal」的 Collection 添加一个「!」作为前缀。

![](https://cdn.sspai.com/2018/08/07/9b4adfc97c8d87711d95e26d64de84ac.jpg)

添加 Collection 后，就可以来创建你的第一个 Snippets 了。点击右侧底部的「+」，输入 Snippets 的名字和关键词，然后在下方输入你希望拓展的内容。在这里以添加个人邮箱为例，在上面的 Keyword 里填入「GM」作为关键词，然后下方输入 myemail@gmail.com，点击 Save 来保存，这样我们就创建了一条 Snippets。

![](https://cdn.sspai.com/2018/08/07/2afb774daa296cfd0fb567c84c50dd1b.jpg)

## 如何使用 Snippets

接下来我们来看看如何使用刚刚创建的 Snippets。回到 Snippets 设置菜单，在右上角你可以找到 Automatically expand snippets by keyword，打开这个选项后你才能在 macOS 中直接输入关键词来进行拓展（第一次打开时需要在「系统设置 - 隐私 - 辅助功能」中开启服务），否则就需要每次手动进行粘贴。

如果你希望在一些应用中关闭 Snippets 拓展，可以选择 Auto Expansion Options，打开 Finder 里的应用程序，将希望关闭 Snippets 的应用拖到列表里即可。

![](https://cdn.sspai.com/2018/08/07/e00502b2fce4d3476c918ea862033686.png)

设置完成后，你就可以在 macOS 里输入关键词「!GM」使用 Snippets 了。值得一提的是，Alfred 的快速拓展功能支持中文输入法下使用，这样你就不用来回切输入法了。

![](https://cdn.sspai.com/2018/08/07/ade8289592e9bcce9edb919158dc67a2.gif)

效果

## 进阶一步，用 Snippets 输入年月日

写邮件的时候，往往需要在最后附上当天的日期。对于这个需求，我们也可以用 Snippets 来完成。

![](https://cdn.sspai.com/2018/08/07/222d90ddd23428b9860a85445b8c88ec.gif)

创建一个新的 Snippets，点击下方左侧的 { }，选择 Date and Time。在这里你可以看到一些默认设置好的动态占位符，你可以根据需要选择显示日期（Date）、时间（Time）和同时显示日期和时间（Date and Time）。

![](https://cdn.sspai.com/2018/08/07/451c7b09a1c10e340fc6c93e6a1d3e05.png)

这里需要注意的是时间显示的格式。你可以看到在选项的后面有 full、long、medium 和 short 这四种格式，这分别对应着系统设置中「语言和地区」选项里的四种格式，如果有需要的话可以根据情况自己修改。

![](https://cdn.sspai.com/2018/08/07/9187ec97311bdca76c09f86c5a63e840.png)

略有遗憾的是，目前 Alfred 的时间输入还不支持中文，所以一般都会使用 short 的格式进行显示，希望日后 Alfred 可以更新支持。

# Dash

## 1\. 功能简介

官方用一句话就概括了它的用途：Dash是一个API文档浏览器（ API Documentation Browser），以及代码片段管理工具（Code Snippet Manager）。你没看错，它就只有这两个功能，但确实是程序员（至少对于我来说）最为关心的特性，自己之前也用过了不少类似的工具，可以毫不夸张地说，Dash是它们之中做的最好的一个！

目前dash已经收费了

## 2\. 下载

关于下载我还是推介官网下载吧([https://kapeli.com/dash](https://link.jianshu.com/?t=https://kapeli.com/dash))

## 3\. 强悍的API文档浏览、搜索功能

想必这个功能是大家最常用的了吧，每天要反复查看、搜索那么多的API细节，没有一个好工具，单靠自己的双手如何应付得来？窗口不停的切来切去，很烦啊！Dash采用集成单一窗口的方式，很好的解决了这个问题。看下面的截图：

  

![](https://upload-images.jianshu.io/upload_images/1637794-055e02e7ad04bbee.jpg?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

点击查看原始大小图片

上图便是Dash的API浏览器主界面：左侧边栏是各种编程语言以及框架（取决于你下载安装了多少文档集合）的导航大纲，点击某个节点，右边的内容区域就是文档的详细信息啦，非常直观。也可以在左上方的搜索框内通过输入关键字，查找相关的API文档，非常类似全文检索的实现方式，Dash的响应速度非常快！关键是可以同时查询不同的语言、框架内容，实在是太方便了。看到这里你也许要问了，这跟我们平常切换到特定的文档窗口（比如一个PDF或者一个CHM文件），再ctrl + f查找有什么区别，不是多此一举吗？其实你错了，Dash可以通过快捷键来显示、隐藏文档窗口，它提供了配置界面以便用户自行设置（我比较习惯alt+space，因为其他软件很少用到这个组合键）：

Dash自带了丰富的API文档，涉及各种主流的编程语言和框架，全列出来很吓人的：

而且它的文档库采用了docset格式，高级用户基于网站提供的教程，很容易就能自行添加其他的扩充文档，其实Dash在最初发布的时候，只支持很少的几个文档浏览，好像只有Java、HTML、CSS这些，是后来通过用户不断贡献，以及作者及时的反馈（Rails API就是我通过Email与作者联系，请求添加的，作者非常nice），逐步壮大，才具备了如此广泛的语言、框架支持。要添加API文档，打开软件配置界面，切换到Docset选项卡即可看到所有内置的文档列表，按需要自行下载即可（如果是自己制作的docset，双击即可导入Dash）：

 

![](https://upload-images.jianshu.io/upload_images/1637794-3b8e11690d94611a.jpg?imageMogr2/auto-orient/strip|imageView2/2/w/448/format/webp)

## 4\. 牛逼、好用的代码片段管理功能

这也是我最喜欢的一个功能

不得不说这个简直就是程序员的神器,大大的提高的程序的开发效率。  
前面说完了Dash的文档查询功能，下面再来看一看它带给我们的另一个惊喜：代码片段管理。说到这里，之前的版本其实有个很不好的地方，就是如果不仔细琢磨一下，或者去看官方的帮助文档的话，用户是很难一眼就知道怎么用这个功能，新手引导做得确实不怎么样，不过最新版已经改善了这个问题，在主界面的导航边栏明确地给出了分类提示，创建或者修改代码片段都方便了许多。来看下面这个例子：

  

![](https://upload-images.jianshu.io/upload_images/1637794-5d45d4cbc4cdf183.jpg?imageMogr2/auto-orient/strip|imageView2/2/w/693/format/webp)

利用Dash的代码片段管理功能，我们可以把日常使用频繁（也就是你经常需要复制粘贴）的代码保存起来，然后为其设置一个独一无二的缩写，这样一来原本需要一遍又一遍的敲击键盘重复录入的繁琐工作，就可以交给Dash来帮你搞定啦。比如上面截图中的例子，就是ExtJS中发起Ajax请求的代码片段，哪怕是copy & paste，时间长了也会很烦的，我给它设置了一个缩写（ajax），以后在需要编写这段代码的时候，就只需要敲击这几个字母，它就会魔法般的出现在光标所在位置啦！很神奇吧？嘿嘿，其实这种扩展缩写的功能，还有很多软件都能做到，比如TextExpander（这个我也买了，半价14刀的时候，但是现在已经打入冷宫了，比较后悔），不过就用户体验和各种细节，诸如界面UI，特别是扩展占位符的处理上，目前还没有哪一个能比得过Dash的（Dash is the best!）。来看看使用代码片段的截图吧：

  

![](https://upload-images.jianshu.io/upload_images/1637794-b73057515023d5a2.jpg?imageMogr2/auto-orient/strip|imageView2/2/w/838/format/webp)

点击查看原始大小图片

Dash的缩写扩展功能很强大，比方说上面那个例子，在保存代码片段的时候，你可以使用双下划线标明占位符，在执行扩展的时候就可以通过tab键来在各个占位符之间切换，根据需要输入实际的值，最后回车即可把片段粘贴到光标所在之处。除了占位符，它还支持下面这些变量符号：  
@clipboard 自动插入当前剪贴板中的内容  
@cursor 代码片段粘贴完毕之后，自动将光标定位到此处  
@date 自动插入当前日期  
@time 自动插入当前时间



# 其他

其他的一些snippet工具还包括

免费的 snippet 工具 massCode 

CodeBox的snippet管理功能比Dash强大太多了，居然还带版本管理

以及SnippetsLab



但是我最推荐的还是Alfred
