---
title: "Hugo文章加密"
date: 2022-04-30T19:10:27-04:00
author: KJY
slug: encryptor
draft: false
toc: true
categories:  
  - hugo
tags:        
  - article
---

参考的这个资料：

https://github.com/Li4n0/hugo_encryptor/blob/master/README-zh_CN.md

下载 Hugo-Encryptor 并安装其所需要的依赖库

```
$ git clone https://github.com/Li4n0/hugo_encryptor.git
$ cd hugo_encryptor
$ chmod +x hugo_encryptor.py
$ pip3 install -r requirements.txt
```

将 `hugo-encryptor.py`放入博客根目录

```bash
$ cp hugo-encryptor.py /path/to/your/blog/hugo-encryptor.py
```

将`shortcodes/hugo-encryptor.html`放入博客`shortcodes`目录

```bash
$ mkdir -p /path/to/your/blog/layouts/shortcodes
$ cp shortcodes/hugo-encryptor.html /path/to/your/blog/layouts/shortcodes/hugo-encryptor.html
```

使用方法


1. 使用 `hugo-encryptor`标签包裹需要加密文章内容[![img](https://www.10101.io/usr/uploads/2021/06/1320048532.png)](https://www.10101.io/usr/uploads/2021/06/1320048532.png)

   

2. 生成网站

   ```bash
   rm -rf public #删除原来的 public 文件夹
   hugo #重新生成 public 文件夹
   ```

3. 进行加密

   ```bash
   python3 hugo-encryptor.py
   ```

至此，文章就已经被加密好了，然后把 public 文件夹内容上传到服务器就好了。

##  

```
**这里必须存在一些明文文字以及概要标签:**




#{{% hugo-encryptor "KJY" %}}

# 这里是你要加密的内容!

这里是你要加密的内容!

看不到我看不到我

在deploy.sh中加入这个

```
#!/bin/bash
hugo
python hugo-encryptor
```

**别忘了闭合 `hugo-encryptor` shortcode 标签:**

#{{% /hugo-encryptor %}}
```