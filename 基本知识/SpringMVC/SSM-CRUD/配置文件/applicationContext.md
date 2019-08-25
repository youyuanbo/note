# Spring配置文件

+ 文件名：applicationContext.xml
+ Spring配置文件主要配置和业务逻辑有关的，包含数据源，Spring与Mybatis的整合，事务控制等

## 头文件

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:context="http://www.springframework.org/schema/context"
       xmlns:aop="http://www.springframework.org/schema/aop"
       xmlns:tx="http://www.springframework.org/schema/tx"

       xsi:schemaLocation="
       http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd
       http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context.xsd
       http://www.springframework.org/schema/aop http://www.springframework.org/schema/aop/spring-aop.xsd
       http://www.springframework.org/schema/tx http://www.springframework.org/schema/tx/spring-tx.xsd">
    
</beans>
```

## 基础扫描包

+ 除了控制器，其他的类都扫描

```xml
<context:component-scan base-package="com.spring">
    <!--扫描Controller以外的其他所有注解-->
    <context:exclude-filter type="annotation" expression="org.springframework.stereotype.Controller"/>
</context:component-scan>
```

## 引入资源文件

+ 引入数据库连接信息的资源文件

```xml
<context:property-placeholder location="classpath:jdbc.properties"/>
```

## 配置数据源

+ 使用c3p0数据库连接池连接数据库

```xml
<bean id="pooledDataSource" class="com.mchange.v2.c3p0.ComboPooledDataSource">
    <property name="jdbcUrl" value="${jdbcUrl}"/>
    <property name="driverClass" value="${driverClass}"/>
    <property name="user" value="${user}"/>
    <property name="password" value="${password}"/>
</bean>
```

## Spring与Mybatis的整合

+ 注入SqlSessionFactoryBean
+ 指定Mybatis配置文件位置
+ 指定数据源
+ 指定Mapper映射文件位置
+ 将Mapper接口注入到容器中
+ 配置一个可以批量执行的sqlsession

```xml
<bean id="sqlSessionFactory" class="org.mybatis.spring.SqlSessionFactoryBean">
    <!--指定Mybatis全局配置文件的位置-->
    <property name="configLocation" value="classpath:mybatis-config.xml"/>
    <!--指定数据源，指向上面配置的数据源-->
    <property name="dataSource" ref="pooledDataSource"/>
    <!--指定Mybatis的Mapper文件的位置-->
    <property name="mapperLocations" value="classpath:com/spring/mapper/*.xml"/>
	<!--以属性的方式开启驼峰命名与下划线命名之间的自动转换-->
    <!--<property name="configuration">-->
        <!--<bean class="org.apache.ibatis.session.Configuration">-->
            <!--<property name="mapUnderscoreToCamelCase" value="true"/>-->
        <!--</bean>-->
    <!--</property>-->

</bean>

    </bean>

    <!--配置扫描器，将Mybatis接口的实现加入到ioc容器中-->
    <bean class="org.mybatis.spring.mapper.MapperScannerConfigurer">
        <!--扫描所有的Mapper接口-->
        <property name="basePackage" value="com.spring.mapper"/>
    </bean>

    <!--配置一个可以执行批量的SqlSession-->
    <bean id="sqlSession" class="org.mybatis.spring.SqlSessionTemplate">
        <constructor-arg name="sqlSessionFactory" ref="sqlSessionFactory"/>
        <!--配置一个可以批量执行的处理器-->
        <constructor-arg name="executorType" value="BATCH"/>
    </bean>
```

## 事务配置

+ 指定数据源
+ 配置事务（切入点、事务通知）
+ 事务的自动代理
+ 配置事务增强（属性）

```xml
<bean id="transactionManager" class="org.springframework.jdbc.datasource.DataSourceTransactionManager">
    <!--指定数据源-->
    <property name="dataSource" ref="pooledDataSource"/>
</bean>

<!--开启基于注解的事务，或者使用xml配置形式的事务（推荐使用xml配置完成）-->
<aop:config>
    <!--切入点表达式-->
    <aop:pointcut id="txPoint" expression="execution(* com.spring.service..*(..))"/>
    <!--配置事务增强-->
    <aop:advisor advice-ref="txAdvice" pointcut-ref="txPoint"></aop:advisor>
</aop:config>

<aop:aspectj-autoproxy/>
<aop:config proxy-target-class="true"></aop:config>

<!--配置事务增强-->
<tx:advice id="txAdvice">
    <tx:attributes>
        <!--切入的所有方法都是事务方法-->
        <tx:method name="*"/>
        <!--认为以get开头的所有方法都是查询，指定为readonly-->
        <tx:method name="get*" read-only="true"/>
    </tx:attributes>
</tx:advice>
```

