---
title: Python中mechanize模块练习
author: Liang
date: '2018-11-24'
slug: Python中mechanize模块练习
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

# Part 1
An introduction about mechanize


```python
import mechanize
```


```python
br = mechanize.Browser()
```


```python
br.open("http://www.example.com/")
```




    <response_seek_wrapper at 0x109db3170 whose wrapped object = <closeable_response at 0x109d4a5f0 whose fp = <socket._fileobject object at 0x109d386d0>>>




```python
response1 = br.follow_link()
```


```python
assert br.viewing_html()
```


```python
print br.title()
```

    IANA — IANA-managed Reserved Domains



```python
print response1.geturl()
```

    https://www.iana.org/domains/reserved



```python
print response1.info() #headers
```

    Date: Fri, 13 Jul 2018 14:51:52 GMT
    X-Frame-Options: SAMEORIGIN
    Referrer-Policy: origin-when-cross-origin
    Content-Security-Policy: upgrade-insecure-requests
    Vary: Accept-Encoding
    Last-Modified: Tue, 21 Jul 2015 00:49:48 GMT
    Cache-control: public, s-maxage=900, max-age=7202
    Expires: Fri, 13 Jul 2018 16:51:52 GMT
    Content-Type: text/html; charset=UTF-8
    Server: Apache
    Strict-Transport-Security: max-age=48211200; preload
    X-Cache-Hits: 18
    Accept-Ranges: bytes
    Content-Length: 10225
    Connection: close
    content-type: text/html; charset=utf-8
    



```python
print response1.read() #body
```
    


To get the response code from a website, you can the response.code

# Part 2 

An example to show how to search data in mechanize


```python
from mechanize import Browser
```


```python
browser = Browser()
```


```python
browser.set_handle_robots(False) #ignore the robots.txt
```


```python
response = browser.open("https://www.google.com")
```


```python
print response.code
```

    200


get all forms from the website


```python
import mechanize
```


```python
br = mechanize.Browser()
```


```python
br.set_handle_robots(False) #ignore the robots.txt
```


```python
br.addheaders = [('User-agent', 'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.1) Gecko/2008071615 Fedora/3.0.1-1.fc9 Firefox/3.0.1')] # Google demands a user-agent that isn't a robot
```


```python
br.open("https://www.google.com")
```




    <response_seek_wrapper at 0x1081a4248 whose wrapped object = <closeable_response at 0x10819def0 whose fp = <socket._fileobject object at 0x108148a50>>>




```python
for f in br.forms():
    print f
```

    <f GET https://www.google.com/search application/x-www-form-urlencoded
      <HiddenControl(hl=en) (readonly)>
      <HiddenControl(source=hp) (readonly)>
      <HiddenControl(biw=) (readonly)>
      <HiddenControl(bih=) (readonly)>
      <TextControl(q=)>
      <SubmitControl(btnG=Google Search) (readonly)>
      <SubmitControl(btnI=I'm Feeling Lucky) (readonly)>
      <HiddenControl(gbv=1) (readonly)>>


Select the search box and search for 'foo'

By default 'f' would represent the name of the form. 'q' would be one of the inputs of the form whose name is set to 'q'


```python
br.select_form('f')
```


```python
br.form['q'] = 'foo'
```

get the search results


```python
br.submit()
```




    <response_seek_wrapper at 0x109738ea8 whose wrapped object = <closeable_response at 0x10819dcb0 whose fp = <socket._fileobject object at 0x108148c50>>>



Find the link to foofighters.com


```python
resp = None
```


```python
import re
for link in br.links():
    siteMatch = re.compile('https://foofighters.com/').search(link.url)
    if siteMatch:
        resp = br.follow_link(link)
        break
```

print the site 


```python
content = resp.get_data()
print content
```

    


# Part 3 Cheart Sheet
[mechanize cheat sheet](http://www.pythonforbeginners.com/cheatsheet/python-mechanize-cheat-sheet)
