---
title: "Linux上的定时任务"
date: 2022-05-17T19:10:27-04:00
author: KJY
slug:  Crontab
draft: false
toc: true
categories:  
  - linux
tags:        
  - article
---



# 介绍



我们经常使用的是crontab命令是cron table的简写，它是cron的配置文件，也可以叫它作业列表



我们常用的命令如下：

```
crontab [-u username]　　　　//省略用户表表示操作当前用户的crontab
    -e      (编辑工作表)
    -l      (列出工作表里的命令)
    -r      (删除工作作)
```

我们用**crontab -e**进入当前用户的工作表编辑，是常见的vim界面。每行是一条命令。

Each line of a crontab file represents a job, and looks like this:

```
# ┌───────────── minute (0 - 59)
# │ ┌───────────── hour (0 - 23)
# │ │ ┌───────────── day of the month (1 - 31)
# │ │ │ ┌───────────── month (1 - 12)
# │ │ │ │ ┌───────────── day of the week (0 - 6) (Sunday to Saturday;
# │ │ │ │ │                                   7 is also Sunday on some systems)
# │ │ │ │ │
# │ │ │ │ │
# * * * * * 
```

The syntax of each line expects a cron expression made of five fields which represent the time to execute the command, followed by a shell command to execute.



crontab的命令构成为 时间+动作，其时间有**分、时、日、月、周**五种，操作符有

- ***** 取值范围内的所有数字
- **/** 每过多少个数字
- **-** 从X到Z
- **，**散列数字





# 例子



编写一个需要执行的文件 avoid_purge.sh

```
#!/bin/bash
purgelist | tail -n +9 > purgelist.txt

echo "Start"

cat purgelist.txt | while read LINE
do
head $LINE
done


echo "Done"
```



编写一个执行文件 run.sh 



```
#!/bin/bash

cd /home/tang389/

bash avoid_purge.sh > log.out
```



给run.sh和avoid_purge.sh赋予执行权限



```
chmod -x run.sh
chmod -x avoid_purge.sh
```



命令行输入（不指定用户的话，默认当前用户的定时任务）

```
crontab -e
```

此命令输完之后，会让我们选择编辑器，选择vim，之后会出来一个编辑页面，输入一下内容

```
50 14 * * * /bin/sh /home/tang389/run.sh
```



表示每天的13点28定时执行run.sh脚本任务
