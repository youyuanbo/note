# Spring注解版开发

## 组件注册

Spring注解开发与使用XMl配置文件开发的区别：

  1.   不需要创建XML配置文件

  2.   需要创建一个配置类，在类上使用@==Configuration==注解声明

       使用注解开发

```java
package com.xiaoyou.config;

import com.xiaoyou.bean.Person;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration	//使用Configuration注解声明这是一个配置类
public class MainConfig {

    @Bean	//使用Bean注解，向容器中添加一个bean对象
    public Person person(){
        return new Person(22, "xiaoyou");
    }
}
```

​	使用XML配置文件

```xml
<bean id="person" class="com.xiaoyou.bean.Person">
    <property name="age" value="21"/>
    <property name="username" value="xiaoliang"/>
</bean>
```



配置全局扫描包：

​	使用注解

```java
	@ComponentScan(value = "com.xiaoyou")
```

​	使用xml文件

```xml
<context:component-scan base-package="com.xiaoyou"></context:component-scan>
```



排除指定组件

```java
@ComponentScan(value = "com.xiaoyou", excludeFilters =
    @ComponentScan.Filter(type = FilterType.ANNOTATION, classes = {Controller.class, Service.class}))
```

包含指定组件

使用类型分辨（==FilterType.ANNOTATION==）

```java
@ComponentScan(value = "com.xiaoyou", includeFilters =
    @ComponentScan.Filter(type = FilterType.ANNOTATION, classes = {Controller.class, Service.class}), useDefaultFilters = false)
```

多个ComponentScan注解

```java
@ComponentScan(value = "com.xiaoyou.controller", excludeFilters =
    @ComponentScan.Filter(type = FilterType.ANNOTATION, classes = {Service.class, Repository.class}))
@ComponentScan(value = "com.xiaoyou.service", excludeFilters =
    @ComponentScan.Filter(type = FilterType.ANNOTATION, classes = {Controller.class, Repository.class}))
@ComponentScan(value = "com.xiaoyou.dao", excludeFilters =
    @ComponentScan.Filter(type = FilterType.ANNOTATION, classes = {Controller.class, Service.class}))
```

多个FilterType：

​	FilterType.ANNOTATION：按照注解类型过滤

​	FilterType.ASSIGNABLE_TYPE：按照给定类型过滤

​	FilterType.ASPECTJ：使用ASPECTJ表达式

​	FilterType.REGEX：使用正则表达式

​	FilterType.SUCTOM：使用自定义

Scope注解：调整Bean的作用范围，使用在配置类的方法上

+ prototype：多实例
+ singleton：单实例（默认），ioc容器启动会调用方法创建对象放到ioc容器中，以后每次获取就直接从容器中获取（map.get() ）
+ request：相同请求，获取一个实例
+ session：同一个session创建一个实例

懒加载（@Lazy）：在配置类的方法上使用

​	容器启动的使用，不创建对象。在第一个获取Bean时，创建对象，并初始化，主要针对于单实例

==Conditional注解==：按照一定的条件进行判断，满足条件给容器中注册Bean

​	@Conditional(XXX.class)

==Import注解==：快速导入组件，

​	@Import({XXX.class, XXX.class})



## Bean的生命周期

​	Bean的生命周期：创建——初始化——销毁

指定初始化与销毁方法：

1. 通过@Bean指定init-method与destroy-method

   ```java
   @Bean(name = "car",initMethod = "init", destroyMethod = "destory")
   public Car car (){
       return new Car();
   }
   ```

2. 让Bean类实现InitializingBean与DisposableBean接口，然后覆写afterPropertiesSet与destroy方法

   ```java
   package com.xiaoyou.bean;
   
   import org.springframework.beans.factory.DisposableBean;
   import org.springframework.beans.factory.InitializingBean;
   import org.springframework.stereotype.Component;
   
   @Component
   public class Cat implements InitializingBean, DisposableBean {
       public Cat() {
           System.out.println("Cat Constructor");
       }
   
       @Override
       public void destroy() throws Exception {
           System.out.println("init");
       }
   
       @Override
       public void afterPropertiesSet() throws Exception {
           System.out.println("destroy");
       }
   }
   ```

3. 使用JSR250

   1. @PostConstruct：在Bean创建完成并且属性赋值完成，来执行初始化方法，用在Bean类的初始化方法上
   2. @PreDestroy：在容器销毁Bean之前，调用销毁方法，用在Bean类的销毁方法上

4. BeanPostProcessor：bean的后置处理器，在bean初始化前后进行一些处理工作

   1. postProcessBeforeInitialization：在bean初始化之前工作
   2. postProcessAfterInitialization：在Bean初始化之后工作
   3. 实现：编写一个类，实现BeanPostProcessor接口，重写postProcessBeforeInitialization与postProcessAfterInitialization方法。

```java
package com.xiaoyou.bean;

import org.springframework.beans.BeansException;
import org.springframework.beans.factory.config.BeanPostProcessor;
import org.springframework.stereotype.Component;

@Component
public class MyBeanProcessor implements BeanPostProcessor {
    @Override
    public Object postProcessBeforeInitialization(Object bean, String beanName) throws BeansException {
        System.out.println("postProcessBeforeInitialization\t" + beanName);
        return bean;
    }

    @Override
    public Object postProcessAfterInitialization(Object bean, String beanName) throws BeansException {
        System.out.println("postProcessAfterInitialization\t" + beanName);
        return bean;
    }
}
```

