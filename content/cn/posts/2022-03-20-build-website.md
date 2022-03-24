---
title: "使用GitHub page建立站点"
date: 2022-03-20T13:42:27-05:00
author: KJY
slug: second-post-cn
draft: false
toc: true
categories:
  - test
tags:
  - article
---



记录第一次使用GitHub page建立站点的步骤:

主要参考这篇文章：[郝鸿涛：Hongtao Hao](https://hongtaoh.com/cn/2021/03/02/personal-website-tutorial/)

[TOC]

## 1. 安装Hugo



在 Terminal 中输入

```
brew install hugo 
```

完成后，在 Terminal 中输入 `hugo version`, 如果显示 `Hugo Static Site Generator...` 证明安装成功。



## 2. 新建一个 Hugo 网站

Hugo 博客就是一个文件夹。首先你要确定把这个文件夹放在哪里。到达自己需要的地址之后使用以下命令

```
hugo new site liang.github.io **# quickstart 可以换成任何你想用的名称**
cd quickstart/themes
git clone https://github.com/hongtaoh/hugo-ht
mkdir hugo-ht-new
cp -r hugo-ht/* hugo-ht-new
rm -rf hugo-ht
mv hugo-ht-new hugo-ht
cd ..
cp -r themes/hugo-ht/exampleSite/* .
```

这是使用一个Hugo-ht为主题的网站，之后可以折腾其他主题。但是这样会你目前 Hugo 网站中的 `Content` 文件夹和 `config.toml` 替换为 `Hugo-ht` 自带的内容。如果你当前 Hugo 网站中的 Content 文件夹及`config.toml`尚未备份，请千万小心。

然后运行

```
hugo server -D # 这里的 D 是 draft 的意思
```

打开终端显示的 http://localhost:1313/ ，不出意外的话你能看到和 https://hugo-ht.hongtaoh.com/ 一模一样的个人网站。

如果没有什么问题，在终端输入 Ctrl+C 停止预览。

## 3. 新建 GitHub 仓库

登陆 GitHub, 点击头像左侧的加号，再点击’new repository'。

在 Repository name 这里输入 `你的 GitHub 用户名.github.io`。Description 这里你写啥都可以。其他都不要动，点击 Create repository。

在根目录下输入以下命令：

```
mkdir .github
mkdir .github/workflows
touch .github/workflows/gh-pages.yml
```

输入

```
cd ~/.ssh
ssh-keygen -t rsa -b 4096 -C "$(git config user.email)" -f gh-pages -N ""
open -a Finder ~/.ssh 
```

复制 `~/.ssh/gh-pages.pub` 内的内容到GitHub网站。把屏幕拉宽，点击 Settings -> 点击 Deploy keys -> 点击 Add deploy key。把鼠标放在 key 下面的文本框，苹果电脑按 Command+V。在 Allow write access 那里打勾，在 Title 随便写点东西，比如“个人网站部署”，然后点击 Add key。

复制 `~/.ssh/gh-pages` 内的内容到GitHub网站。把屏幕拉宽，点击 Settings -> 点击 Secrets -> 点击 New repository secret。把鼠标放在 Value 下面的文本框，苹果电脑按 Command+V。在 Name 那里填 ACTIONS_DEPLOY_KEY，然后点击 Add secret。

设置 Personal Token

打开[这个链接](https://github.com/settings/tokens) 。进去后，点击 Generate new token 按钮, 在随后出现的页面中，选择你觉得合适的有效期限（默认为 30 天），在 Select scopes 这里选中 workflow，在 Note 那里随便写点东西，然后将页面往下拖，点击 Generate token。

生成之后，点击那一串字母后边的复制板，将 token 复制下来。

回到 GitHub 你新建的仓库。把屏幕拉宽，点击 Settings -> 点击 Secrets -> 点击 New repository secret。把鼠标放在 Value 下面的文本框，苹果电脑按 Command+V。在 Name 那里填 PERSONAL_TOKEN，然后点击 Add secret。

回到最开始的那个终端输入

```
open .github/workflows/gh-pages.yml -a TextEdit
```

然后复制以下内容，粘贴到刚才弹出的 gh-pages.yml:

```
name: github pages

on:
  push:
    branches:
      - master  # Set a branch name to trigger deployment

jobs:
  deploy:
    runs-on: ubuntu-18.04
    steps:
      - uses: actions/checkout@v2
        with:
          submodules: true  # Fetch Hugo themes (true OR recursive)
          fetch-depth: 0    # Fetch all history for .GitInfo and .Lastmod

      - name: Setup Hugo
        uses: peaceiris/actions-hugo@v2
        with:
          hugo-version: '0.79.1'

      - name: Build
        run: hugo --minify

      - name: Deploy
        uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.PERSONAL_TOKEN }}
          publish_branch: gh-pages
          publish_dir: ./public
```

## 4. 上传到GitHub

```
git init
git add .
git commit -m "first commit."
git remote add origin https://github.com/USERNAME/USERNAME.github.io.git
git push -u origin master
```

回到 GitHub 你新建的仓库。把屏幕拉宽，点击 Settings，一直往下拖，到你看到 Pages 为止。在 Source 那里，Branch 选择 gh-pages, 右侧的框框选择 root，然后点 Save。等一两分钟，当出现



```
Your site is published at https://USERNAME.github.io/
```

## 5.一些修改

Hugo 文件夹根目录下的 config.toml 有几个地方需要你自己改：

- baseURL: 替换成 https://USERNAME.github.io/
- GithubEdit: 把所有的 USERNAME 换成你的 GitHub 用户名，把所有的 REPONAME 换成 github用户名.github.io
- Params.lang 部分 `Your Nam` 和「你的名字」换成你的大名。

在 Hugo 文件夹根目录下用文本编辑器新建一个文件，命名为 `deploy.sh`，把以下内容复制粘贴到里面：

```bash
git add .
msg="updating site on $(date)" 
git commit -m "$msg"
git push origin master
```

 新加博客

```
hugo new cn/posts/2021-04-06-a-new-post.md
```

新加 [关于](https://hugo-ht.hongtaoh.com/cn/about/) 这样的单独页面

```
mkdir content/cn/hobby # hobby 可以换成别的名字
cp content/cn/about/_index.md content/cn/hobby # hobby 可以换成别的名字
open content/cn/hobby/_index.md -a TextEdit 
```

更改这个 `_index.md` 的 Title 和内容即可。

新加了 hobby 文件夹之后，要想让它出现在网站上，你需要把它加在 config.toml，比如

```
[[menu.main]]
    name = "兴趣"
    url = "/hobby/"
    weight = 4
```

新加文件

你可以直接把文件，比如 `myPDF.pdf` 放到 `static` 文件夹，这样的话，这个文件的地址就是 `https://USERNAME.github.io/myPDF.pdf`。当你的文件比较多时，建议你在 `static` 文件夹下新建一个子文件夹，比如 `files`，然后把文件统一放到 `files` 里，这样的话，地址就是 `https://USERNAME.github.io/files/myPDF.pdf`



## 6. 一些原理



[**Hugo**](https://github.com/gohugoio/hugo)是由Go语言实现的静态网站生成。 具有简单、易用、高效、易扩展、快速部署等优点。可将markdown格式的文本结合自定义的主题生成静态的html。

[**GithubPages**](https://help.github.com/articles/what-is-github-pages/)是一个静态站点托管服务，旨在直接从GitHub存储库托管您的个人，组织或项目页面。

Hugo+GithubPages的方案相比于传统的博客系统有以下优点：

- 低成本: 无需单独购买VSP服务器或者域名空间，并且不限流量。
- 高度定制化：可以方便的定义网站功能模块，增加个性化功能。
- 方便管理: 由于不需要使用数据库，所有数据均以md形式保存，可直接使用git 行管理，对于博客系统尤其适用。
- 更专业: 对于开源项目的文档，可以使用git与项目版本同步。

整个网站的结构应该是

```
$ tree blog
blog
├── archetypes # 包括内容类型，在创建新内容时自动生成内容的配置。
│   └── default.md
├── config.toml # config.toml 是整个网站的配置文件
├── content # 包括网站内容，全部使用 markdown 格式。
├── data
├── layouts # 包括了网站的模版，决定内容如何呈现，目录下模板优先级高于 /themes/<THEME>/layouts/，可以用来小规模的定制主题。
├── static # 包括了 css, js, fonts, media 等，决定网站的外观。
└── themes # 主题目录，可从网站下载hugo主题
```

