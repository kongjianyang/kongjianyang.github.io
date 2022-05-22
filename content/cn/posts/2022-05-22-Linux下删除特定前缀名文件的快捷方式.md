---
title: "Linux下删除特定前缀名文件的快捷方式"
date: 2022-05-22T10:43:55-06:00
author: KJY
slug: find_remove
draft: false
toc: true
categories:  
  -Linux
tags:        
  - article
---

有时候folder下会有奇怪前缀名的文件，如下

```shell
./~$Varian_Intern3.pptx
./~$Varian_Interview_With_Director.pptx
./~$Varian_Intern2.pptx
```

通过正常rm是没有办法删除的，这时候可以使用find的功能进行删除

```shell
find . -name ~$\* -delete
```

这样就可以找到并且删除文件了

