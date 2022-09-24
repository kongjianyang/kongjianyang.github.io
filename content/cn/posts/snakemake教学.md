---
title: "snakemake教学"
date: 2019-10-17T19:10:27-04:00
author: KJY
slug: snakemake
draft: false
toc: true
categories:  
  - Python
tags:        
  - article
---

参考：
https://qinqianshan.com/python/py_module/snakemake/
https://xizhihui.github.io/2018/10/28/%E6%B5%81%E7%A8%8B%E6%9E%84%E5%BB%BA-Snakemake%E4%BD%BF%E7%94%A8%E5%88%9D%E6%AD%A5/

如果你编译过软件，那你应该见过和用过make, 但是你估计也没有仔细想过make是干嘛用的。Make是最常用的软件构建工具，诞生于1977年，主要用于C语言的项目，是为了处理编译时存在各种依赖关系，尤其是部分文件更新后，Make能够重新生成需要更新的文件以及其对应的文件。

Snakemake和Make功能一致，只不过用Python实现，增加了许多Python的特性，并且和Python一样非常容易阅读。

Snakemake是一个工作流程管理系统。它是基于Python的、用于创建可重现和可扩展的数据分析的工具（当然现在也可以直接将它当做Python的一个模块）。Snakemake所创建的流程还可以无缝扩展到服务器、集群和云环境等不同环境，当然前提是你需要提前将所需的软件和依赖配置好，一起打包封装在conda环境中。

安装软件

```
pip3 install snakemake
```

虽然snakemake广泛的应用于生物信息方面的流程编写，但是snakemake的应用并不局限于编写生物信息学的流程，这里以一个简单的合并文件的例子开始介绍snakemake的简单使用。



```
#首先我们建立两个文件
echo "Here is hello." > hello.txt
echo "Here is world." > world.txt

#接下来开始编写我们的Snakefile
rule concat:  # 这里的rule可视为snakemake定义的关键字，concat是我们自定义的这一步任务的名称
    input:   # input同样是snakemake的关键字，定义了在这个任务中的输入文件 
        expand("{file}.txt", file=["hello", "world"]) #expand是一个snakemake定义的替换命令
    output:   # output也是snakemake的关键字，定义输出结果的保存文件
        "merged.txt"
    shell:  # 这里表示我们下面的命令将在命令行中执行
        "cat {input} > {output}"

#最后就可以在Snakefile的路径执行snakemake命令即可
snakemake
cat merge.txt
# Here is hello.
# Here is world.
```


在上面的Snakefile脚本中，rule、input、output、shell、expand均为snakemake中的关键字或者命令。同时Snakefile中的每一个rule其实都可以看作是一个简单的shell脚本，通过Snakefile将多个rule组织在一起并按照我们定义的顺序来执行。另外，在output中的结果文件可以是未存在目录中的文件,这时会自动创建不存在的目录。


## snakemake中的规则

rule是Snakefile中最主要的部分。如上面的例子所说，每一个rule定义了一系列pipe中的一步，每一个rule都可以当作一个shell脚本来处理，一般主要包括input、output、shell3个部分。同时还有许多上面没有列出来的用法：

1.  `wildcards`。用来获取通配符匹配到的部分，例如对于通配符`"{dataset}/file.{group}.txt"`匹配到文件`101/file.A.txt`，则`{wildcards.dataset}`就是101，`{wildcards.group}`就是A。
2.  `threads`。通过在rule里面指定`threads`参数来指定分配给程序的线程数，eg`threads: 8`。
3.  `resources`。可用来指定程序运行的内存，eg. `resources: mem_mb=800`。
4.  `message`。使用`message`参数可以指定每运行到一个rule时，在终端中给出提示信息，eg.`message: "starting mapping ..."`。
5.  `priority`。可用来指定程序运行的优先级，默认为0，eg.`priority: 20`。
6.  `log`。用来指定生成的日志文件，eg.`log: "logs/concat.log"`。
7.  `params`。指定程序运行的参数，eg.`params: cat="-n"`,调用方法为`{params.cat}`。
8.  `run`。在`run`的缩进区域里面可以输入并执行python代码。
9.  `scripts`。用来执行指定脚本，eg.`scripts: "rm_dup.py"`
10.  `temp`。通过`temp`方法可以在所有`rule`运行完后删除指定的中间文件，eg.`output: temp("f1.bam")`。
11.  `protected`。用来指定某些中间文件是需要保留的，eg.`output: protected("f1.bam")`。
12.  `ancient`。重复运行执行某个Snakefile时，snakemake会通过比较输入文件的时间戳是否更改(比原来的新)来决定是否重新执行程序生成文件，使用ancient方法可以强制使得结果文件一旦生成就不会再次重新生成覆盖，即便输入文件时间戳已经更新，eg.`input: ancient("f1.fastq")`。
13.  Rule Dependencies。可通过快捷方式指定前一个rule的输出文件为此rule的输入文件：




```
rule a:
    input:  "path/to/input"
    output: "path/to/output"
    shell:  ...
rule b:
    input:  rules.a.output   #直接通过rules.a.output 指定rule a的输出
    output: "path/to/output/of/b"
    shell:  ...
```


## snakemake的执行

一般讲所有的参数配置写入Snakefile后直接在Snakefile所在路径执行snakemake命令即可开始执行流程任务。一些常用的参数：

```
--snakefile, -s 指定Snakefile，否则是当前目录下的Snakefile
--dryrun, -n  不真正执行，一般用来查看Snakefile是否有错
--printshellcmds, -p   输出要执行的shell命令
--reason, -r  输出每条rule执行的原因,默认FALSE
--cores, --jobs, -j  指定运行的核数，若不指定，则使用最大的核数
--force, -f 重新运行第一条rule或指定的rule
--forceall, -F 重新运行所有的rule，不管是否已经有输出结果
--forcerun, -R 重新执行Snakefile，当更新了rule时候使用此命令
#一些可视化命令
# 其本身还提供了简单却够用的可视化流程帮助我们了解代码的运行逻辑，可以使用下面的方式将流程可视化
$ snakemake --dag | dot -Tpdf > dag.pdf
#集群投递
snakemake --cluster "qsub -V -cwd -q 节点队列" -j 10
# --cluster /-c CMD: 集群运行指令
# qusb -V -cwd -q， 表示输出当前环境变量(-V),在当前目录下运行(-cwd), 投递到指定的队列(-q), 如果不指定则使用任何可用队列
# --local-cores N: 在每个集群中最多并行N核
# --cluster-config/-u FILE: 集群配置文件
```









