---
title: -bash_profile和-bashrc的区别
author: Liang
date: '2018-11-24'
slug: -bash_profile和-bashrc的区别
categories:
  - Linux技巧
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
`/etc/profile` 此文件为系统的每个用户设置环境信息,当用户第一次登录时,该文件被执行.并从`/etc/profile.d`目录的配置文件中搜集shell的设置。
`/etc/bashrc` 为每一个运行bash shell的用户执行此文件.当bash shell被打开时,该文件被读取。
`~/.bash_profile` 每个用户都可使用该文件输入专用于自己使用的shell信息,当用户登录时,该文件**仅仅执行一次**! 默认情况下,他设置一些环境变量,执行用户的`.bashrc`文件。
`~/.bashrc` 该文件包含专用于你的bash shell的bash信息,当登录时以及每次打开新的shell时,该该文件被读取。
`~/.bash_logout` 少见，但是意味着当每次退出系统(退出bash shell)时,执行该文件。

另外`/etc/profile` 中设定的变量(全局)的可以作用于任何用户, 而`~/.bashrc` 等中设定的变量(局部)只能继承 `/etc/profile` 中的变量,他们是"父子"关系。
 
`profile`用于登录式shell, 而`bashrc`用于每个交互式shell
`~/.bash_profile` 是交互式、login 方式进入 bash 运行的
`~/.bashrc` 是交互式 non-login 方式进入 bash 运行的
通常二者设置大致相同，所以通常前者会调用后者。
所以一般优先把变量设置在`.bashrc`里面。比如在crontab里面执行一个命令，`.bashrc` 设置的环境变量会生效，而 `.bash_profile` 不会。

设置生效：可以重启生效，也可以使用命令：`source `
```
source /etc/profile
```
