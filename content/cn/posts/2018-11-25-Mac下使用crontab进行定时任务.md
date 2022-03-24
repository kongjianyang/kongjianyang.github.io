---
title: Mac下使用crontab进行定时任务
author: Liang
date: '2018-11-25'
slug: Mac下使用crontab进行定时任务
categories:
  - Linux技巧
tags: []
lastmod: '2018-11-25T21:42:11-05:00'
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

## 1. 开启 crontab

crontab意思是排程命令，查看 crontab 是否启动

```
sudo launchctl list | grep cron
```

检查需要的文件

```
ls -al /etc/crontab
```

如果 crontab 文件不存在则创建

```
sudo touch /etc/crontab
```

## 2. 添加定时任务

```
# 打开定时任务设定文件
crontab -e
```

举个例子, 每分钟输出当前时间到time.txt上.

`
*/1 * * * * /bin/date >> ~/Desktop/time.txt
`

查看任务列表

```
crontab -l
```

删除任务

```
# 打开定时任务设定文件
crontab -e
```

可以像使用vi编辑其他任何文件那样修改crontab文件并退出。

删除crontab文件

```
crontab -r
```

可以加上邮件通知

```
# send email to me
MAILTO="your email stress"
```


```
git push origin master
```

如果上步错误的话，可以用下面的命令

```
git remote set-url origin git@github.com:username/repo.git
```

## 3. 语法

```
格式：分 时 日 月 星期几 命令
# 每天12点1分执行[/example/laohou-cron.sh]命令
实例：1 12 * * * /example/laohou-cron.sh
＃ * 全部的意思，例如下面，每分钟执行一次
实例：* * * * * /example/laohou-cron.sh
```
