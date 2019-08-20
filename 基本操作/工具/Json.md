# json

## 依赖

```xml
<!-- https://mvnrepository.com/artifact/com.fasterxml.jackson.core/jackson-core -->
<dependency>
    <groupId>com.fasterxml.jackson.core</groupId>
    <artifactId>jackson-core</artifactId>
    <version>2.9.8</version>
</dependency>

<!-- https://mvnrepository.com/artifact/com.fasterxml.jackson.core/jackson-databind -->
<dependency>
    <groupId>com.fasterxml.jackson.core</groupId>
    <artifactId>jackson-databind</artifactId>
    <version>2.9.8</version>
</dependency>

<!-- https://mvnrepository.com/artifact/com.fasterxml.jackson.core/jackson-annotations -->
<dependency>
    <groupId>com.fasterxml.jackson.core</groupId>
    <artifactId>jackson-annotations</artifactId>
    <version>2.9.8</version>
</dependency>
处理json为javaBean的依赖
<!-- https://mvnrepository.com/artifact/org.codehaus.jackson/jackson-core-asl -->
<dependency>
    <groupId>org.codehaus.jackson</groupId>
    <artifactId>jackson-core-asl</artifactId>
    <version>1.9.13</version>
</dependency>

<!-- https://mvnrepository.com/artifact/org.codehaus.jackson/jackson-mapper-asl -->
<dependency>
    <groupId>org.codehaus.jackson</groupId>
    <artifactId>jackson-mapper-asl</artifactId>
    <version>1.9.13</version>
</dependency>

```

## 注解

在类名上添加@RestController ，以及@Controller，在方法名上就可以不加@ResponseBody

```java
@RestController     //=Controller + ResponseBody

```

## json数据传输到前台

1. 利用pojo传输

   ```java
   @RequestMapping("/test1")
   @ResponseBody
   public User test1(){
       User user = new User();
       user.setPwd("123");
       user.setName("小梁");
       return user;
   }
   ```

2. 利用map传输

   ```java
   @RequestMapping("/test2")
   @ResponseBody
   public Map<String ,Object> test2(){
       Map<String , Object> map = new HashMap<>();
       map.put("name","小梁");
       map.put("age", 22);
       return map;
   }
   ```

3. 利用数组传输

   ```java
       @RequestMapping("/test3")
   //    @ResponseBody
       public User[] test3(){
   
           User user1 = new User();
           user1.setPwd("123");
           user1.setName("xiao");
   
           User user2 = new User();
           user2.setPwd("456");
           user2.setName("liang");
   
           return new User[]{user1, user2};
       }
   ```

4. 利用List集合传输

   ```java
       @RequestMapping("/test4")
   //    @ResponseBody
       public List<User> test4(){
   
           User user1 = new User();
           user1.setPwd("123");
           user1.setName("xiao");
   
           User user2 = new User();
           user2.setPwd("456");
           user2.setName("liang");
   
           List<User> list = new ArrayList<>();
           list.add(user1);
           list.add(user2);
   
           return list;
       }
   ```

## json数据在前台的解析

定义json.jsp页面

```js
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script src="static/plugins/jquery/jquery-3.3.1.min.js">
    </script>
</head>
<body>
    <button id="b1">请求得到一个User</button>
    <button id="b2">请求得到一个Map</button>
    <button id="b3">请求得到以一个数组</button>
    <button id="b4">请求得到一个List</button>
    <div>
    </div>
</body>
</html>
```

1. 解析pojo

   ```js
   <script>
       $(function () {
           $('#b1').click(function () {
               $.ajax({
                   url:'${context}/json/test1',
                   type:'post',
                   success:function (data) {
                       alert(data.pwd);
                   }
               })
           })
       })
   </script>	
   ```

2. 解析Map

   ```js
   $('#b2').click(function () {
       $.ajax({
           url:'${context}/json/test2',
           type:'post',
           success:function (data) {
               alert(data.name);
               alert(data.age);
           }
       })
   })
   ```

3. 解析数组

   ```js
   $('#b3').click(function () {
       $.ajax({
           url:'${context}/json/test3',
           type:'post',
           success:function (data) {
               for (var i = 0; i < data.length; i++) {
                   alert(data[i].name);
                   alert(data[i].pwd);
               }
           }
       })
   })
   ```

4. 解析List

   ```js
   $('#b4').click(function () {
       $.ajax({
           url:'${context}/json/test4',
           type:'post',
           success:function (data) {
               for (var i = 0; i < data.length; i++) {
                   alert(data[i].name);
                   alert(data[i].pwd);
               }
           }
       })
   })
   ```

## Json数据使用Ajax传输到后台

指明数据类型

```js
contentType:"application/json;charset=utf-8"
```

如果使用form提交的数据，contentType为：

```js
contentType:"application/x-www-form-urlencoded"
```

### 通过Ajax发送一个User对象到后台

