# Spring

## 编写一个简单的Spring程序

1. 添加Spring依赖

   ```xml
   <!-- https://mvnrepository.com/artifact/org.springframework/spring-beans -->
   <dependency>
       <groupId>org.springframework</groupId>
       <artifactId>spring-beans</artifactId>
       <version>5.1.3.RELEASE</version>
   </dependency>
   
   <!-- https://mvnrepository.com/artifact/org.springframework/spring-core -->
   <dependency>
       <groupId>org.springframework</groupId>
       <artifactId>spring-core</artifactId>
       <version>5.1.4.RELEASE</version>
   </dependency>
   
   <!-- https://mvnrepository.com/artifact/org.springframework/spring-context -->
   <dependency>
       <groupId>org.springframework</groupId>
       <artifactId>spring-context</artifactId>
       <version>5.1.4.RELEASE</version>
   </dependency>
   
   <!-- https://mvnrepository.com/artifact/org.springframework/spring-web -->
   <dependency>
       <groupId>org.springframework</groupId>
       <artifactId>spring-web</artifactId>
       <version>5.1.3.RELEASE</version>
   </dependency>
   
   <!-- https://mvnrepository.com/artifact/org.springframework/spring-webmvc -->
   <dependency>
       <groupId>org.springframework</groupId>
       <artifactId>spring-webmvc</artifactId>
       <version>5.1.3.RELEASE</version>
   </dependency>
   
   
   ```

2. 编写一个pojo类

   ```java
   package com.spring.pojo;
   
   public class User {
       private String name;
       private String password;
   
       public String getName() {
           return name;
       }
   
       public void setName(String name) {
           this.name = name;
       }
   
       public String getPassword() {
           return password;
       }
   
       public void setPassword(String password) {
           this.password = password;
       }
       
       @Override
       public String toString() {
           return "User{" +
                   "name='" + name + '\'' +
                   ", password='" + password + '\'' +
                   '}';
       }
   }
   
   ```

3. 编写Spring的配置文件

   创建一个applicationContext.xml文件，内容如下：

   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <beans xmlns="http://www.springframework.org/schema/beans"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://www.springframework.org/schema/beans
          http://www.springframework.org/schema/beans/spring-beans.xsd">
   
       <!--将对象的创建交给Spring容器，在此配置文件中声明所需要的对象-->
       <!--class: 所需创建对象的所在类，写Java类的权限定类名，通过反射完成对象的创建-->
       <!--id: 在此上下文中以便区分-->
       <bean class="com.spring.pojo.User" id="user">
           <property name="name" value="小梁"/>
           <property name="password" value="20181216"/>
       </bean>
   
   </beans>
   
   ```

4. 通过Spring的应用程序获取对象

   编写测试程序：

   ```java
   package com.spring.test;
   
   import com.spring.pojo.User;
   import org.junit.Test;
   import org.springframework.context.ApplicationContext;
   import org.springframework.context.support.ClassPathXmlApplicationContext;
   
   public class UserTest {
   
       @Test
       public void test1(){
           //获取上下文对象
           ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
           //通过上下文对象，获取pojo类对象
           User user = context.getBean("user", User.class);
           System.out.println(user);
   
       }
   
   }
   
   ```

5. 

