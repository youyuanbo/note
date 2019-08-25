[TOC]



# 容器与Bean

## Spring中各种值得注入

1. 数组

   ```xml
   <property name="firends">
       <array>
           <value>刘德华</value>
           <value>郭富城</value>
           <value>黎明</value>
       </array>
   </property>
   ```

2. List

   ```xml
   <property name="numbers">
       <list>
           <value>1</value>
           <value>5</value>
           <value>7</value>
       </list>
   </property>
   ```

3. List

   ```xml
   <property name="cats">
       <list>
           <!--内部bean，无法被外部引用，所以不需要id-->
           <bean id="cat1" class="com.spring.pojo.Cat">
               <property name="name" value="波斯猫"/>
               <property name="age" value="10"/>
               <property name="color" value="白色"/>
           </bean>
           <bean id="cat2" class="com.spring.pojo.Cat">
               <property name="name" value="小黑猫"/>
               <property name="age" value="12"/>
               <property name="color" value="黑色"/>
           </bean>
       </list>
   </property>
   ```

4. Set

   ```xml
   <property name="flowers">
       <set>
           <bean id="flower1" class="com.spring.pojo.Flower">
               <property name="name" value="玫瑰"/>
               <property name="color" value="蓝色"/>
               <property name="number" value="999"/>
           </bean>
           <bean id="flower2" class="com.spring.pojo.Flower">
               <property name="name" value="牡丹"/>
               <property name="color" value="红色"/>
               <property name="number" value="999"/>
           </bean>
       </set>
   </property>
   ```


## 自动注入

1. byType：按照数据类型注入

   ```xml
   <bean id="user" class="com.spring.pojo.User" autowire="byType">
       <property name="name" value="小梁"/>
       <property name="tree" value="银杏"/>
   
   </bean>
   
   <bean id="flower" class="com.spring.pojo.Flower">
       <property name="name" value="玫瑰"/>
       <property name="color" value="蓝色"/>
       <property name="number" value="999"/>
   </bean>
   ```

2. byName：按照pojo类中的属性名称进行注入

3. byConstructor

4. default

5. none


## 依赖注入

使用ref进行依赖注入

```xml
<bean id="user" class="com.spring.pojo.User" >
    <property name="name" value="小梁"/>
    <property name="tree" value="银杏"/>
    <property name="flower" ref="flower"/>
</bean>
<bean id="flower" class="com.spring.pojo.Flower">
    <property name="name" value="玫瑰"/>
    <property name="color" value="蓝色"/>
    <property name="number" value="999"/>
</bean>
```

## 引入类路径下的资源文件

1. 在resources路径下存在一个jdbc.propertis资源文件

   ```pr
   url=jdbc:mysql://localhost:3306/spring
   driver=com.mysql.jdbc.Driver
   username=root
   password=root
   ```

2. 在resources.xml配置文件中引入资源文件

   ```xml
   <!--通过这种方式引入类路径下的文件-->
   <context:property-placeholder location="classpath:jdbc.properties"/>
   <!--引入资源文件中的数据-->
   <bean class="com.spring.pojo.ProviderDAO" id="dao">
       <property name="url" value="${url}"/>
       <property name="driver" value="${driver}"/>
       <property name="username" value="${username}"/>
       <property name="password" value="${password}"/>
   </bean>
   ```

3. 用一个applicationContext.xml配置文件包含其他配置文件

   ```xml
       <import resource="classpath:spring/spring-*.xml"/>
   ```


## 使用Annotation进行配置

### 注解：Service

1. 在类上面进行声明

   ```java
   package com.spring.service;
   import org.springframework.stereotype.Component;
   @Service("userService")
   public class UserService {
       
       public void eat(){
           System.out.println("User eat.");
       }
   }
   
   ```

2. 在配置文件中进行激活

   扫描该包以及其子包

   ```xml
   <context:component-scan base-package="com.spring.service"/>
   ```

3. 排除不需要扫描的包

   ```xml
   <context:component-scan base-package="com.spring.service">
       <context:exclude-filter type="annotation" expression="com.spring.service.exclude"/>
   </context:component-scan>
   ```

4. 

### Controller（SpringMVC，控制层）

### service（业务层）

### repository（DAO层，既数据访问层）

### Component（组件）







