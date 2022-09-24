---
title: 详解MySQL及RMySQL
author: Liang
date: '2018-11-24'
slug: 详解MySQL及RMySQL
categories:
  - 生信修炼
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
# 01. Mac上安装MySQL

访问MySQL的官网http://www.mysql.com/downloads/ 然后在页面中会看到“MySQL Community Server”下方有一个“download”点击。进入MySQL的下载界面（http://www.mysql.com/downloads/mysql/），如果你是用的Mac OS来访问的话那么就会默认为你选好了Mac OS X 平台，而下面罗列的都是在Mac OS上能用的MySQL的版本，如果是用的其他平台，在“Select Platform”选项的下拉列表中选一下就好了。按照安装步骤一路向下走，记得保存最后弹出框中的密码（它是你mysql root账号的密码）。 打开设置并且点击MySQL并开启MySQL服务。

此时我们在终端输入此时我们在命令行输入mysql -uroot -p命令会提示没有commod not found，我们还需要将mysql加入系统环境变量。

(1).进入/usr/local/mysql/bin,查看此目录下是否有mysql。

(2).执行vim ~/.bash_profile
```
PATH=$PATH:/usr/local/mysql/bin
```
添加完成后，按esc，然后输入wq保存。最后在命令行输入source ~/.bash_profile。
现在你就可以通过mysql -uroot -p登录mysql了，会让你输入密码，就是之前弹窗中记录的密码

至此MySQL成功安装到mac电脑下，可以进行下面的开发了。

# 02. 安装RMySQL

安装*RMySQL*非常简单，安装之后可以使用`help`命令查询包的介绍信息

```{r}
install.packages("RMySQL")
library(RMySQL)
```

```{r}
help("RMySQL")
```

# 03. RMySQL基本操作
创造一个新的数据库并使用，SQL查询可以通过dbSendQuery或dbGetQuery传给数据库管理系统。dbGetQuery传送查询语句，把结果以数据框形式返回。dbSendQuery传送查询，返回的结果是继承"DBIResult"的一个子类的对象。函数fetch用于获得查询结果的部分或全部行，并以列表返回。函数dbHasCompleted确定是否所有行已经获得了，而dbGetRowCount返回结果中行的数目。如果只是简单的读整个表，也可以用dbReadTable函数。

```{r}
library(RMySQL)

mydb = dbConnect(MySQL(), #数据库平台类型
                 user='root', #登录账号（MySQL初始安装时设置的账号）
                 password='password', #登录密码（MySQL初始安装时设置的密码）
                 host='localhost')
# creating a database using RMySQL in R
dbSendQuery(mydb, "CREATE DATABASE bookstore;")
dbSendQuery(mydb, "USE bookstore;")
# reconnecting to database we just created using following command in R :
mydb = dbConnect(MySQL(), user='root', password='password', host='localhost', dbname="bookstore") # 重连数据库
dbSendQuery(mydb, "drop table if exists books, authors")
```

在数据库中创造表：

```{r}
# creating tables in bookstore:
dbSendQuery(mydb, "
CREATE TABLE books (
book_id INT,
title VARCHAR(50),
author VARCHAR(50));")
```
显示数据库中的表：
```{r}
# Show table using R:
dbListTables(mydb)
```
在包中插入新的列：
```{r}
dbSendQuery(mydb, "ALTER TABLE books
CHANGE COLUMN book_id book_id INT AUTO_INCREMENT PRIMARY KEY,
CHANGE COLUMN author author_id INT,
ADD COLUMN description TEXT,
ADD COLUMN genre ENUM('novel','poetry','drama', 'tutorials', 'text', 'other'),
ADD COLUMN publisher_id INT,
ADD COLUMN pub_year VARCHAR(4),
ADD COLUMN isbn VARCHAR(20);")
```
创造新的表并创造一些列名：
```{r}
# Now, Before moving on to adding data to our books table, let's quickly set up the authors table.

dbSendQuery(mydb, "CREATE TABLE authors
(author_id INT AUTO_INCREMENT PRIMARY KEY,
author_last VARCHAR(50),
author_first VARCHAR(50),
country VARCHAR(50));")
```
往新的表中插入数据：
```{r}
# Adding data into tables
dbSendQuery(mydb, "INSERT INTO authors
(author_last, author_first, country)
VALUES('Kumar','Manoj','India');")
```
从数据库中获取选取结果：
```{r}
# fetching last data insert id number:
last_id = fetch(dbSendQuery(mydb, "SELECT LAST_INSERT_ID();"))
last_id
```
插入新的值到book表，并查看插入的值：
```{r}
# Inserting data into books table and using last insert ID number:

dbSendQuery(mydb, "INSERT INTO books
(title, author_id, isbn, genre, pub_year)
VALUES('R and MySQL', 1,'6900690075','tutorials','2014');")

try1 = fetch(dbSendQuery(mydb, "SELECT book_id, title, description FROM books WHERE genre = 'tutorials';"))
```
显示所有的表并插入数值到新的表：
```{r}
dbListTables(mydb) # 显示所有的表
dbWriteTable(mydb, name = "mtcars", value = mtcars[,]) # 插入R自带的数据mtcars形成新的表
dbListTables(mydb)
```
插入表格的时候如果有错误的话如：
```
Error in .local(conn, statement, ...) : could not run statement: The used command is not allowed with this MySQL version
```
则是因为MySQL的一些安全问题，可以在MySQL的命令界面通过命令查询：
```
SHOW VARIABLES LIKE 'local_infile';
```
全局更改则可以依据以下命令：

```
SET GLOBAL local_infile = 1;
```

读取数据库里面的表格：

```{r}
mtcars <- dbReadTable(mydb, "mtcars")
head(mtcars)
```
删除表格：
```{r}
dbGetQuery(mydb,"DROP TABLE mtcars")
dbListTables(mydb)
```
删除数据库：
```{r}
dbGetQuery(mydb,"DROP DATABASE bookstore;")
```
断开连接：
```{r}
dbDisconnect(mydb)
```

# 查询配置文件

可以使用下面的命令进行查询配置文件

```
mysql --verbose --help | grep my.cnf
```

- /etc/my.cnf - Global
- /etc/mysql/my.cnf - Global
- SYSCONFDIR/my.cnf - Global
- $MYSQL_HOME/my.cnf - Server-specific (server only)
- ~/.my.cnf - User-specific
- ~/.mylogin.cnf - User-specific (clients only)


# 04. 相关

查询mysql数据存放的位置
```
mysql> show global variables like "%datadir%";
```
Mac系统下默认是没有MySQL的配置文件my.cnf的，如果需求的话需要自己创建并修改。