1. 前台

   ```js
   <%@ page contentType="text/html;charset=UTF-8" language="java" %>
   <html>
   <head>
       <title>Title</title>
       <script src="static/plugins/jquery/jquery-3.3.1.min.js"></script>
   </head>
   <body>
   <button id="b1">以Ajax发送一个User对象到后台</button>
   <script>
       $(function () {
   
           $('#b1').click(function () {
               var obj = {
                   'name': '小梁',
                   'pwd': 'xiaoliang'
               };
               $.ajax({
                   url: '${context}/json2/add',
                   type: 'post',
                   contentType: 'application/json',
                   data: JSON.stringify(obj),
                   success: function (data) {
   
                   }
               })
           })
       })
   </script>
   </body>
   </html>
   ```

2. 后台

   ```java
   package com.spring.controller;
   import com.spring.pojo.User;
   import org.springframework.stereotype.Controller;
   import org.springframework.web.bind.annotation.RequestBody;
   import org.springframework.web.bind.annotation.RequestMapping;
   @Controller
   @RequestMapping("/json2")
   public class JsonController2 {
       //前台提交一个user对象到后台
       @RequestMapping("/add")
       public String add(@RequestBody User user){
           System.out.println("Name:" + user.getName());
           System.out.println("Pwd:" + user.getPwd());
           return "msg";
       }
   
   }
   ```

### 通过Ajax发送一组User对象到后台

1. 前台

   ```jsp
   <%--
     Created by IntelliJ IDEA.
     User: Centos
     Date: 2019/1/6
     Time: 23:01
     To change this template use File | Settings | File Templates.
   --%>
   <%@ page contentType="text/html;charset=UTF-8" language="java" %>
   <html>
   <head>
       <title>Title</title>
       <script src="static/plugins/jquery/jquery-3.3.1.min.js"></script>
   </head>
   
   <body>
   <button id="b2">以Ajax发送一组User对象到后台</button>
   <script>
       $(function () {
           $('#b2').click(function () {
               var obj1 = {
                   'name': '小梁',
                   'pwd': 'xiaoliang'
               };
   
               var obj2 = {
                   'name':'软件建模',
                   'pwd':'UML2'
               };
               var arr = new Array();
               arr.push(obj1);
               arr.push(obj2);
   
               $.ajax({
                   url: '${context}/json2/addList',
                   type: 'post',
                   contentType: 'application/json',
                   data: JSON.stringify(arr),
                   success: function (data) {
   
                   }
               })
           })
       })
   </script>
   </body>
   </html>
   ```

2. 后台

   ```java
   package com.spring.controller;
   
   
   import com.spring.pojo.User;
   import org.springframework.stereotype.Controller;
   import org.springframework.web.bind.annotation.RequestBody;
   import org.springframework.web.bind.annotation.RequestMapping;
   import org.springframework.web.bind.annotation.ResponseBody;
   
   import java.util.List;
   
   
   @Controller
   @RequestMapping("/json2")
   public class JsonController2 {
   
       //前台提交一组user对象到后台
       @RequestMapping("/addList")
       @ResponseBody
       public void addList(@RequestBody List<User> user){
           System.out.println(user);
       }
   
   }
   ```

### 数据检测

1. 前端

   ```jsp
   <%--
     Created by IntelliJ IDEA.
     User: Centos
     Date: 2019/2/26
     Time: 16:58
     To change this template use File | Settings | File Templates.
   --%>
   <%@ page contentType="text/html;charset=UTF-8" language="java" %>
   <html>
   <head>
       <title>Title</title>
       <script src="${context}/static/plugin/jQuery/jquery-3.3.1.min.js"></script>
       
   </head>
   <body>
       <form action="${context}/user/register" method="post">
           用户名：<input type="text" name="name"><span id="msg"></span><br>
           密 码：<input type="password" name="password">
       </form>
   
       <script>
           $(function () {
               $('input[name=name]').blur(function () {
                   //获取用户名
                   var name = $('input[name=name]').val();
   
                   var obj = {
                       name:name
                   };
   
                   $.ajax({
                       url:'${context}/user/checkName',
                       type:'post',
                       contentType:'application/json',
                       data:JSON.stringify(obj),
                       success:function (data) {
                           if (data.code == 2000){
                               $('#msg').html("用户名可以使用");
                           }else {
                               $('#msg').html("用户名已被注册");
                           }
                       }
                   })
               })
           })
       </script>
   </body>
   </html>
   ```

2. 后端

   ```java
   package com.json.controller;
   
   import com.json.pojo.User;
   import org.springframework.stereotype.Controller;
   import org.springframework.web.bind.annotation.RequestBody;
   import org.springframework.web.bind.annotation.RequestMapping;
   import org.springframework.web.bind.annotation.ResponseBody;
   
   import java.util.HashMap;
   import java.util.Map;
   
   @Controller
   @RequestMapping("/user")
   public class UserController2 {
   
       @RequestMapping("/checkName")
       @ResponseBody
       public Map<String, Integer> checkName(@RequestBody User user){
           Map<String, Integer> map = new HashMap<>();
           int code = 400;
           if (!user.getName().equals("小梁")){
               code = 2000;
           }
           map.put("code", code);
           return map;
   
       }
   }
   ```

3. 

