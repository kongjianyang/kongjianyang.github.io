---
title: Python绘图和可视化
author: Liang
date: '2018-11-24'
slug: Python绘图和可视化
categories:
  - 大蟒笔记
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
Python有许多库进行静态或动态的数据可视化，但我这里重要关注于matplotlib和基于它的库。matplotlib的目的是为Python构建一个MATLAB式的绘图接口。在Jupyter notebook中执行下面的语句：
```
%matplotlib notebook
import matplotlib.pyplot as plt
import numpy as np
data = np.arange(10)
data
plt.plot(data)
```
![](https://upload-images.jianshu.io/upload_images/3014937-6367a64fb33f102d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

matplotlib的图像都位于Figure对象中。你可以用plt.figure创建一个新的Figure： 如果用的是IPython，这时会弹出一个空窗口，但在Jupyter中，必须再输入更多命令才能看到。plt.figure有一些选项，特别是figsize，它用于确保当图片保存到磁盘时具有一定的大小和纵横比。

不能通过空Figure绘图。必须用add_subplot创建一个或多个subplot才行：
```
# 代码的意思是：图像应该是2×2的（即最多4张图），
# 且当前选中的是4个subplot中的第一个（编号从1开始）。
# 如果再把后面两个subplot也创建出来，最终得到的图像如图所示：
fig = plt.figure()
ax1 = fig.add_subplot(2, 2, 1)
ax2 = fig.add_subplot(2, 2, 2)
ax3 = fig.add_subplot(2, 2, 3)
```
![](https://upload-images.jianshu.io/upload_images/3014937-e3b5c8bbcc9b2b94.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

使用Jupyter notebook有一点不同，即每个小窗重新执行后，图形会被重置。因此，对于复杂的图形，，你必须将所有的绘图命令存在一个小窗里。 加的绘图命令会在最后一个subplot上.
```
fig = plt.figure()
ax1 = fig.add_subplot(2, 2, 1)
ax2 = fig.add_subplot(2, 2, 2)
ax3 = fig.add_subplot(2, 2, 3)
plt.plot(np.random.randn(50).cumsum(), 'k--') #plt.plot(np.random.randn(50).cumsum(), 'k--') # 
ax1.hist(np.random.randn(100), bins=20, color='k', alpha=0.3)
ax2.scatter(np.arange(30), np.arange(30) + 3 * np.random.randn(30))
```
![](https://upload-images.jianshu.io/upload_images/3014937-5e66e1368276f2f0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
默认情况下，matplotlib会在subplot外围留下一定的边距，并在subplot之间留下一定的间距。间距跟图像的高度和宽度有关，因此，如果你调整了图像大小（不管是编程还是手工），间距也会自动调整。利用Figure的subplots_adjust方法可以轻而易举地修改间距。wspace和hspace用于控制宽度和高度的百分比，可以用作subplot之间的间距。下面是一个简单的例子，其中我将间距收缩到了0
```
fig, axes = plt.subplots(2, 2, sharex=True, sharey=True)
for i in range(2):
    for j in range(2):
        axes[i, j].hist(np.random.randn(500), bins=50, color='k', alpha=0.5)
plt.subplots_adjust(wspace=0, hspace=0)
```
![](https://upload-images.jianshu.io/upload_images/3014937-b840e059ebccc4b6.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

```
plt.figure() 
from numpy.random import randn
plt.plot()
plt.plot(randn(30).cumsum(), 'ko--')
```
![](https://upload-images.jianshu.io/upload_images/3014937-a455657224ee6548.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 设置标题、轴标签、刻度以及刻度标签
```
# 随机漫步图
fig = plt.figure()
ax = fig.add_subplot(1, 1, 1)
ax.plot(np.random.randn(1000).cumsum())
ticks = ax.set_xticks([0, 250, 500, 750, 1000]) # 将刻度放到哪些位置
labels = ax.set_xticklabels(['one', 'two', 'three', 'four', 'five'], rotation=30, fontsize='small') # 刻度标签，旋转三十度
ax.set_title('My first matplotlib plot') # 设置标题
ax.set_xlabel('Stages') # 设置X轴label
# cumsum: cumulative sum
# Cumsum ：计算轴向元素累加和，返回由中间结果组成的数组
# 重点就是返回值是“由中间结果组成的数组”
```
![](https://upload-images.jianshu.io/upload_images/3014937-4f68005584b592ca.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 添加图例
```
from numpy.random import randn
fig = plt.figure(); ax = fig.add_subplot(1, 1, 1)
ax.plot(randn(1000).cumsum(), 'k', label = 'one')
ax.plot(randn(1000).cumsum(), 'k--', label = 'two')
ax.plot(randn(1000).cumsum(), 'k.', label = 'three')
ax.legend(loc='best')
```
![](https://upload-images.jianshu.io/upload_images/3014937-cd86cb834753556f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 图上加注解
ax.annotate方法可以在指定的x和y坐标轴绘制标签。使用set_xlim和set_ylim人工设定起始和结束边界
```
import pandas as pd
from datetime import datetime

fig = plt.figure()
ax = fig.add_subplot(1, 1, 1)
data = pd.read_csv('examples/spx.csv', index_col=0, parse_dates=True)
spx = data['SPX']

spx.plot(ax=ax, style='k-')

#需要标注的点作为元组
crisis_data = [
    (datetime(2007, 10, 11), 'Peak of bull market'),
    (datetime(2008, 3, 12), 'Bear Stearns Fails'),
    (datetime(2008, 9, 15), 'Lehman Bankruptcy')
]

for date, label in crisis_data:
    ax.annotate(label, xy=(date, spx.asof(date) + 75),
                xytext=(date, spx.asof(date) + 225),
                arrowprops=dict(facecolor='black', headwidth=4, width=2,
                                headlength=4),
                horizontalalignment='left', verticalalignment='top')

# Zoom in on 2007-2010
ax.set_xlim(['1/1/2007', '1/1/2011'])
ax.set_ylim([600, 1800])
# 加上title
ax.set_title('Important dates in the 2008-2009 financial crisis')
```
![](https://upload-images.jianshu.io/upload_images/3014937-28298790548a97a0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


