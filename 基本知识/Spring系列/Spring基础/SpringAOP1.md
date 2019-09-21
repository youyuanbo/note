[TOC]



# SpringAOP 通过XMl文件进行配置

## 简介

1. 面向切面编程

## 配置

1. 配置自动代理

   ```xml
   <!--aop是基于代理模式完成的，现在配置自动代理-->
   <aop:aspectj-autoproxy/>
   ```

2. 创建需要的类

   一个BeforeAdvice类

   一个ProviderService类

3. 在applicationContext.xml文件中进入配置

   注册一个切面

   ```xml
   <bean class="com.spring.advice.BeforeAdvice" id="beforeAdvice"/>
   ```

   配置需要被切的bean

   ```xml
   <bean class="com.spring.service.ProviderService" id="providerService"/>
   ```

   配置切入点信息

   ```xml
   <aop:config>
       <!--定义切面-->
       <aop:aspect id="beforeAspect" ref="beforeAdvice">
           <!--aop:before,表明这是前置通知-->
           <!--method，指明使用哪一个方法-->
           <!--pointcut，切入点，指明到具体的包.类.方法-->
           <!--使用methodBefore来切-->
           <aop:before method="methodBefore" pointcut="execution(* com.spring.service.*.*(..))"></aop:before>
   
       </aop:aspect>
   </aop:config>
   ```

   切入点表达式：

   ```xml
   execution(* com.spring.service.*.*(..))
   ```

   第一个*：返回值类型，匹配任意返回值类型

   com.spring.service：包名称

   第二个*：匹配任意的类

   第三个*：匹配任意的方法

   (..)：匹配任意的参数，参数必须明确定义

   切无参:

   ```xml
   execution(* com.spring.service.*.*())
   ```

   一个参数:

   ```xml
   execution(* com.spring.service.*.*(java.lang.String))
   ```

   两个参数：

   ```xml
   execution(* com.spring.service.*.*(java.lang.String, java.lang.Integer))
   ```
