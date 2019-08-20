# Annotation配置

##通过Annotation实现通知

1. 在applicationContext.xml文件中添加配置

   ```xml
   <!--配置自动代理-->
   <aop:aspectj-autoproxy/>
   
   <!--配置自动扫描包-->
   <context:component-scan base-package="com.spring"/>
   ```

2. 建立BeforeAdvice类和UserService类

   BeforeAdvice类

   ```java
   package com.spring.advice;
   
   
   import org.aspectj.lang.annotation.Aspect;
   import org.aspectj.lang.annotation.Before;
   import org.springframework.stereotype.Component;
   
   
   @Aspect     //标记其为一个切面
   @Component  //这个类为Spring的一个组件，相当于xml中的一个bean
   public class BeforeAdvice {
       
       @Before("execution(* com.spring.service.*.*(..))")
       public void beforeAdvice(){
           System.out.println("【前置通知】");
       }
   
   }
   ```



   UserService类

   ```java
   package com.spring.service;
   
   import org.springframework.stereotype.Component;
   
   @Component
   public class UserService {
       public void add(){
           System.out.println("【被切入的方法】");
       }
   }
   
   ```

3. 添加Annotation配置

   在通知类上添加Annotation

   ```java
   @Aspect     //标记其为一个切面
   @Component  //这个类为Spring的一个组件，相当于xml中的一个bean
   ```

   在通知方法上添加通知】

   ```java
       @Before("execution(* com.spring.service.*.*(..))")
   ```

   在被切方法上添加通知

   ```java
   @Component
   ```

4. \

## 通过Annotation实现自动扫描

1. 在类名上声明

   ```java
   @Configuration
   @ComponentScan(value = "com.spring")
   ```

   @Configuration：

   @ComponentScan(value = "com.spring") :配置自动扫描

2. 编写测试程序

   ```java
   ApplicationContext context = new AnnotationConfigApplicationContext(SpringConfig.class);
   Girl girl = context.getBean("girl", Girl.class);
   System.out.println(girl);
   ```

3. 

## 常用注解

1. @Configuration：标明一个类为配置类，程序启动时，需要扫描此类，以便可以明确所有的配置规则
2. @Component：表明一个类为Spring的一个组件，可以被Spring容器管理
3. @Service：表明一个类为Spring的一个组件，可以被Spring容器管理，用于服务层
4. @Repository：表明一个类为Spring的一个组件，可以被Spring容器管理，用于DAO层
5. @Control：表明一个类为Spring的一个组件，可以被Spring容器管理，用于控制层
6. @ComponentScan：组件扫描，可以决定扫描的范围
7. @Bean：用于在Spring容易中注册一个Bean
8. @Autowired：主动注入组件
9. 