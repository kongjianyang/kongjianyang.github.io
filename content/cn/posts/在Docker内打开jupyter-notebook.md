---
title: 在Docker内打开Jupiter-notebook
author: KJY
date: '2022-12-06'
slug: 在Docker内打开Jupiter-notebook
categories:
  - docker
tags: []
lastmod: '2022-12-06T22:51:22-04:00'
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

参考教程：https://medium.com/codex/how-to-setup-jupyter-notebook-on-mac-b0c2e3c66e60

# 范例

There are many Jupyter images, depending on the variety of Python libraries installed and the additional setup of R and/or PySpark

use *scipy-notebook*, which contains most of the basic data science libraries that I need. It contains [dask](https://dask.org/), [pandas](https://pandas.pydata.org/), [numexpr](https://github.com/pydata/numexpr), [matplotlib](https://matplotlib.org/), [scipy](https://www.scipy.org/), [seaborn](https://seaborn.pydata.org/), [scikit-learn](http://scikit-learn.org/stable/), [scikit-image](http://scikit-image.org/), [sympy](http://www.sympy.org/en/index.html), [cython](http://cython.org/), [patsy](https://patsy.readthedocs.io/en/latest/), [statsmodel](http://www.statsmodels.org/stable/index.html), [cloudpickle](https://github.com/cloudpipe/cloudpickle), [dill](https://pypi.python.org/pypi/dill), [numba](https://numba.pydata.org/), [bokeh](https://bokeh.pydata.org/en/latest/), [sqlalchemy](https://www.sqlalchemy.org/), [hdf5](http://www.h5py.org/), [vincent](http://vincent.readthedocs.io/en/latest/), [beautifulsoup](https://www.crummy.com/software/BeautifulSoup/), [protobuf](https://developers.google.com/protocol-buffers/docs/pythontutorial), [xlrd](http://www.python-excel.org/), [bottleneck](https://bottleneck.readthedocs.io/en/latest/), and [pytables](https://www.pytables.org/) packages.

```
# To download the image, start Docker and run the following command in your terminal:
docker image pull jupyter/scipy-notebook

# launch the container
docker container run --name jupyter -p 8888:8888 -v ~/Desktop/jupyter_notebook jupyter/scipy-notebook
```



`docker container run` speaks for itself. It creates a container from the image.

`--name jupyter` provides a name for our container. In this way, we can refer to it instead of a long technical name.

`-p 8888:8888` indicates which ports will be used for communication between the container and your system. As Jupyter is a web-based application, you need to tell the system which port will be assigned to it.

`-v ~/Desktop/jupyter_notebook` defines which folder from your computer should be mounted to the container. Usually, this is a folder with project working files.  For example, I have project files on my desktop and I would use `~/Desktop/jupyter_notebook`.

To install additional packages, you could go into the container by running the following command in the terminal:

```
docker container exec -it jupyter bash
```



Extensions can be installed using the following command launched inside the docker container.

```
pip install jupyter_contrib_nbextensions && jupyter contrib nbextension install --user
```

After installation, you should stop and launch the container again to see a new tab with extensions in Jupyter.



# 常用方法：



将 image 文件从仓库抓取到本地。

> ```bash
> $ docker image pull library/hello-world
> ```

上面代码中，`docker image pull`是抓取 image 文件的命令。`library/hello-world`是 image 文件在仓库里面的位置，其中`library`是 image 文件所在的组，`hello-world`是 image 文件的名字。



查看image

```
$ docker images
REPOSITORY               TAG       IMAGE ID       CREATED        SIZE
jupyter/scipy-notebook   latest    c72931167ad2   29 hours ago   3.03GB
python                   3.7.4     9fa56d0addae   3 years ago    918MB

$ docker image ls
REPOSITORY               TAG       IMAGE ID       CREATED        SIZE
jupyter/scipy-notebook   latest    c72931167ad2   29 hours ago   3.03GB
python
```





```
# 列出本机正在运行的容器
$ docker container ls 

# 列出本机所有容器，包括终止运行的容器
$ docker container ls --all
```



终止运行的容器文件，依然会占据硬盘空间，可以使用[`docker container rm`](https://docs.docker.com/engine/reference/commandline/container_rm/)命令删除。

> ```bash
> $ docker container rm [containerID]/[containerName]
> ```

运行上面的命令之后，再使用`docker container ls --all`命令，就会发现被删除的容器文件已经消失了。



`docker container run`命令是新建容器，每运行一次，就会新建一个容器。同样的命令运行两次，就会生成两个一模一样的容器文件。如果希望重复使用容器，就要使用`docker container start`命令，它用来启动已经生成、已经停止运行的容器文件。



`docker container kill`命令终止容器运行，相当于向容器里面的主进程发出 SIGKILL 信号。而`docker container stop`命令也是用来终止容器运行，相当于向容器里面的主进程发出 SIGTERM 信号，然后过一段时间再发出 SIGKILL 信号。

> ```bash
> $ docker container stop [containerID]/[containerName]
> ```



`docker container logs`命令用来查看 docker 容器的输出，即容器里面 Shell 的标准输出。如果`docker run`命令运行容器的时候，没有使用`-it`参数，就要用这个命令查看输出。

> ```bash
> $ docker container logs [containerID]
> ```



`docker container exec`命令用于进入一个正在运行的 docker 容器。如果`docker run`命令运行容器的时候，没有使用`-it`参数，就要用这个命令进入容器。一旦进入了容器，就可以在容器的 Shell 执行命令了。

> ```bash
> $ docker container exec -it [containerID] /bin/bash
> ```



`docker container cp`命令用于从正在运行的 Docker 容器里面，将文件拷贝到本机。下面是拷贝到当前目录的写法。

> ```bash
> $ docker container cp [containID]:[/path/to/file] .
> ```



# 简单流程



```
docker container ls --all
docker container start jupyter
docker container logs jupyter
docker container exec -it jupyter bash
docker container stop jupyter
```

