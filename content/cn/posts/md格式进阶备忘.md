---
title: markdown格式进阶备忘
author: Liang
date: '2018-12-02'
slug: md格式进阶备忘
categories:
  - Linux技巧
tags: []
lastmod: '2018-12-02T01:11:51-05:00'
keywords: []
description: ''
comment: no
toc: no
autoCollapseToc: no
postMetaInFooter: no
hiddenFromHomePage: no
contentCopyright: no
reward: no
mathjax: yes
mathjaxEnableSingleDollar: yes
mathjaxEnableAutoNumber: yes
hideHeaderAndFooter: no
flowchartDiagrams:
  enable: no
  options: ''
sequenceDiagrams:
  enable: no
  options: ''
---

HTML是英文Hyper Text Mark-up Language (超文本标记语言) 的缩写，则Markdown的意思可能是反标记，因为markup是标记。

## 1. 任务列表

```
- [ ] 任务一 未做任务 
- [x] 任务二 已做任务
```

- [ ] 任务一 未做任务 
- [x] 任务二 已做任务


## 2. 删除线 & 分割线

```
~~需要加删除线的内容~~
<del>需要加删除线的内容</del>
```
效果：

~~需要加删除线的内容~~

<del>需要加删除线的内容</del>

```
***
*****
- - -
```

效果：

***
*****
- - -

## 3. 简单公式

```
$$E=mc^2$$
```

效果：

$$E=mc^2$$

## 4. 嵌套引用

```
> 这是外层的引用

> > 这是内层的引用
```

> 这是外层的引用

> > 这是内层的引用

## 5. 表格

其中的一个例子

```
| Table | Col1 | Col2 |
| ----- |:----:| ----:|
| Row1  | 1-1  | 1-2  |
| Row2  | 2-1  | 2-2  |
| Row3  | 3-1  | 3-2  |
```

| Table | Col1 | Col2 |
| ----- |:----:| ----:|
| Row1  | 1-1  | 1-2  |
| Row2  | 2-1  | 2-2  |
| Row3  | 3-1  | 3-2  |

齐总的点代表对齐方式，分别是默认（居右）、居中、居左。
还可以使表格居中

```
<center>

| Table | Col1 | Col2 |
| ----- |:----:| ----:|
| Row1  | 1-1  | 1-2  |
| Row2  | 2-1  | 2-2  |
| Row3  | 3-1  | 3-2  |

<\center>
```

<center>

| Table | Col1 | Col2 |
| ----- |:----:| ----:|
| Row1  | 1-1  | 1-2  |
| Row2  | 2-1  | 2-2  |
| Row3  | 3-1  | 3-2  |

</center>


## 6. Emoji表情

```
:notes:
:exclamation:
:hatched_chick:
:dolphin:
```

:notes:
:exclamation:
:hatched_chick:
:dolphin:

[EMOJI CHEAT SHEET](https://www.webpagefx.com/tools/emoji-cheat-sheet/)

## 7. 字体颜色大小

```
<font face="黑体">我是黑体字</font>
<font face="微软雅黑">我是微软雅黑</font>
<font face="STCAIYUN">我是华文彩云</font>
<font color=#0099ff size=7 face="黑体">黑体，7号大小</font>
<font color=gray size=3>灰色，7号大小</font>
```

<font face="黑体">我是黑体字</font>

<font face="微软雅黑">我是微软雅黑</font>

<font face="STCAIYUN">我是华文彩云</font>

<font color=#0099ff size=3 face="黑体">黑体，3号大小</font>

<font color=gray size=7>灰色，7号大小</font>

Size：规定文本的尺寸大小。可能的值：从 1 到 7 的数字。浏览器默认值是 3

## 8. 背景色

Markdown本身不支持背景色设置，需要采用内置html的方式实现：借助 table, tr, td 等表格标签的 bgcolor 属性来实现背景色的功能。举例如下：

```
<table><tr><td bgcolor=orange>背景色是：orange</td></tr></table>
```

<center>

<table><tr><td bgcolor=orange>背景色是：orange</td></tr></table>

</center>


## 9. 插入图片大小居中

嵌入HTML代码

```
<img src="https://cdn.freebiesupply.com/logos/large/2x/purdue-university-4-logo-png-transparent.png" width = "300" height = "200" alt="Purdue" align=center />

<center>
<img src="https://cdn.freebiesupply.com/logos/large/2x/purdue-university-4-logo-png-transparent.png" width="25%" height="25%" />
Figure 1. Purdue Logo
</center>
```
<img src="https://cdn.freebiesupply.com/logos/large/2x/purdue-university-4-logo-png-transparent.png" width = "150" height = "150" alt="Purdue" align=center />


<center>
<img src="https://cdn.freebiesupply.com/logos/large/2x/purdue-university-4-logo-png-transparent.png" width="25%" height="25%" />
$ $
Figure 1. Purdue Logo
</center>

## 10. 下划线

```
<u>下划线文本</u>
```
<u>下划线文本</u>

## 插入音乐与视频

插入音乐

```
<iframe frameborder="no" border="0" marginwidth="0" marginheight="0" width=330 height=86 src="//music.163.com/outchain/player?type=2&id=27836172&auto=0&height=66"></iframe>

<iframe frameborder="no" border="0" marginwidth="0" marginheight="0" width="298" height="52" src="//music.163.com/outchain/player?type=2&id=27836172&auto=0&height=32"></iframe>
```

<iframe frameborder="no" border="0" marginwidth="0" marginheight="0" width=330 height=86 src="//music.163.com/outchain/player?type=2&id=27836172&auto=0&height=66"></iframe>

<iframe frameborder="no" border="0" marginwidth="0" marginheight="0" width="298" height="52" src="//music.163.com/outchain/player?type=2&id=27836172&auto=0&height=32"></iframe>


插入视频


```
[![Watch the video](https://img.youtube.com/vi/T-D1KVIuvjA/maxresdefault.jpg)](https://youtu.be/T-D1KVIuvjA)
```

[![Watch the video](https://img.youtube.com/vi/T-D1KVIuvjA/maxresdefault.jpg)](https://youtu.be/T-D1KVIuvjA)
