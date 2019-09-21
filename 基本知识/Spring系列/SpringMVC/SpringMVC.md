# SpringMVC

## 一个简单实例

### web.xml配置文件

```xml
<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
         xmlns="http://xmlns.jcp.org/xml/ns/javaee" 
         xsi:schemaLocation="
            http://xmlns.jcp.org/xml/ns/javaee 
            http://xmlns.jcp.org/xml/ns/javaee/web-app_3_1.xsd" 
            id="WebApp_ID" version="3.1">
    <display-name>Archetype Created Web Application</display-name>
    
    
    <!--注册一个前端控制器-->
    <servlet>
        
        <servlet-name>springmvc</servlet-name>
        <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
    </servlet>
    
    <!--servlet映射配置-->
    <servlet-mapping>
        <servlet-name>springmvc</servlet-name>
        <!--此处写“/”-->
        <url-pattern>/</url-pattern>
    </servlet-mapping>
</web-app>
```

url-pattern的取值：

1. /
2. /*（不建议使用）
3. *.do

### springmvc-servlet.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd">
    
    <!--配置一个视图解析器，常用内部资源解析器-->
    <bean class="org.springframework.web.servlet.view.InternalResourceViewResolver">
        <!--前缀-->
        <property name="prefix" value="/jsp"/>
        <!--后缀-->
        <property name="suffix" value=".jsp"/>
    </bean>
   
    <bean class="com.springmvc.controller.HelloController" name="/helloController"/>
</beans>
```

### 控制器 (GirlController.java)

```java
package com.mldn.controller;


import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;


//实现一个Controller接口方式
public class HelloController implements Controller {
    @Override
    public ModelAndView handleRequest(javax.servlet.http.HttpServletRequest httpServletRequest, javax.servlet.http.HttpServletResponse httpServletResponse) throws Exception {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("girl", "小梁");
        modelAndView.setViewName("girl");
        return modelAndView;
    }
}

```

### 前端显示 (girl.jsp)

```jsp
<%--
  Created by IntelliJ IDEA.
  User: Centos
  Date: 2019/1/5
  Time: 23:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    我的脑海：${girl}
</body>
</html>

```

## SpringMVC分析

### 关于前端控制器的解释

​	SpringMVC设计的理念是希望开发者尽量远离原生的ServletAPI。他将整体分为不同的组件。

### SpringMVC配置文件名字问题

​	默认情况下用dispatcherServlet的名字作为命名空间：

​	[namesapce]-servlet.xml(WEB-INF)之下寻找。

### 将springmvc-servlet.xml文件移至resources目录下

在web.xml文件的<servlet>标签下编写如下代码

```xml
<servlet>
    <servlet-name>springmvc</servlet-name>
    <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
    <init-param>
        <param-name>contextConfigLocation</param-name>
        <param-value>classpath:springmvc-servlet.xml</param-value>
    </init-param>
</servlet>
```

推荐使用此方式，来编写各自的配置文件

### 视图解析器

SpringMVC支持多种视图技术

- jsp
- freemaker

内部的资源视图解析器

- 视图的前缀
  + /jsp/  它是请求响应的资源的路径配置      viewName：girl       所以完整路径就是/jsp/girl
- 视图的后缀
  + .jsp    它是放在视图名称的后面	添加后缀的完整路径为：/jsp/girl.jsp

### 控制器解析

​	需要实现一个接口（Controller），这是一个函数式接口。

​	设计为ModelAndView。

​	在Model中填充数据，具体在视图中展示。

### 注解开发

基本注解：

 + @Controller

 + @RequestMapping

   + value 请求路径，可以匹配多个路径
   + path  value的别名，value与path二选一
   + method  请求的类型
   + params  参数

+ @GetMapping

  相当于在RequestMapping中设置method为GET，只能接受GET请求

+ @POSTMapping

  相当于在RequestMapping中设置method为GET，只能接受POST请求

+ @ModelAttribute

  使用@ModelAttribute声明的方法，会在Controller中的所有方法执行之前执行。

  ```java
  @ModelAttribute
  public User init(){
      System.out.println("init.........");
      User user = new User();
      user.setName("小梁");
      return user;
  }
  
  @RequestMapping("/model")
  public String model(Model mo){
      mo.addAttribute("model", "test");
      return "model";
  }
  ```

+ \



开发步骤

1. 配置自动扫描包
2. 在指定类上面添加@Controller注解
3. 添加@RequestMapping注解

### 请求路径

​	Springmvc支持ant风格

+ ”？“ 任意的字符，斜杠除外
+ `*`   0到多个任意的字符，不能存在斜杠
+ `**` 支持任意层的路径

### 过滤器

1. Servlet过滤器

   ```xml
   <!--注册一个前端控制器-->
   <servlet>
   
       <servlet-name>springmvc</servlet-name>
       <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
   
       <init-param>
           <param-name>contextConfigLocation</param-name>
           <param-value>classpath:springmvc-servlet.xml</param-value>
       </init-param>
   
   </servlet>
   <!--servlet映射配置-->
   <servlet-mapping>
       <servlet-name>springmvc</servlet-name>
       <!--此处写“/”-->
       <url-pattern>/</url-pattern>
   </servlet-mapping>
   ```

2. 字符编码过滤器

   ```xml
   <!--设置字符编码过滤器-->
   <filter>
       <filter-name>characterEncodingFilter</filter-name>
       <filter-class>org.springframework.web.filter.CharacterEncodingFilter</filter-class>
   
       <init-param>
           <param-name>encoding</param-name>
           <param-value>UTF-8</param-value>
       </init-param>
   </filter>
   
   <filter-mapping>
       <filter-name>characterEncodingFilter</filter-name>
       <url-pattern>/*</url-pattern>
   </filter-mapping>
   
   ```

3. http请求过滤器

   ```xml
   <!--注册一个支持所有http请求类型的过滤器-->
   <filter>
       <filter-name>hiddenHttpMethodFilter</filter-name>
       <filter-class>org.springframework.web.filter.HiddenHttpMethodFilter</filter-class>
   </filter>
   
   <filter-mapping>
       <filter-name>hiddenHttpMethodFilter</filter-name>
       <url-pattern>/*</url-pattern>
   </filter-mapping>
   ```

4. 

### 接受数据

1. 方式一

   + jsp页面



~~~jsp
 <%@ page contentType="text/html;charset=UTF-8" language="java" %>
 <html>
 <head>
     <title>Title</title>
 </head>
 <body>
     <form action="${context}/user/put" method="post">
         <input type="hidden" name="_method" value="put">
         <input type="text" name="name">
         <input type="submit" value="提交">
     </form>
 </body>
 </html>
 ```
~~~

   + 后台页面

     ```java
     package com.spring.controller;
     import org.springframework.stereotype.Controller;
     import org.springframework.web.bind.annotation.RequestMapping;
     import org.springframework.web.bind.annotation.ResponseBody;
     @Controller
     @RequestMapping("/user")
     public class UserController {
         @RequestMapping("/put")
         @ResponseBody
         public String  put(String name) {
             System.out.println(name);
             return null;
         }
     }
     ```

2. 方式二

   + jsp页面

     ```jsp
     <%@ page contentType="text/html;charset=UTF-8" language="java" %>
     <html>
     <head>
         <title>Title</title>
     </head>
     <body>
         <form action="${context}/user/put" method="post">
             <input type="hidden" name="_method" value="put">
             <input type="text" name="name">
             <input type="submit" value="提交">
         </form>
     </body>
     </html>
     ```

   + 后台页面

     ```java
     package com.spring.controller;
     import org.springframework.stereotype.Controller;
     import org.springframework.web.bind.annotation.RequestMapping;
     import org.springframework.web.bind.annotation.RequestParam;
     import org.springframework.web.bind.annotation.ResponseBody;
     @Controller
     @RequestMapping("/user")
     public class UserController {
         @RequestMapping("/put")
         @ResponseBody
         public String  put(@RequestParam("name") String name) {
             System.out.println(name);
             return null;
         }
     }
     ```

3. 直接利用javaBean接受数据

   + jsp页面

     ```jsp
     <%@ page contentType="text/html;charset=UTF-8" language="java" %>
     <html>
     <head>
         <title>Title</title>
     </head>
     <body>
         <form action="${context}/user/put" method="post">
             <input type="hidden" name="_method" value="put">
             <input type="text" name="name">
             <input type="submit" value="提交">
         </form>
     </body>
     </html>
     ```

   + 后台

     ```java
     package com.spring.controller;
     import com.spring.pojo.User;
     import org.springframework.stereotype.Controller;
     import org.springframework.web.bind.annotation.RequestMapping;
     @Controller
     @RequestMapping("/user")
     public class UserController {
         @RequestMapping("/put")
         public String  put(User user) {
             System.out.println(user.getName());
             return null;
         }
     }
     ```

   + 