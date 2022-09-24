---
title: "利用Python进行文件重命名"
date: 2022-09-24T19:10:27-04:00
author: KJY
slug: Python
draft: false
toc: true
categories:  
  - hugo
tags:        
  - article
---



```python
# !#/usr/bin/python3
import os
import re
import datetime

dir = os.getcwd()
files = os.listdir("./")
# 判断字符串
oldStr = r"(\d{4}-\d{1,2}-\d{1,2}-)"
newStr = ""

#判断生成时间
now = datetime.datetime.now()
deltaH = datetime.timedelta(days=360)

d = os.walk(dir)
for path,dirList,fileList in d:
    for fileName in fileList:
        oldFile = os.path.join(path, fileName)
        if re.findall(oldStr, fileName):
            f = datetime.datetime.fromtimestamp(os.path.getmtime(oldFile))
            if f > (now-deltaH):
                print(oldFile)
                newName = re.sub(oldStr, newStr, fileName)
                newFile = os.path.join(path, newName)
                if os.path.isfile(oldFile):
                    os.rename(os.path.join(path, fileName),newFile)
                    print(newFile)
                    pass
            else:
                pass
```

