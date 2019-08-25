# XML数据解析

## 添加额外依赖

```xml
<!-- https://mvnrepository.com/artifact/com.fasterxml.jackson.dataformat/jackson-dataformat-xml -->
<dependency>
    <groupId>com.fasterxml.jackson.dataformat</groupId>
    <artifactId>jackson-dataformat-xml</artifactId>
    <version>2.9.8</version>
</dependency>
```



## 主程序

```java
package com.json.controller;

import com.json.pojo.User;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/xml")
public class XMLController {

    @ResponseBody
    @RequestMapping(value = "/test",produces = {MediaType.APPLICATION_XML_VALUE})
    public User xml(){
        User user = new User();
        user.setId(1);
        user.setName("小梁");
        user.setPassword("222");
        return user;

    }
}

```





