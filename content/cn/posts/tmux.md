---
title: "tmux多窗口管理"
date: 2022-03-25T14:42:27-05:00
author: KJY
slug: tmux
draft: false
toc: true
categories:
  - tmux
tags:
  - article
---



[TOC]



主要参考这篇文章：[还在为 iTerm 多窗口操作烦恼？tmux 这款神器轻松帮你解决_Java极客技术-程序员信息网 - 程序员信息网 (i4k.xyz)](https://www.i4k.xyz/article/javageektech/105463104)

[Tmux 使用教程 - 阮一峰的网络日志 (ruanyifeng.com)](https://www.ruanyifeng.com/blog/2019/10/tmux.html)



安装tmux

```bash
brew install tmux
```

### 会话管理

**新建 session**

使用 tmux 之前我们首先需要新建一个 **Session**，命令如下：

```bash
# 新建 session，使用 -s 自定义 session 名字
tmux new -s <session-name>
```

**保存会话**

进入会话之后，进行相关操作，比如使用 SSH 连上远端服务器。这时如果想退出去的时候，可以保存当前会话信息。下次可以直接重新进入这个会话，不用重新再次使用 SSH 连接了。

```
# 保存当前会话
tmux detach
```

**接入会话**

**tmux attach** 可以接入上次保存的会话。

```
# 可以使用 -t 指定会话名字。
tmux attach -t <session-name>
```

**查看会话**

如果之前同时保存了多个会话，我们可以使用 **tmux ls** 查看当前所有会话。

```go
# 查看会话
tmux ls
```

**杀死会话**

使用 **tmux kill-session** 我们可以杀死某个会话。

```go
# 使用 -t 指定会话名称
tmux kill-session -t <session-name>
```

### 窗口管理

**新建窗口**

```go
# 新建一个指定名称的窗口
tmux new-window -n <window-name>
```

**切换窗口**

```go
# 切换到指定名称的窗口
tmux select-window -t <window-name>
```

这里推荐使用快捷键 **Ctrl+b w**：从列表中选择窗口。



### 窗格操作

窗格操作这是阿粉认为最强大的功能，我们使用命令可以将一个窗口划分为多个窗格，不过阿粉还是建议使用快键键操作。

```go
# 划分上下两个窗格 命令：tmux split-window
Ctrl+b %
# 划分上下两个窗格 命令：tmux split-window -h
Ctrl+b "
```

**切换 pane**

```go
## 切换当前所在窗格
Ctrl+b 方向键
```

**窗格大小调整**

```go
Ctrl+b alt+：方向键 调整窗格大小。
```

**其他窗格常用快捷键**

- `Ctrl+b x`：关闭当前窗格。
- `Ctrl+b !`：将当前窗格拆分为一个独立窗口。
- `Ctrl+b z`：当前窗格全屏显示，再使用一次会变回原来大小。
- `Ctrl+b q`：显示窗格编号。

### 其他命令

下面是一些其他命令。

 ```bash
 # 列出所有快捷键，及其对应的 Tmux 命令
 $ tmux list-keys
 
 # 列出所有 Tmux 命令及其参数
 $ tmux list-commands
 
 # 列出当前所有 Tmux 会话的信息
 $ tmux info
 
 # 重新加载当前的 Tmux 配置
 $ tmux source-file ~/.tmux.conf
 ```

### 持久保存 Tmux 会话

如果机器重启，那么 Tmux 会话就消失了，包括打开的各个窗口、窗格布局、以及其中跑的程序等。Tmux Resurrect 和 Tmux Continuum 这两个 Tmux 插件可以解决这个问题。

首先安装 tmux 专属的插件管理器，一般都是用这个：tmux plugin manager，即 tpm。注意：文档里面都会提到 prefix + …，其中 prefix 指的是 tmux 的命令前缀，默认是 ctrl+b。

项目地址在这：https://github.com/tmux-plugins/tpm

Tmux Resurrect 能够备份 Tmux 会话的各种细节，包括所有会话、窗口、窗格以及它们的顺序，每个窗格的当前工作目录，精确的窗格布局，活动及替代的会话和窗口，窗口聚焦，活动窗格，窗格中运行的程序等等。

Tmux Resurrect 工作很好，只是备份和还原都是手动完成。而 Tmux Continuum 更进一步，它将 Tmux 会话的保存及还原自动化，定时备份，然后在 Tmux 启动时还原。

把管理器文件安装到`~/.tmux/plugins/tpm`之下 此前这些目录是不存在的

```
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

```
# 将下面内容复制到`~/.tmux.conf.local`
# List of plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
# Other examples:
# set -g @plugin 'github_username/plugin_name'
# set -g @plugin 'git@github.com/user/plugin'
# set -g @plugin 'git@bitbucket.com/user/plugin'
# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.tmux/plugins/tpm/tpm' 

# 在tmux运行的时候，找到任意窗口输入下面这个完成安装管理器：
tmux source ~/.tmux.conf.local
```

```
#在`~/.tmux.conf.local`添加如下命令
set -g @plugin 'tmux-plugins/tmux-resurrect'
set -g @plugin 'tmux-plugins/tmux-continuum'
```

Tmux Continuum 默认每隔 15 分钟备份一次，如果你觉得频率过高，可以设置为 1 小时一次：

```
set -g @continuum-save-interval '60'
```

同样，需要重载 Tmux 配置 `tmux source-file ~/.tmux.conf.local`。

保存好后，在 tmux 的任意窗口按 ctrl+b 及大写的 I，即可完成下载安装。

用法

- prefix + Ctrl-s - 保存 session
- prefix + Ctrl-r - 恢复 session

其中 prefix 指的是 tmux 的命令前缀，默认是 ctrl+b。

### 自定义 tmux 配置

我们可以修改 tmux 相关配置开启鼠标，复制/粘贴功能。

不过这里不推荐大家一个个去官网找配置参数，Github 上有个大神开开源其 tmux 配置，我们可以将 tmux 配置如下:

安装方法：

```go
$ cd
$ git clone https://github.com/gpakosz/.tmux.git
$ ln -s -f .tmux/.tmux.conf
$ cp .tmux/.tmux.conf.local .
```

如果需要修改配置，建议在  `~/.tmux.conf.local` 中配置。

上面操作完成之后，重新打开 tmux ，就可以看到界面变化了。若未生效，可以运行如下配置：

```go
tmux source ~/.tmux.conf
```

默认情况下，未开启鼠标模式，需要使用如下如下快捷键打开；

```go
Ctrl+b m
```

开启之后，就可以愉快使用鼠标。

也可以修改这个启用鼠标

```
# start with mouse mode enabled
set -g mouse on
```

tmux 会话窗口中，我们是无法访问 macos 系统剪贴板，我们需要安装 **reattach-to-user-namespace**。

安装方式如下：

```go
$ brew install reattach-to-user-namespace
```

### 日常使用流程



```bash
tmux new -s working
tmux detach
tmux attach -t working
```





