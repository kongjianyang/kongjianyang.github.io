---
title: macOS利用brew安装tree命令
author: Liang
date: '2018-11-24'
slug: macOS利用brew安装tree命令
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
### 01.问题
tree命令可以显示文件夹下的文件结构，是非常好用的一个命令工具，但是不是Unix的built-in命令，需要自行安装，本来利用Homebrew安装既可，但是macOS会报错，如
```
xcrun: error: invalid active developer path (/Library/Developer/CommandLineTools), missing xcrun
```

### 02.原因
这个问题产生的原因是没有更新OS X El Capitan，在MAC下，git命令是在Xcode命令工具下的。

###03.解决
首先就是升级OS X El Capitan，使用命令：
```
xcode-select --install
```
然后安装tree命令：
```
brew install tree
```
已经安装上了tree命令了。
