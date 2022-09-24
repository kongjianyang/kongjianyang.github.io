---
title: "YAML语言介绍"
date: 2022-04-25T13:42:27-05:00
author: KJY
slug: YAML
draft: false
toc: true
categories:
  - test
tags:
  - article

---

YAML 是专门用来写配置文件的语言，非常简洁和强大，远比 JSON 格式方便。

YAML 是一种数据序列化语言，通常用于编写配置文件。业界对 YAML 有不同的看法，有人会说 YAML 不过代表了*另一种标记语言*，另外一些人认为*"YAML ain’t markup language"（ "YAML 不是标记语言"）*，"YAML" 正是这句话的递归缩写，强调了 YAML 是用于数据而不是文档。 

YAML 是一种流行的编程语言，因为它是人类可读的语言，易于理解。它还可以与其他编程语言结合使用。

YAML支持3种数据结构：

- 键值表，键值对的集合，包括映射，哈希，字典。
- 序列，为一组排列的值，包括数组，列表。
- 常量，为单个的不可再分隔的值，包括字符串，布尔值，整数，浮点数，Null，时间，日期

由于YAML是JSON的自然超集，所以我们每个YAML语法段，都可以用JSON进行表示。



YAML的基本语法规则如下。

> - 大小写敏感
> - 使用缩进表示层级关系
> - 缩进时不允许使用Tab键，只允许使用空格。
> - 缩进的空格数目不重要，只要相同层级的元素左侧对齐即可

`#` 表示注释，从这个字符一直到行尾，都会被解析器忽略。

YAML 支持的数据结构有三种。

> - 对象：键值对的集合，又称为映射（mapping）/ 哈希（hashes） / 字典（dictionary）
> - 数组：一组按次序排列的值，又称为序列（sequence） / 列表（list）
> - 纯量（scalars）：单个的、不可再分的值

以下分别介绍这三种数据结构。



对象的一组键值对，使用冒号结构表示。

> ```javascript
> animal: pets
> ```

转为 JavaScript 如下。

> ```javascript
> { animal: 'pets' }
> ```

Yaml 也允许另一种写法，将所有键值对写成一个行内对象。

> ```javascript
> hash: { name: Steve, foo: bar } 
> ```

转为 JavaScript 如下。

> ```javascript
> { hash: { name: 'Steve', foo: 'bar' } }
> ```



一组连词线开头的行，构成一个数组。

> ```javascript
> - Cat
> - Dog
> - Goldfish
> ```

转为 JavaScript 如下。

> ```javascript
> [ 'Cat', 'Dog', 'Goldfish' ]
> ```

数据结构的子成员是一个数组，则可以在该项下面缩进一个空格。

> ```javascript
> -
>  - Cat
>  - Dog
>  - Goldfish
> ```

转为 JavaScript 如下。

> ```javascript
> [ [ 'Cat', 'Dog', 'Goldfish' ] ]
> ```

数组也可以采用行内表示法。

> ```javascript
> animal: [Cat, Dog]
> ```

转为 JavaScript 如下。

> ```javascript
> { animal: [ 'Cat', 'Dog' ] }
> ```