创建一个类实例的时候：调用构造，postProcessBeforeInitialization方法，初始化方法，postProcessAfterInitialization方法，销毁方法

## 属性赋值

1. 使用@Value注解，在此注解中，可以填写基本数值，SpEL，${}

   1. 使用在Bean类中，在属性上方使用此注解

      ```java
      @Value("22")
      private Integer age;
      @Value("xiaoyou")
      private String username;
      ```

   2. 在@Value中使用${}

      如果使用XML配置文件，需要在配置文件中指明资源文件位置

      ```xml
      <context:property-placeholder location="classpath:person.properties"></context:property-placeholder>
      ```

      如果使用注解，需要在注解类中指定资源文件的位置

      ```java
      @PropertySource(value = {"classpath:/person.properties"})
      ```

## 自动装配

@自动装配注解

1. 默认优先按照类型在容器中查找对应的组件：applicationContext.getBean(Book.class);

2. 如果找到多个相同类型的组件，再将属性的名称作为组件的id去容器中查找：applicationContext.getBean(“book”)

3. 使用@Qualifier(“book”)注解：可以指定需要装配的组件id，而不是使用属性名称

4. @Autowired(required=false): 如果在容器中没有找到组件，就不装配

5. @Primary：让Spring自动装配的时候，使用首选的Bean，此时不能使用@Qualifier 

6. @Resource：类似于@Autowired，存在于java规范，默认按照组件名称进行装配，使用name属性指定名称，不支持@Primary与@Autowired(required=false)

7. @Inject：使用此注解，需要导入依赖

   ```xml
   <!-- https://mvnrepository.com/artifact/javax.inject/javax.inject -->
   <dependency>
       <groupId>javax.inject</groupId>
       <artifactId>javax.inject</artifactId>
       <version>1</version>
   </dependency>
   ```

   与Autowired功能一样，但是没有required=false功能

   Resource与inject是java规范

8. @Autowired注解可以放在属性上，也可以放在方法上（setter），以及构造器上

9. Profile：可以根据当前环境，动态激活和切换一系列组件的功能，默认是“default”环境

   1. 使用命令行参数切换环境：-Dspring.profile.avtive=XXX
   2. 使用代码

   ```java
   @Test
   public void testProfile(){
       //1、创建一个ApplicationContext
       AnnotationConfigApplicationContext context = new AnnotationConfigApplicationContext();
       //2、设置需要激活的环境
       context.getEnvironment().setActiveProfiles("test", "develop");
       //3、注册主配置类
       context.register(MainConfigProfile.class);
       //4、启动刷新容器
       context.refresh();
   
       String[] beanDefinitionNames = context.getBeanDefinitionNames();
       for (String beanDefinitionName : beanDefinitionNames) {
           System.out.println(beanDefinitionName);
       }
   }
   ```

   3. 可以在配置类上使用Profile注解，只有在这个环境下时，才会加载配置类



## AOP

​	动态代理，指在程序运行期间，将某段代码切入到方法指定位置的编程方式

通知方法：

1. 前置通知：在目标程序运行之前执行，使用注解（@Before）
2. 后置通知：在目标程序运行之后执行，无论正常结束还是异常结束，都会调用，使用注解（@After）
3. 返回通知：在目标方法正常返回后执行，使用注解（@AfterReturning）
4. 异常通知：在目标方法异常返回后执行，使用注解（@AfterThrowing)
5. 环绕通知：动态代理，手动推进目标方法运行，使用注解（@Around）

获取返回值：

```java
@AfterReturning(value = "pointcut()", returning = "result")
public void logReturn(Object result) {
    System.out.println("除法正常返回 AfterReturning" + "运行结果：" + result);
}
```





其他注解：

1. @Aspect：声明一个类为切面类

2. @Pointcut：声明切点表达式，使用在一个方法上

   ```java
   @Pointcut("execution(public int com.xiaoyou.aop.MathCalculator.*(..))")
   public void pointcut(){
   
   }
   ```

3. @EnableAspectJAutoProxy：声明在配置类上，声明开启aop的自动代理

SpringAOP开发的步骤：

1. 将业务逻辑组件和切面类都加载到容器中，告诉Spring哪个类是切面类，使用@Aspect注解
2. 在切面类的每一个通知方法上标注通知注解，注解类型告诉Spring此方法在何时运行，切入点表达式告诉Spring此方法在何地运行
3. 开启基于注解的aop模式，使用注解@EnableAspectJAutoProxy



## 事务

声明式事务的步骤：

