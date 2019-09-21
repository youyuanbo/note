[TOC]

# Spring

## 搭建环境



1. 添加Spring依赖

   添加Spring-core

   ```xml
   <dependency>
       <groupId>org.springframework</groupId>
       <artifactId>spring-core</artifactId>
       <version>5.1.3.RELEASE</version>
   </dependency>
   ```



   添加Spring-Beans

   ```xml
   <dependency>
       <groupId>org.springframework</groupId>
       <artifactId>spring-beans</artifactId>
       <version>5.1.3.RELEASE</version>
   </dependency>
   ```



   添加Spring-Context

   ```xml
   <dependency>
       <groupId>org.springframework</groupId>
       <artifactId>spring-context</artifactId>
       <version>5.1.3.RELEASE</version>
   </dependency>
   ```

2. 编写配置文件

   ```xml
   <bean id="girl" class="com.spring.pojo.Girl">
       <property name="name" value="Allen"/>
       <property name="age" value="18"/>
   </bean>
   ```

3. 通过Spring的应用程序上下文获取环境

   ```java
   ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
   Girl girl = context.getBean("girl", Girl.class);
   System.out.println(girl);
   ```

4. 

