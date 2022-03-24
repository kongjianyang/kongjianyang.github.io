---
title: MacOS下最简单的升级R和R包的方式
author: Liang
date: '2018-11-24'
slug: MacOS下最简单的升级R和R包的方式
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
# 升级R
```
#安装devtools包（如果已经安装 跳过此步，进入到下一步）
install.packages('devtools')
library('devtools')
 
#安装updateR
install_github('andreacirilloac/updateR')
library(updateR)
 
#更新
updateR(admin_password = 'os_admin_user_password')
```

Reference:

[UpdateR package: update R version with a function (on MAC OSX)](https://andreacirilloblog.wordpress.com/2015/10/22/updater-package-update-r-version-with-a-function-on-mac-osx/)

# 升级R包
使用rvcheck::update_all()可以自动更新CRAN, Bioconductor和Github上的R包。其实可以放到系统任务里，每月自动更新一次，然后就可以完全不用管升级的事情。

