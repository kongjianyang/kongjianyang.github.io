---
title: "为Mac系统添加QuickLook插件"
date: 2022-05-18T19:10:27-04:00
author: KJY
slug: html
draft: false
toc: true
categories:  
  - hugo
tags:        
  - article
---



**安装命令**：brew cask install <package>
**卸载命令**：brew cask uninstall <package>
**软件包被安装的路径**： /Users/用户名称/Library/QuickLook



QuickLook（快速预览）是 Mac OS X 中一项很好的功能。用户选择文件后，按下空格键即可快速预览。因为不用点击打开，还能使用方向键切换，从而节省了大量的时间。但对于开发者来说，系统内置的功能还不能完全满足需求。

需要拓展安装一些插件



最方便的方式是通过brew进行



查找所有插件

```
brew search quicklook

==> Formulae
quickjs

==> Casks
caskroom/cask/epubquicklook              ipynb-quicklook
caskroom/cask/gltfquicklook              osirix-quicklook
caskroom/cask/ipynb-quicklook            quicklook-csv
caskroom/cask/osirix-quicklook           quicklook-json ✔
caskroom/cask/quicklook-csv              quicklook-pat
caskroom/cask/quicklook-json ✔           quicklook-pfm
caskroom/cask/quicklook-pat              quicklookapk
caskroom/cask/quicklook-pfm              quicklookase ✔
caskroom/cask/quicklookapk               receiptquicklook
caskroom/cask/quicklookase ✔             ttscoff-mmd-quicklook
caskroom/cask/receiptquicklook           webpquicklook ✔
caskroom/cask/ttscoff-mmd-quicklook      quickbooks
caskroom/cask/webpquicklook ✔            quickboot
epubquicklook                            quickjson
gltfquicklook                            quicknfo
```

 

安装一些插件

```
brew install --cask qlimagesize qlvideo qlmarkdown

brew install --cask qlcolorcode quicklook-json qlstephen suspicious-package provisionql quicklook-csv
brew install highlight luarocks  # 相关的依赖包
```