1. 导入相关的依赖：数据源（c3p0）、JdbcTemplate、Spring-jdbc模块

   ```xml
   <!-- https://mvnrepository.com/artifact/mysql/mysql-connector-java -->
   <dependency>
       <groupId>mysql</groupId>
       <artifactId>mysql-connector-java</artifactId>
       <version>5.1.47</version>
   </dependency>
   
   <!-- https://mvnrepository.com/artifact/com.mchange/c3p0 -->
   <dependency>
       <groupId>com.mchange</groupId>
       <artifactId>c3p0</artifactId>
       <version>0.9.5.4</version>
   </dependency>
   
   <!-- https://mvnrepository.com/artifact/org.springframework/spring-jdbc -->
   <dependency>
       <groupId>org.springframework</groupId>
       <artifactId>spring-jdbc</artifactId>
       <version>5.1.3.RELEASE</version>
   </dependency>
   ```

   

2. 配置数据源，JdbcTemplate（Spring提供的简化数据库操作的工具），操作数据

   ```properties
   db.username=root
   db.password=root
   db.url=jdbc:mysql://localhost:3306/jdbc
   db.Driver=com.mysql.jdbc.Driver
   ```

3. 给需要事务处理的方法上，添加@Transactional，表示当前方法是一个事务方法

   UserService.java

   ```java
   package com.xiaoyou.service;
   
   import com.xiaoyou.dao.UserDAO;
   import org.springframework.beans.factory.annotation.Autowired;
   import org.springframework.stereotype.Service;
   import org.springframework.transaction.annotation.Transactional;
   
   @Service
   public class UserService {
   
       @Autowired
       private UserDAO userDAO;
   
       @Transactional
       public void insertUSer(){
           userDAO.insert();
           System.out.println("插入完成。。");
           int i = 10/0;
       }
   }
   ```

   UserDAO.java

   ```java
   package com.xiaoyou.dao;
   
   import org.springframework.beans.factory.annotation.Autowired;
   import org.springframework.jdbc.core.JdbcTemplate;
   import org.springframework.stereotype.Repository;
   
   import java.util.UUID;
   
   @Repository
   public class UserDAO {
       @Autowired
       private JdbcTemplate jdbcTemplate;
   
       public void insert() {
           String sql = "insert into department(departmentName) values(?)";
           String departmentName = UUID.randomUUID().toString().substring(0, 5);
           jdbcTemplate.update(sql, departmentName);
       }
   }
   ```

4. 在配置类上面添加@EnableTransactionManagement注解，开启基于事务的管理功能

   ```java
   package com.xiaoyou.config;
   
   
   import com.mchange.v2.c3p0.ComboPooledDataSource;
   import org.springframework.beans.factory.annotation.Value;
   import org.springframework.context.annotation.Bean;
   import org.springframework.context.annotation.ComponentScan;
   import org.springframework.context.annotation.Configuration;
   import org.springframework.context.annotation.PropertySource;
   import org.springframework.jdbc.core.JdbcTemplate;
   import org.springframework.jdbc.datasource.DataSourceTransactionManager;
   import org.springframework.transaction.PlatformTransactionManager;
   import org.springframework.transaction.annotation.EnableTransactionManagement;
   
   import javax.sql.DataSource;
   import java.beans.PropertyVetoException;
   
   @Configuration
   @PropertySource("classpath:/jdbc.properties")
   @ComponentScan({"com.xiaoyou.service", "com.xiaoyou.dao"})
   @EnableTransactionManagement
   public class MainConfigOfTransaction {
       @Value("${db.username}")
       private String username;
   
       @Value("${db.password}")
       private String password;
   
       @Value("${db.url}")
       private String url;
   
       @Value("${db.Driver}")
       private String driver;
   
       @Bean
       public DataSource dataSource() throws PropertyVetoException {
           ComboPooledDataSource dataSource = new ComboPooledDataSource();
           dataSource.setUser(username);
           dataSource.setPassword(password);
           dataSource.setJdbcUrl(url);
           dataSource.setDriverClass(driver);
   
           return dataSource;
       }
   	
       //配置JdbcTemplate
       @Bean
       public JdbcTemplate jdbcTemplate(DataSource dataSource) {
           JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
   
   //        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource());
   
           return jdbcTemplate;
       }
   	
       //配置事务管理器
       @Bean
       public PlatformTransactionManager platformTransactionManager() throws PropertyVetoException {
           return new DataSourceTransactionManager(dataSource());
       }
   
   }
   ```

5. 在配置类中，将事务管理器（PlatformTransactionManager）添加到容器中

@Transactional注解

Spring源码

总结：

1. Spring容器在启动的时候，会保存所有注册的Bean定义信息
   1. 可以使用XML配置文件
   2. 可以使用@Bean注解
2. Spring容器会在合适的时机创建这些Bean
   1. 用到这个Bean的时候，利用getBean创建Bean，创建后，保存在容器中
   2. 统一创建剩下的所有Bean，调用finishBeanFactoryInitialization()
3. 后置处理
   1. 每一个Bean创建完成，都会使用各种后置处理器，来增强Bean的功能
      1. AutowiredAnnotationBeanPostProcessor：处理自动注入
      2. AnnotationAwareAspectJAutoProxyCreator：AOP功能
      3. AsyncAnnotationBeanPostProcessor：异步
4. 事件驱动模型
   1. ApplicationListener：事件监听
   2. ApplicationEventMulticaster：事件派发































