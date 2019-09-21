# SSM增删改查

## 步骤

1. 创建Maven项目
2. 编写数据库脚本
3. 编写基础的Spring、springmvc、Mybatis配置文件和jdbc资源文件
4. 编写web.xml配置文件
5. 使用Mybatis Generator生成自动生成mapper接口文件和Mapper映射文件、pojo类
6. 测试数据库
7. 引入BootStrap前端框架，搭建页面基础样式
8. 编写前端，使用ajax发送请求，使用json交互数据
9. 编写Controller、Service
10. ok

## 前期配置准备

### 创建Maven工程，添加依赖

```xml
<?xml version="1.0" encoding="UTF-8"?>

<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>com.spring</groupId>
    <artifactId>SSM03</artifactId>
    <version>1.0-SNAPSHOT</version>
    <packaging>war</packaging>

    <name>SSM03 Maven Webapp</name>
    <!-- FIXME change it to the project's website -->
    <url>http://www.example.com</url>

    <properties>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <maven.compiler.source>1.7</maven.compiler.source>
        <maven.compiler.target>1.7</maven.compiler.target>
    </properties>

    <dependencies>


        <!--引入Spring依赖-->
        <!-- https://mvnrepository.com/artifact/org.springframework/spring-webmvc -->
        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-webmvc</artifactId>
            <version>5.1.3.RELEASE</version>
        </dependency>

        <!-- https://mvnrepository.com/artifact/org.springframework/spring-aspects -->
        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-aspects</artifactId>
            <version>5.1.3.RELEASE</version>
        </dependency>

        <!-- https://mvnrepository.com/artifact/org.springframework/spring-jdbc -->
        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-jdbc</artifactId>
            <version>5.1.3.RELEASE</version>
        </dependency>

        <!-- https://mvnrepository.com/artifact/org.springframework/spring-test -->
        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-test</artifactId>
            <version>5.1.3.RELEASE</version>
            <scope>test</scope>
        </dependency>

        <!--引入Mybatis依赖-->
        <!-- https://mvnrepository.com/artifact/org.mybatis/mybatis -->
        <dependency>
            <groupId>org.mybatis</groupId>
            <artifactId>mybatis</artifactId>
            <version>3.4.6</version>
        </dependency>

        <!--引入Spring与Mybatis整合依赖-->
        <!-- https://mvnrepository.com/artifact/org.mybatis/mybatis-spring -->
        <dependency>
            <groupId>org.mybatis</groupId>
            <artifactId>mybatis-spring</artifactId>
            <version>2.0.0</version>
        </dependency>

        <!--MybatisHelper分页插件-->
        <!-- https://mvnrepository.com/artifact/com.github.pagehelper/pagehelper -->
        <dependency>
            <groupId>com.github.pagehelper</groupId>
            <artifactId>pagehelper</artifactId>
            <version>5.1.8</version>
        </dependency>


        <!--数据库连接池-->
        <!-- https://mvnrepository.com/artifact/c3p0/c3p0 -->
        <dependency>
            <groupId>com.mchange</groupId>
            <artifactId>c3p0</artifactId>
            <version>0.9.5.2</version>
        </dependency>

        <!--数据库连接驱动-->
        <!-- https://mvnrepository.com/artifact/mysql/mysql-connector-java -->
        <dependency>
            <groupId>mysql</groupId>
            <artifactId>mysql-connector-java</artifactId>
            <version>5.1.47</version>
        </dependency>

        <!--引入jstl，servlet-api，junit依赖-->

        <!-- https://mvnrepository.com/artifact/jstl/jstl -->
        <dependency>
            <groupId>jstl</groupId>
            <artifactId>jstl</artifactId>
            <version>1.2</version>
        </dependency>

        <!-- https://mvnrepository.com/artifact/javax.servlet/javax.servlet-api -->
        <dependency>
            <groupId>javax.servlet</groupId>
            <artifactId>javax.servlet-api</artifactId>
            <version>3.1.0</version>
            <scope>provided</scope>
        </dependency>


        <dependency>
            <groupId>junit</groupId>
            <artifactId>junit</artifactId>
            <version>4.12</version>
            <scope>test</scope>
        </dependency>

        <!-- https://mvnrepository.com/artifact/org.mybatis.generator/mybatis-generator-maven-plugin -->
        <dependency>
            <groupId>org.mybatis.generator</groupId>
            <artifactId>mybatis-generator-maven-plugin</artifactId>
            <version>1.3.7</version>
        </dependency>

        <!-- https://mvnrepository.com/artifact/javax.servlet/javax.servlet-api -->
        <dependency>
            <groupId>javax.servlet</groupId>
            <artifactId>javax.servlet-api</artifactId>
            <version>4.0.1</version>
            <scope>provided</scope>
        </dependency>

        <!--返回json字符串的支持-->
        <!-- https://mvnrepository.com/artifact/com.fasterxml.jackson.core/jackson-databind -->
        <dependency>
            <groupId>com.fasterxml.jackson.core</groupId>
            <artifactId>jackson-databind</artifactId>
            <version>2.9.8</version>
        </dependency>

        <!--JSR303校验支持-->
        <!-- https://mvnrepository.com/artifact/org.hibernate/hibernate-validator -->
        <dependency>
            <groupId>org.hibernate</groupId>
            <artifactId>hibernate-validator</artifactId>
            <version>6.0.15.Final</version>
        </dependency>

    </dependencies>

    <build>
        <finalName>SSM03</finalName>
        <pluginManagement><!-- lock down plugins versions to avoid using Maven defaults (may be moved to parent pom) -->
            <plugins>
                <plugin>
                    <artifactId>maven-clean-plugin</artifactId>
                    <version>3.1.0</version>
                </plugin>
                <!-- see http://maven.apache.org/ref/current/maven-core/default-bindings.html#Plugin_bindings_for_war_packaging -->
                <plugin>
                    <artifactId>maven-resources-plugin</artifactId>
                    <version>3.0.2</version>
                </plugin>
                <plugin>
                    <artifactId>maven-compiler-plugin</artifactId>
                    <version>3.8.0</version>
                </plugin>
                <plugin>
                    <artifactId>maven-surefire-plugin</artifactId>
                    <version>2.22.1</version>
                </plugin>
                <plugin>
                    <artifactId>maven-war-plugin</artifactId>
                    <version>3.2.2</version>
                </plugin>
                <plugin>
                    <artifactId>maven-install-plugin</artifactId>
                    <version>2.5.2</version>
                </plugin>
                <plugin>
                    <artifactId>maven-deploy-plugin</artifactId>
                    <version>2.8.2</version>
                </plugin>

                <!--MyBatis自动生成工具插件-->
                <plugin>
                    <groupId>org.mybatis.generator</groupId>
                    <artifactId>mybatis-generator-maven-plugin</artifactId>
                    <version>1.3.7</version>
                    <configuration>
                        <configurationFile>src/main/resources/mybatis-generator.xml</configurationFile>
                        <verbose>true</verbose>
                        <overwrite>true</overwrite>
                    </configuration>
                </plugin>
            </plugins>

        </pluginManagement>


    </build>
</project>

```

### 准备数据库与表 

```
use ssm;

drop table if exists table_emp;

create table table_emp
(
  emp_id   int          not null auto_increment,
  emp_name varchar(255) not null,
  gender   char(1)      not null,
  email    varchar(255),
  d_id  int,
  primary key (emp_id),
  foreign key (d_id) references table_dept (dept_id)
);


drop table if exists table_dept;

create table table_dept
(
  dept_id   int          not null auto_increment,
  dept_name varchar(255) not null,
  primary key (dept_id)
);
```

### 建立各个文件夹与包，以及创建jdbc.properties资源文件、applicationContext.xml与springmvc.xml配置文件

### 使用Mybatis的逆向工程，生成javaBean、Mapper接口以及映射文件

### 编写jdbc.properties资源文件



```properties
driverClass=com.mysql.jdbc.Driver
jdbcUrl=jdbc:mysql://localhost:3306/ssm?useSSL=false
user=root
password=root
classPath=E:\\development_jar\\mysql-connector-java-5.1.47.jar
```

### 编写applicationContext.xml配置文件（此文件是spring的配置文件）

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:context="http://www.springframework.org/schema/context"
       xmlns:aop="http://www.springframework.org/schema/aop"
       xmlns:tx="http://www.springframework.org/schema/tx"

       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd
       http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context.xsd
       http://www.springframework.org/schema/aop http://www.springframework.org/schema/aop/spring-aop.xsd
       http://www.springframework.org/schema/tx http://www.springframework.org/schema/tx/spring-tx.xsd">

    <!--Spring的配置文件，这里主要配置和业务逻辑有关的-->
    <!--spring配置文件的核心点：数据源，与Mybatis的整合，事务控制-->

    <!--配置基础扫描包-->
    <context:component-scan base-package="com.spring">
        <!--扫描Controller以外的其他所有注解-->
        <context:exclude-filter type="annotation" expression="org.springframework.stereotype.Controller"/>
    </context:component-scan>
    <!--引入配置文件-->
    <context:property-placeholder location="classpath:jdbc.properties"/>



    <!--=====================配置数据源==============================-->
    <bean id="pooledDataSource" class="com.mchange.v2.c3p0.ComboPooledDataSource">
        <property name="jdbcUrl" value="${jdbcUrl}"/>
        <property name="driverClass" value="${driverClass}"/>
        <property name="user" value="${user}"/>
        <property name="password" value="${password}"/>
    </bean>



    <!--==========================配置Spring与Mybatis的整合=======================-->
    <bean id="sqlSessionFactory" class="org.mybatis.spring.SqlSessionFactoryBean">
        <!--指定Mybatis全局配置文件的位置-->
        <property name="configLocation" value="classpath:mybatis-config.xml"/>
        <!--指定数据源，指向上面配置的数据源-->
        <property name="dataSource" ref="pooledDataSource"/>
        <!--指定Mybatis的Mapper文件的位置-->
        <property name="mapperLocations" value="classpath:com/spring/mapper/*.xml"/>

        <!--<property name="configuration">-->
            <!--<bean class="org.apache.ibatis.session.Configuration">-->
                <!--<property name="mapUnderscoreToCamelCase" value="true"/>-->
            <!--</bean>-->
        <!--</property>-->

    </bean>

    <!--配置扫描器，将Mybatis接口的实现加入到ioc容器中-->
    <bean class="org.mybatis.spring.mapper.MapperScannerConfigurer">
        <!--扫描所有的Mapper接口-->
        <property name="basePackage" value="com.spring.mapper"/>
    </bean>

    <!--配置一个可以执行批量的SqlSession-->
    <bean id="sqlSession" class="org.mybatis.spring.SqlSessionTemplate">
        <constructor-arg name="sqlSessionFactory" ref="sqlSessionFactory"/>
        <constructor-arg name="executorType" value="BATCH"/>

    </bean>

    <!--==============================配置事务控制===================================-->
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

</beans>
```

### 编写Springmvc.xml配置文件（此文件是springmvc的配置文件）

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:context="http://www.springframework.org/schema/context"
       xmlns:mvc="http://www.springframework.org/schema/mvc"
       xsi:schemaLocation="
       http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd
       http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context.xsd
       http://www.springframework.org/schema/mvc http://www.springframework.org/schema/mvc/spring-mvc.xsd">

    <!--这是springmvc配置文件，包含网站跳转逻辑控制-->

    <context:component-scan base-package="com.spring" use-default-filters="false">
        <!--只扫描控制器-->
        <context:include-filter type="annotation"
                                expression="org.springframework.stereotype.Controller"></context:include-filter>
    </context:component-scan>

    <!--配置视图解析器-->
    <bean id="internalResourceViewResolver" class="org.springframework.web.servlet.view.InternalResourceViewResolver">
        <property name="prefix" value="/jsp/"/>
        <property name="suffix" value=".jsp"/>
    </bean>

    <!--两个标准配置-->
    <!--将springmvc不能处理的请求交给tomcat-->
    <mvc:default-servlet-handler/>

    <!--配置一些更高级的功能，JSR303校验，快捷的Ajax，映射动态请求-->
    <mvc:annotation-driven/>


</beans>
```

### mybatis-config.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE configuration PUBLIC "-//mybatis.org//DTD Config 3.0//EN" "http://mybatis.org/dtd/mybatis-3-config.dtd">
<configuration>

    <settings>
        <!-- Globally enables or disables any caches configured in any mapper under this configuration -->
        <setting name="cacheEnabled" value="false"/>
        <!-- Sets the number of seconds the driver will wait for a response from the database -->
        <setting name="defaultStatementTimeout" value="5"/>
        <!-- Enables automatic mapping from classic database column names A_COLUMN to camel case classic Java property names aColumn -->
        <setting name="mapUnderscoreToCamelCase" value="true"/>
        <!-- Allows JDBC support for generated keys. A compatible driver is required.
        This setting forces generated keys to be used if set to true,
         as some drivers deny compatibility but still work -->
        <setting name="useGeneratedKeys" value="true"/>
    </settings>

    <!-- Continue editing here -->

    <plugins>
        <!-- com.github.pagehelper为PageHelper类所在包名 -->
        <plugin interceptor="com.github.pagehelper.PageInterceptor">
            <!--分页合理化参数，默认值为false。当该参数设置为 true 时，pageNum<=0 时会查询第一页， pageNum>pages（超过总数时），会查询最后一页。默认false 时，直接根据参数进行查询。-->
            <property name="reasonable" value="true"/>
        </plugin>
    </plugins>


</configuration>
```

### 编写web.xml配置文件

```xml
<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xmlns="http://xmlns.jcp.org/xml/ns/javaee"
         xsi:schemaLocation="
            http://xmlns.jcp.org/xml/ns/javaee 
            http://xmlns.jcp.org/xml/ns/javaee/web-app_3_1.xsd"
         id="WebApp_ID" version="3.1">

    <!--1、启动Spring容器-->
    <context-param>
        <param-name>contextConfigLocation</param-name>
        <param-value>classpath:applicationContext.xml</param-value>
    </context-param>
    
    
    <listener>
        <listener-class>org.springframework.web.context.ContextLoaderListener</listener-class>
    </listener>

    <!--2、Springmvc的前端控制器，拦截所有的请求-->
    <servlet>
        <servlet-name>dispatcherServlet</servlet-name>
        <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
        <init-param>
            <param-name>contextConfigLocation</param-name>
            <param-value>classpath:springmvc.xml</param-value>
        </init-param>
        <load-on-startup>1</load-on-startup>
    </servlet>
    
    <servlet-mapping>
        <servlet-name>dispatcherServlet</servlet-name>
        <url-pattern>/</url-pattern>
    </servlet-mapping>

    <!--3、字符编码过滤器,放在所有过滤器之前-->
    <filter>
        <filter-name>encodingFilter</filter-name>
        <filter-class>org.springframework.web.filter.CharacterEncodingFilter</filter-class>
        <init-param>
            <param-name>encoding</param-name>
            <param-value>UTF-8</param-value>
        </init-param>

        <init-param>
            <param-name>forceRequestEncoding</param-name>
            <param-value>true</param-value>
        </init-param>

        <init-param>
            <param-name>forceResponseEncoding</param-name>
            <param-value>true</param-value>
        </init-param>
    </filter>
    <filter-mapping>
        <filter-name>encodingFilter</filter-name>
        <url-pattern>/*</url-pattern>
    </filter-mapping>

    <!--4、使用Rest风格的URI，将页面的普通post转换为指定的delete或者put请求-->
    <filter>
        <filter-name>hiddenHttpMethodFilter</filter-name>
        <filter-class>org.springframework.web.filter.HiddenHttpMethodFilter</filter-class>
    </filter>

    <filter-mapping>
        <filter-name>hiddenHttpMethodFilter</filter-name>
        <url-pattern>/*</url-pattern>
    </filter-mapping>

</web-app>
```



## 测试

### 测试Mapper与数据库



```java
package com.spring.test;

import com.spring.mapper.DepartmentMapper;
import com.spring.mapper.EmployerMapper;
import com.spring.pojo.Department;
import com.spring.pojo.Employer;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

/**
 * 使用Spring-test单元测试模块
 * 1. 使用@ContextConfiguration注解指定配置文件位置
 * 2. 使用@RunWith指定使用使用Spring-test中的单元测试模块
 * 3. 直接Autowired需要使用的主键即可
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class TestDeptMapper {

    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    EmployerMapper employerMapper;

    @Autowired
    SqlSession sqlSession;

    @Test
    public void testInsert(){

        /*
        //原始测试
        //1. 创建SpringIOC容器
        ApplicationContext ioc = new ClassPathXmlApplicationContext("classpath:applicationContext.xml");
        //2. 从容器中获取mapper
        DepartmentMapper bean = ioc.getBean(DepartmentMapper.class);
        */


        //插入部门数据
        departmentMapper.insertSelective(new Department(null,"开发部"));
        departmentMapper.insertSelective(new Department(null,"测试部"));

        //插入部门数据
        employerMapper.insertSelective(new Employer(null, "小梁", "F", "312202171@qq.com", 1));
        employerMapper.insertSelective(new Employer(null, "小游", "M", "1047795132@qq.com", 2));
        // 批量生成测试数据
        EmployerMapper mapper = sqlSession.getMapper(EmployerMapper.class);
        for (int i = 0; i < 1000; i++) {
//            // 使用UUID生成姓名
            String name = UUID.randomUUID().toString().substring(0, 5) + i;
            mapper.insertSelective(new Employer(null, name, "M", name + "@centos.com",1));
        }
    }

    @Test
    public void testSelect(){
        Department department = departmentMapper.selectByPrimaryKey(1);
        System.out.println(department);

        Employer employer = employerMapper.selectByPrimaryKeyWithDept(2);
        System.out.println(employer);
    }

}
```

### 测试EmployeeController

```java
package com.spring.test;

import com.github.pagehelper.PageInfo;
import com.spring.pojo.Employer;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

/**
 * 使用Spring单元测试模块提供的测试请求功能
 */
@RunWith(SpringJUnit4ClassRunner.class)
// 指定spring和springmvc的配置文件位置
@ContextConfiguration(locations = {"classpath:applicationContext.xml", "classpath:springmvc.xml"})
@WebAppConfiguration
public class MVCTest {
    //虚拟mvc请求，获取到处理结果
    MockMvc mockMvc;
    //传入Springmvc的ioc
    @Autowired
    WebApplicationContext context;

    @Before //初始化mockmvc
    public void initMockMvc() {
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    public void testPage() throws Exception {
        // 模拟请求，并获取返回值
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/employee/getEmps").param("pn", "5")).andReturn();

        //请求成功以后，请求域中会有pageInfo，可以利用pageInfo进行验证
        MockHttpServletRequest request = result.getRequest();
        PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
        System.out.println("当前页码：" + pageInfo.getPageNum());
        System.out.println("总页码：" + pageInfo.getPages());
        System.out.println("总记录数：" + pageInfo.getTotal());
        System.out.println("在页面需要连续显示的页码：");
        int[] navigatepageNums = pageInfo.getNavigatepageNums();
        for (int i : navigatepageNums) {
            System.out.print(" " + i);
        }
        System.out.println();

        //获取员工数据
        List<Employer> list = pageInfo.getList();
        for (Employer employer : list) {
            System.out.println("ID:" + employer.getEmpId() + ",Name:" + employer.getEmpName());
        }

    }

}
```

+ 、

## pojo

###　Department

```java
package com.spring.pojo;

public class Department {
    private Integer deptId;

    private String deptName;

    public Department() {
    }

    public Department(Integer deptId, String deptName) {
        this.deptId = deptId;
        this.deptName = deptName;
    }

    public Integer getDeptId() {
        return deptId;
    }

    public void setDeptId(Integer deptId) {
        this.deptId = deptId;
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }

    @Override
    public String toString() {
        return "Department{" +
                "deptId=" + deptId +
                ", deptName='" + deptName + '\'' +
                '}';
    }
}
```





### DepartmentExample

```java
package com.spring.pojo;

import java.util.ArrayList;
import java.util.List;

public class DepartmentExample {
    protected String orderByClause;

    protected boolean distinct;

    protected List<Criteria> oredCriteria;

    public DepartmentExample() {
        oredCriteria = new ArrayList<Criteria>();
    }

    public void setOrderByClause(String orderByClause) {
        this.orderByClause = orderByClause;
    }

    public String getOrderByClause() {
        return orderByClause;
    }

    public void setDistinct(boolean distinct) {
        this.distinct = distinct;
    }

    public boolean isDistinct() {
        return distinct;
    }

    public List<Criteria> getOredCriteria() {
        return oredCriteria;
    }

    public void or(Criteria criteria) {
        oredCriteria.add(criteria);
    }

    public Criteria or() {
        Criteria criteria = createCriteriaInternal();
        oredCriteria.add(criteria);
        return criteria;
    }

    public Criteria createCriteria() {
        Criteria criteria = createCriteriaInternal();
        if (oredCriteria.size() == 0) {
            oredCriteria.add(criteria);
        }
        return criteria;
    }

    protected Criteria createCriteriaInternal() {
        Criteria criteria = new Criteria();
        return criteria;
    }

    public void clear() {
        oredCriteria.clear();
        orderByClause = null;
        distinct = false;
    }

    protected abstract static class GeneratedCriteria {
        protected List<Criterion> criteria;

        protected GeneratedCriteria() {
            super();
            criteria = new ArrayList<Criterion>();
        }

        public boolean isValid() {
            return criteria.size() > 0;
        }

        public List<Criterion> getAllCriteria() {
            return criteria;
        }

        public List<Criterion> getCriteria() {
            return criteria;
        }

        protected void addCriterion(String condition) {
            if (condition == null) {
                throw new RuntimeException("Value for condition cannot be null");
            }
            criteria.add(new Criterion(condition));
        }

        protected void addCriterion(String condition, Object value, String property) {
            if (value == null) {
                throw new RuntimeException("Value for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value));
        }

        protected void addCriterion(String condition, Object value1, Object value2, String property) {
            if (value1 == null || value2 == null) {
                throw new RuntimeException("Between values for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value1, value2));
        }

        public Criteria andDeptIdIsNull() {
            addCriterion("dept_id is null");
            return (Criteria) this;
        }

        public Criteria andDeptIdIsNotNull() {
            addCriterion("dept_id is not null");
            return (Criteria) this;
        }

        public Criteria andDeptIdEqualTo(Integer value) {
            addCriterion("dept_id =", value, "deptId");
            return (Criteria) this;
        }

        public Criteria andDeptIdNotEqualTo(Integer value) {
            addCriterion("dept_id <>", value, "deptId");
            return (Criteria) this;
        }

        public Criteria andDeptIdGreaterThan(Integer value) {
            addCriterion("dept_id >", value, "deptId");
            return (Criteria) this;
        }

        public Criteria andDeptIdGreaterThanOrEqualTo(Integer value) {
            addCriterion("dept_id >=", value, "deptId");
            return (Criteria) this;
        }

        public Criteria andDeptIdLessThan(Integer value) {
            addCriterion("dept_id <", value, "deptId");
            return (Criteria) this;
        }

        public Criteria andDeptIdLessThanOrEqualTo(Integer value) {
            addCriterion("dept_id <=", value, "deptId");
            return (Criteria) this;
        }

        public Criteria andDeptIdIn(List<Integer> values) {
            addCriterion("dept_id in", values, "deptId");
            return (Criteria) this;
        }

        public Criteria andDeptIdNotIn(List<Integer> values) {
            addCriterion("dept_id not in", values, "deptId");
            return (Criteria) this;
        }

        public Criteria andDeptIdBetween(Integer value1, Integer value2) {
            addCriterion("dept_id between", value1, value2, "deptId");
            return (Criteria) this;
        }

        public Criteria andDeptIdNotBetween(Integer value1, Integer value2) {
            addCriterion("dept_id not between", value1, value2, "deptId");
            return (Criteria) this;
        }

        public Criteria andDeptNameIsNull() {
            addCriterion("dept_name is null");
            return (Criteria) this;
        }

        public Criteria andDeptNameIsNotNull() {
            addCriterion("dept_name is not null");
            return (Criteria) this;
        }

        public Criteria andDeptNameEqualTo(String value) {
            addCriterion("dept_name =", value, "deptName");
            return (Criteria) this;
        }

        public Criteria andDeptNameNotEqualTo(String value) {
            addCriterion("dept_name <>", value, "deptName");
            return (Criteria) this;
        }

        public Criteria andDeptNameGreaterThan(String value) {
            addCriterion("dept_name >", value, "deptName");
            return (Criteria) this;
        }

        public Criteria andDeptNameGreaterThanOrEqualTo(String value) {
            addCriterion("dept_name >=", value, "deptName");
            return (Criteria) this;
        }

        public Criteria andDeptNameLessThan(String value) {
            addCriterion("dept_name <", value, "deptName");
            return (Criteria) this;
        }

        public Criteria andDeptNameLessThanOrEqualTo(String value) {
            addCriterion("dept_name <=", value, "deptName");
            return (Criteria) this;
        }

        public Criteria andDeptNameLike(String value) {
            addCriterion("dept_name like", value, "deptName");
            return (Criteria) this;
        }

        public Criteria andDeptNameNotLike(String value) {
            addCriterion("dept_name not like", value, "deptName");
            return (Criteria) this;
        }

        public Criteria andDeptNameIn(List<String> values) {
            addCriterion("dept_name in", values, "deptName");
            return (Criteria) this;
        }

        public Criteria andDeptNameNotIn(List<String> values) {
            addCriterion("dept_name not in", values, "deptName");
            return (Criteria) this;
        }

        public Criteria andDeptNameBetween(String value1, String value2) {
            addCriterion("dept_name between", value1, value2, "deptName");
            return (Criteria) this;
        }

        public Criteria andDeptNameNotBetween(String value1, String value2) {
            addCriterion("dept_name not between", value1, value2, "deptName");
            return (Criteria) this;
        }
    }

    public static class Criteria extends GeneratedCriteria {

        protected Criteria() {
            super();
        }
    }

    public static class Criterion {
        private String condition;

        private Object value;

        private Object secondValue;

        private boolean noValue;

        private boolean singleValue;

        private boolean betweenValue;

        private boolean listValue;

        private String typeHandler;

        public String getCondition() {
            return condition;
        }

        public Object getValue() {
            return value;
        }

        public Object getSecondValue() {
            return secondValue;
        }

        public boolean isNoValue() {
            return noValue;
        }

        public boolean isSingleValue() {
            return singleValue;
        }

        public boolean isBetweenValue() {
            return betweenValue;
        }

        public boolean isListValue() {
            return listValue;
        }

        public String getTypeHandler() {
            return typeHandler;
        }

        protected Criterion(String condition) {
            super();
            this.condition = condition;
            this.typeHandler = null;
            this.noValue = true;
        }

        protected Criterion(String condition, Object value, String typeHandler) {
            super();
            this.condition = condition;
            this.value = value;
            this.typeHandler = typeHandler;
            if (value instanceof List<?>) {
                this.listValue = true;
            } else {
                this.singleValue = true;
            }
        }

        protected Criterion(String condition, Object value) {
            this(condition, value, null);
        }

        protected Criterion(String condition, Object value, Object secondValue, String typeHandler) {
            super();
            this.condition = condition;
            this.value = value;
            this.secondValue = secondValue;
            this.typeHandler = typeHandler;
            this.betweenValue = true;
        }

        protected Criterion(String condition, Object value, Object secondValue) {
            this(condition, value, secondValue, null);
        }
    }
}
```

### Employer

```java
package com.spring.pojo;

import javax.validation.constraints.Email;
import javax.validation.constraints.Pattern;

public class Employer {
    private Integer empId;

    @Pattern(regexp = "(^[a-zA-Z 0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})", message = "用户名必须是2-5为中文或者6-16为英文和数字的组合。")
    private String empName;

    private String gender;

//    @Email
    @Pattern(regexp = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$", message = "邮箱格式不正确。")
    private String email;

    private Integer dId;

    private Department department;

    public Employer() {
    }

    public Employer(Integer empId, String empName, String gender, String email, Integer dId) {
        this.empId = empId;
        this.empName = empName;
        this.gender = gender;
        this.email = email;
        this.dId = dId;
    }

    public Integer getEmpId() {
        return empId;
    }

    public void setEmpId(Integer empId) {
        this.empId = empId;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Integer getdId() {
        return dId;
    }

    public void setdId(Integer dId) {
        this.dId = dId;
    }

    public Department getDepartment() {
        return department;
    }

    public void setDepartment(Department department) {
        this.department = department;
    }

    @Override
    public String toString() {
        return "Employer{" +
                "empId=" + empId +
                ", empName='" + empName + '\'' +
                ", gender='" + gender + '\'' +
                ", email='" + email + '\'' +
                ", dId=" + dId +
                ", department=" + department +
                '}';
    }
}
```

###　EmployerExample

```java
package com.spring.pojo;

import java.util.ArrayList;
import java.util.List;

public class EmployerExample {
    protected String orderByClause;

    protected boolean distinct;

    protected List<Criteria> oredCriteria;

    public EmployerExample() {
        oredCriteria = new ArrayList<Criteria>();
    }

    public void setOrderByClause(String orderByClause) {
        this.orderByClause = orderByClause;
    }

    public String getOrderByClause() {
        return orderByClause;
    }

    public void setDistinct(boolean distinct) {
        this.distinct = distinct;
    }

    public boolean isDistinct() {
        return distinct;
    }

    public List<Criteria> getOredCriteria() {
        return oredCriteria;
    }

    public void or(Criteria criteria) {
        oredCriteria.add(criteria);
    }

    public Criteria or() {
        Criteria criteria = createCriteriaInternal();
        oredCriteria.add(criteria);
        return criteria;
    }

    public Criteria createCriteria() {
        Criteria criteria = createCriteriaInternal();
        if (oredCriteria.size() == 0) {
            oredCriteria.add(criteria);
        }
        return criteria;
    }

    protected Criteria createCriteriaInternal() {
        Criteria criteria = new Criteria();
        return criteria;
    }

    public void clear() {
        oredCriteria.clear();
        orderByClause = null;
        distinct = false;
    }

    protected abstract static class GeneratedCriteria {
        protected List<Criterion> criteria;

        protected GeneratedCriteria() {
            super();
            criteria = new ArrayList<Criterion>();
        }

        public boolean isValid() {
            return criteria.size() > 0;
        }

        public List<Criterion> getAllCriteria() {
            return criteria;
        }

        public List<Criterion> getCriteria() {
            return criteria;
        }

        protected void addCriterion(String condition) {
            if (condition == null) {
                throw new RuntimeException("Value for condition cannot be null");
            }
            criteria.add(new Criterion(condition));
        }

        protected void addCriterion(String condition, Object value, String property) {
            if (value == null) {
                throw new RuntimeException("Value for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value));
        }

        protected void addCriterion(String condition, Object value1, Object value2, String property) {
            if (value1 == null || value2 == null) {
                throw new RuntimeException("Between values for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value1, value2));
        }

        public Criteria andEmpIdIsNull() {
            addCriterion("emp_id is null");
            return (Criteria) this;
        }

        public Criteria andEmpIdIsNotNull() {
            addCriterion("emp_id is not null");
            return (Criteria) this;
        }

        public Criteria andEmpIdEqualTo(Integer value) {
            addCriterion("emp_id =", value, "empId");
            return (Criteria) this;
        }

        public Criteria andEmpIdNotEqualTo(Integer value) {
            addCriterion("emp_id <>", value, "empId");
            return (Criteria) this;
        }

        public Criteria andEmpIdGreaterThan(Integer value) {
            addCriterion("emp_id >", value, "empId");
            return (Criteria) this;
        }

        public Criteria andEmpIdGreaterThanOrEqualTo(Integer value) {
            addCriterion("emp_id >=", value, "empId");
            return (Criteria) this;
        }

        public Criteria andEmpIdLessThan(Integer value) {
            addCriterion("emp_id <", value, "empId");
            return (Criteria) this;
        }

        public Criteria andEmpIdLessThanOrEqualTo(Integer value) {
            addCriterion("emp_id <=", value, "empId");
            return (Criteria) this;
        }

        public Criteria andEmpIdIn(List<Integer> values) {
            addCriterion("emp_id in", values, "empId");
            return (Criteria) this;
        }

        public Criteria andEmpIdNotIn(List<Integer> values) {
            addCriterion("emp_id not in", values, "empId");
            return (Criteria) this;
        }

        public Criteria andEmpIdBetween(Integer value1, Integer value2) {
            addCriterion("emp_id between", value1, value2, "empId");
            return (Criteria) this;
        }

        public Criteria andEmpIdNotBetween(Integer value1, Integer value2) {
            addCriterion("emp_id not between", value1, value2, "empId");
            return (Criteria) this;
        }

        public Criteria andEmpNameIsNull() {
            addCriterion("emp_name is null");
            return (Criteria) this;
        }

        public Criteria andEmpNameIsNotNull() {
            addCriterion("emp_name is not null");
            return (Criteria) this;
        }

        public Criteria andEmpNameEqualTo(String value) {
            addCriterion("emp_name =", value, "empName");
            return (Criteria) this;
        }

        public Criteria andEmpNameNotEqualTo(String value) {
            addCriterion("emp_name <>", value, "empName");
            return (Criteria) this;
        }

        public Criteria andEmpNameGreaterThan(String value) {
            addCriterion("emp_name >", value, "empName");
            return (Criteria) this;
        }

        public Criteria andEmpNameGreaterThanOrEqualTo(String value) {
            addCriterion("emp_name >=", value, "empName");
            return (Criteria) this;
        }

        public Criteria andEmpNameLessThan(String value) {
            addCriterion("emp_name <", value, "empName");
            return (Criteria) this;
        }

        public Criteria andEmpNameLessThanOrEqualTo(String value) {
            addCriterion("emp_name <=", value, "empName");
            return (Criteria) this;
        }

        public Criteria andEmpNameLike(String value) {
            addCriterion("emp_name like", value, "empName");
            return (Criteria) this;
        }

        public Criteria andEmpNameNotLike(String value) {
            addCriterion("emp_name not like", value, "empName");
            return (Criteria) this;
        }

        public Criteria andEmpNameIn(List<String> values) {
            addCriterion("emp_name in", values, "empName");
            return (Criteria) this;
        }

        public Criteria andEmpNameNotIn(List<String> values) {
            addCriterion("emp_name not in", values, "empName");
            return (Criteria) this;
        }

        public Criteria andEmpNameBetween(String value1, String value2) {
            addCriterion("emp_name between", value1, value2, "empName");
            return (Criteria) this;
        }

        public Criteria andEmpNameNotBetween(String value1, String value2) {
            addCriterion("emp_name not between", value1, value2, "empName");
            return (Criteria) this;
        }

        public Criteria andGenderIsNull() {
            addCriterion("gender is null");
            return (Criteria) this;
        }

        public Criteria andGenderIsNotNull() {
            addCriterion("gender is not null");
            return (Criteria) this;
        }

        public Criteria andGenderEqualTo(String value) {
            addCriterion("gender =", value, "gender");
            return (Criteria) this;
        }

        public Criteria andGenderNotEqualTo(String value) {
            addCriterion("gender <>", value, "gender");
            return (Criteria) this;
        }

        public Criteria andGenderGreaterThan(String value) {
            addCriterion("gender >", value, "gender");
            return (Criteria) this;
        }

        public Criteria andGenderGreaterThanOrEqualTo(String value) {
            addCriterion("gender >=", value, "gender");
            return (Criteria) this;
        }

        public Criteria andGenderLessThan(String value) {
            addCriterion("gender <", value, "gender");
            return (Criteria) this;
        }

        public Criteria andGenderLessThanOrEqualTo(String value) {
            addCriterion("gender <=", value, "gender");
            return (Criteria) this;
        }

        public Criteria andGenderLike(String value) {
            addCriterion("gender like", value, "gender");
            return (Criteria) this;
        }

        public Criteria andGenderNotLike(String value) {
            addCriterion("gender not like", value, "gender");
            return (Criteria) this;
        }

        public Criteria andGenderIn(List<String> values) {
            addCriterion("gender in", values, "gender");
            return (Criteria) this;
        }

        public Criteria andGenderNotIn(List<String> values) {
            addCriterion("gender not in", values, "gender");
            return (Criteria) this;
        }

        public Criteria andGenderBetween(String value1, String value2) {
            addCriterion("gender between", value1, value2, "gender");
            return (Criteria) this;
        }

        public Criteria andGenderNotBetween(String value1, String value2) {
            addCriterion("gender not between", value1, value2, "gender");
            return (Criteria) this;
        }

        public Criteria andEmailIsNull() {
            addCriterion("email is null");
            return (Criteria) this;
        }

        public Criteria andEmailIsNotNull() {
            addCriterion("email is not null");
            return (Criteria) this;
        }

        public Criteria andEmailEqualTo(String value) {
            addCriterion("email =", value, "email");
            return (Criteria) this;
        }

        public Criteria andEmailNotEqualTo(String value) {
            addCriterion("email <>", value, "email");
            return (Criteria) this;
        }

        public Criteria andEmailGreaterThan(String value) {
            addCriterion("email >", value, "email");
            return (Criteria) this;
        }

        public Criteria andEmailGreaterThanOrEqualTo(String value) {
            addCriterion("email >=", value, "email");
            return (Criteria) this;
        }

        public Criteria andEmailLessThan(String value) {
            addCriterion("email <", value, "email");
            return (Criteria) this;
        }

        public Criteria andEmailLessThanOrEqualTo(String value) {
            addCriterion("email <=", value, "email");
            return (Criteria) this;
        }

        public Criteria andEmailLike(String value) {
            addCriterion("email like", value, "email");
            return (Criteria) this;
        }

        public Criteria andEmailNotLike(String value) {
            addCriterion("email not like", value, "email");
            return (Criteria) this;
        }

        public Criteria andEmailIn(List<String> values) {
            addCriterion("email in", values, "email");
            return (Criteria) this;
        }

        public Criteria andEmailNotIn(List<String> values) {
            addCriterion("email not in", values, "email");
            return (Criteria) this;
        }

        public Criteria andEmailBetween(String value1, String value2) {
            addCriterion("email between", value1, value2, "email");
            return (Criteria) this;
        }

        public Criteria andEmailNotBetween(String value1, String value2) {
            addCriterion("email not between", value1, value2, "email");
            return (Criteria) this;
        }

        public Criteria andDIdIsNull() {
            addCriterion("d_id is null");
            return (Criteria) this;
        }

        public Criteria andDIdIsNotNull() {
            addCriterion("d_id is not null");
            return (Criteria) this;
        }

        public Criteria andDIdEqualTo(Integer value) {
            addCriterion("d_id =", value, "dId");
            return (Criteria) this;
        }

        public Criteria andDIdNotEqualTo(Integer value) {
            addCriterion("d_id <>", value, "dId");
            return (Criteria) this;
        }

        public Criteria andDIdGreaterThan(Integer value) {
            addCriterion("d_id >", value, "dId");
            return (Criteria) this;
        }

        public Criteria andDIdGreaterThanOrEqualTo(Integer value) {
            addCriterion("d_id >=", value, "dId");
            return (Criteria) this;
        }

        public Criteria andDIdLessThan(Integer value) {
            addCriterion("d_id <", value, "dId");
            return (Criteria) this;
        }

        public Criteria andDIdLessThanOrEqualTo(Integer value) {
            addCriterion("d_id <=", value, "dId");
            return (Criteria) this;
        }

        public Criteria andDIdIn(List<Integer> values) {
            addCriterion("d_id in", values, "dId");
            return (Criteria) this;
        }

        public Criteria andDIdNotIn(List<Integer> values) {
            addCriterion("d_id not in", values, "dId");
            return (Criteria) this;
        }

        public Criteria andDIdBetween(Integer value1, Integer value2) {
            addCriterion("d_id between", value1, value2, "dId");
            return (Criteria) this;
        }

        public Criteria andDIdNotBetween(Integer value1, Integer value2) {
            addCriterion("d_id not between", value1, value2, "dId");
            return (Criteria) this;
        }
    }

    public static class Criteria extends GeneratedCriteria {

        protected Criteria() {
            super();
        }
    }

    public static class Criterion {
        private String condition;

        private Object value;

        private Object secondValue;

        private boolean noValue;

        private boolean singleValue;

        private boolean betweenValue;

        private boolean listValue;

        private String typeHandler;

        public String getCondition() {
            return condition;
        }

        public Object getValue() {
            return value;
        }

        public Object getSecondValue() {
            return secondValue;
        }

        public boolean isNoValue() {
            return noValue;
        }

        public boolean isSingleValue() {
            return singleValue;
        }

        public boolean isBetweenValue() {
            return betweenValue;
        }

        public boolean isListValue() {
            return listValue;
        }

        public String getTypeHandler() {
            return typeHandler;
        }

        protected Criterion(String condition) {
            super();
            this.condition = condition;
            this.typeHandler = null;
            this.noValue = true;
        }

        protected Criterion(String condition, Object value, String typeHandler) {
            super();
            this.condition = condition;
            this.value = value;
            this.typeHandler = typeHandler;
            if (value instanceof List<?>) {
                this.listValue = true;
            } else {
                this.singleValue = true;
            }
        }

        protected Criterion(String condition, Object value) {
            this(condition, value, null);
        }

        protected Criterion(String condition, Object value, Object secondValue, String typeHandler) {
            super();
            this.condition = condition;
            this.value = value;
            this.secondValue = secondValue;
            this.typeHandler = typeHandler;
            this.betweenValue = true;
        }

        protected Criterion(String condition, Object value, Object secondValue) {
            this(condition, value, secondValue, null);
        }
    }
}
```



















## Controller

### EmployeeController

```java
package com.spring.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.spring.pojo.Employer;
import com.spring.pojo.Message;
import com.spring.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/employee")
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    /**
     * 查询员工数据（分页查询）
     *
     * @return
     */
    /*
    @RequestMapping("/getEmps")
    public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model){

        //引用PageHelper分页插件
        //在查询之前，调用startPage方法，传入页码和每页的数据行数
        PageHelper.startPage(pn, 5);
        //startPage方法后面的方法就是分页查询
        List<Employer> employers = employeeService.getAll();
        //使用PageInfo包装查询后的信息
        //PageInfo中封装了详细的分页信息，包括查询出的数据
        //5 :表示连续现实的页数
        PageInfo pageInfo = new PageInfo(employers, 5);
        model.addAttribute("pageInfo", pageInfo);
        return "list";
    }
    */
    @ResponseBody
    @RequestMapping("/getEmps")
    public Message getEmpsWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        //引用PageHelper分页插件
        //在查询之前，调用startPage方法，传入页码和每页的数据行数
        PageHelper.startPage(pn, 400);
        //startPage方法后面的方法就是分页查询
        List<Employer> employers = employeeService.getAll();
        //使用PageInfo包装查询后的信息
        //PageInfo中封装了详细的分页信息，包括查询出的数据
        //5 :表示连续现实的页数
        PageInfo pageInfo = new PageInfo(employers, 5);
        return Message.success().add("pageInfo", pageInfo);
    }


    /**
     * 新增员工信息
     *
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/insertEmp", method = RequestMethod.POST)
    public Message insertEmp(@Valid Employer employer, BindingResult result) {
        if (result.hasErrors()){
            // 校验失败，返回失败信息
            //封装验证信息
            Map<String, Object> map = new HashMap<>();
            //提取校验失败的所有信息
            List<FieldError> fieldErrors = result.getFieldErrors();
            //遍历错误信息
            for (FieldError fieldError: fieldErrors) {
                System.out.println("错误的字段名：" + fieldError.getField());
                System.out.println("错误信息:"+ fieldError.getDefaultMessage());
                map.put(fieldError.getField(), fieldError.getDefaultMessage());
            }
            return Message.fail().add("errorField", map);
        }else {
            employeeService.insertEmp(employer);
            return Message.success();
        }
    }

    /**
     * 检查用户名是否可用
     * 使用JSR303校验
     * 1、导入Hibernate-Validator包
     *
     *
     * @param empName
     * @return
     */
    @ResponseBody
    @RequestMapping("/checkUserName")
    public Message ckeckUserName(String empName) {
        //先判断用户名是否符合规则
        String regex = "(^[a-zA-Z 0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        if (!empName.matches(regex)) {
            return Message.fail().add("validate_info", "用户名可以是2-5为中文或者6-16为英文和数字的组合。");
        }

        //如果用户名符合规则，再在数据库中查询是否重复
        Boolean bool = employeeService.checkUserName(empName);
        if (bool) {
            return Message.success();
        } else {
            return Message.fail().add("validate_info", "用户名不可用");
        }
    }

    /**
     * 根据ID查询员工信息
     * @param empId
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/getEmp/{empId}", method = RequestMethod.GET)
    public Message getEmp(@PathVariable("empId") Integer empId){
        Employer employer = employeeService.getEmp(empId);
        return Message.success().add("employer", employer);
    }

    /**
     * 更新员工信息
     * @param employer
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/updateEmp/{empId}", method = RequestMethod.POST)
    public Message updateEmp(Employer employer){
        employeeService.updateEmp(employer);
        return Message.success();
    }


    /**
     * 删除单个员工数据
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/deleteEmp/{empIds}", method = RequestMethod.DELETE)
    public Message deleteEmp(@PathVariable("empIds") String empIds){
        //批量删除
        if (empIds.contains("-")){
            String[] split = empIds.split("-");
            List<Integer> idList = new ArrayList<>();
            for(String empId : split){
                idList.add(Integer.parseInt(empId));
                employeeService.deleteEmpBatch(idList);
            }
        }else {
            //单个删除
            Integer empId = Integer.parseInt(empIds);
            employeeService.deleteEmp(empId);
        }
        return Message.success();
    }


}
```

### DepartmentController

```java
package com.spring.controller;


import com.spring.pojo.Department;
import com.spring.pojo.Message;
import com.spring.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * 出力和部门有关的请求
 */
@Controller
@RequestMapping("/dept")
public class DepartmentController {

    @Autowired
    DepartmentService departmentService;

    /**
     * 查询所有的部门信息
     * @return 返回查询到的部门信息
     */
    @ResponseBody
    @RequestMapping("/getDepts")
    public Message getDepts(){
        List<Department> departments = departmentService.getDepts();
        return Message.success().add("depts", departments);
    }
}
```

## Service

###　DepartmentService

```java
package com.spring.service;

import com.spring.mapper.DepartmentMapper;
import com.spring.pojo.Department;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepartmentService {

    @Autowired
    DepartmentMapper departmentMapper;

    public List<Department> getDepts() {

        List<Department> departments = departmentMapper.selectByExample(null);
        return departments;
    }
}
```

### EmployeeService

```java
package com.spring.service;

import com.spring.mapper.EmployerMapper;
import com.spring.pojo.Employer;
import com.spring.pojo.EmployerExample;
import com.spring.pojo.EmployerExample.Criteria;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeService {

    @Autowired
    EmployerMapper employerMapper;


    public List<Employer> getAll() {
        return employerMapper.selectByExampleWithDept(null);

    }

    public void insertEmp(Employer employer) {
        employerMapper.insertSelective(employer);
    }

    /**
     * 检验用户名是否可用
     * 如果返回的count数为0，表示数据库中没有该名字，该用户名可以使用，否则不可用
     * @param empName 新增用户姓名
     * @return
     */
    public Boolean checkUserName(String empName) {
        EmployerExample example = new EmployerExample();
        Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(empName);

        long count = employerMapper.countByExample(example);
        return count == 0;
    }

    public Employer getEmp(Integer empId) {

        return employerMapper.selectByPrimaryKey(empId);
    }

    /**
     * 更新员工信息
     * @param employer
     */
    public void updateEmp(Employer employer) {
        employerMapper.updateByPrimaryKeySelective(employer);
    }

    /**
     * 删除单个员工信息
     * @param empId
     */
    public void deleteEmp(Integer empId) {
        employerMapper.deleteByPrimaryKey(empId);
    }

    /**
     * 根据ID批量删除
     * @param idList
     */
    public void deleteEmpBatch(List<Integer> idList) {
        EmployerExample example = new EmployerExample();
        Criteria criteria = example.createCriteria();
        criteria.andEmpIdIn(idList);
        employerMapper.deleteByExample(example);

    }
}
```

##  Mapper接口文件

### DepartmentMapper

```java
package com.spring.mapper;

import com.spring.pojo.Department;
import com.spring.pojo.DepartmentExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface DepartmentMapper {
    long countByExample(DepartmentExample example);

    int deleteByExample(DepartmentExample example);

    int deleteByPrimaryKey(Integer deptId);

    int insert(Department record);

    int insertSelective(Department record);

    List<Department> selectByExample(DepartmentExample example);

    Department selectByPrimaryKey(Integer deptId);

    int updateByExampleSelective(@Param("record") Department record, @Param("example") DepartmentExample example);

    int updateByExample(@Param("record") Department record, @Param("example") DepartmentExample example);

    int updateByPrimaryKeySelective(Department record);

    int updateByPrimaryKey(Department record);
}
```

### EmployerMapper

```java
package com.spring.mapper;

import com.spring.pojo.Employer;
import com.spring.pojo.EmployerExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface EmployerMapper {
    long countByExample(EmployerExample example);

    int deleteByExample(EmployerExample example);

    int deleteByPrimaryKey(Integer empId);

    int insert(Employer record);

    int insertSelective(Employer record);

    List<Employer> selectByExample(EmployerExample example);

    Employer selectByPrimaryKey(Integer empId);

    List<Employer> selectByExampleWithDept(EmployerExample example);

    Employer selectByPrimaryKeyWithDept(Integer empId);

    int updateByExampleSelective(@Param("record") Employer record, @Param("example") EmployerExample example);

    int updateByExample(@Param("record") Employer record, @Param("example") EmployerExample example);

    int updateByPrimaryKeySelective(Employer record);

    int updateByPrimaryKey(Employer record);
}
```

## Mapper映射文件

### DepartmentMapper

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="com.spring.mapper.DepartmentMapper">
  <resultMap id="BaseResultMap" type="com.spring.pojo.Department">
    <id column="dept_id" jdbcType="INTEGER" property="deptId" />
    <result column="dept_name" jdbcType="VARCHAR" property="deptName" />
  </resultMap>
  <sql id="Example_Where_Clause">
    <where>
      <foreach collection="oredCriteria" item="criteria" separator="or">
        <if test="criteria.valid">
          <trim prefix="(" prefixOverrides="and" suffix=")">
            <foreach collection="criteria.criteria" item="criterion">
              <choose>
                <when test="criterion.noValue">
                  and ${criterion.condition}
                </when>
                <when test="criterion.singleValue">
                  and ${criterion.condition} #{criterion.value}
                </when>
                <when test="criterion.betweenValue">
                  and ${criterion.condition} #{criterion.value} and #{criterion.secondValue}
                </when>
                <when test="criterion.listValue">
                  and ${criterion.condition}
                  <foreach close=")" collection="criterion.value" item="listItem" open="(" separator=",">
                    #{listItem}
                  </foreach>
                </when>
              </choose>
            </foreach>
          </trim>
        </if>
      </foreach>
    </where>
  </sql>
  <sql id="Update_By_Example_Where_Clause">
    <where>
      <foreach collection="example.oredCriteria" item="criteria" separator="or">
        <if test="criteria.valid">
          <trim prefix="(" prefixOverrides="and" suffix=")">
            <foreach collection="criteria.criteria" item="criterion">
              <choose>
                <when test="criterion.noValue">
                  and ${criterion.condition}
                </when>
                <when test="criterion.singleValue">
                  and ${criterion.condition} #{criterion.value}
                </when>
                <when test="criterion.betweenValue">
                  and ${criterion.condition} #{criterion.value} and #{criterion.secondValue}
                </when>
                <when test="criterion.listValue">
                  and ${criterion.condition}
                  <foreach close=")" collection="criterion.value" item="listItem" open="(" separator=",">
                    #{listItem}
                  </foreach>
                </when>
              </choose>
            </foreach>
          </trim>
        </if>
      </foreach>
    </where>
  </sql>
  <sql id="Base_Column_List">
    dept_id, dept_name
  </sql>
  <select id="selectByExample" parameterType="com.spring.pojo.DepartmentExample" resultMap="BaseResultMap">
    select
    <if test="distinct">
      distinct
    </if>
    <include refid="Base_Column_List" />
    from table_dept
    <if test="_parameter != null">
      <include refid="Example_Where_Clause" />
    </if>
    <if test="orderByClause != null">
      order by ${orderByClause}
    </if>
  </select>
  <select id="selectByPrimaryKey" parameterType="java.lang.Integer" resultMap="BaseResultMap">
    select 
    <include refid="Base_Column_List" />
    from table_dept
    where dept_id = #{deptId,jdbcType=INTEGER}
  </select>
  <delete id="deleteByPrimaryKey" parameterType="java.lang.Integer">
    delete from table_dept
    where dept_id = #{deptId,jdbcType=INTEGER}
  </delete>
  <delete id="deleteByExample" parameterType="com.spring.pojo.DepartmentExample">
    delete from table_dept
    <if test="_parameter != null">
      <include refid="Example_Where_Clause" />
    </if>
  </delete>
  <insert id="insert" parameterType="com.spring.pojo.Department">
    insert into table_dept (dept_id, dept_name)
    values (#{deptId,jdbcType=INTEGER}, #{deptName,jdbcType=VARCHAR})
  </insert>
  <insert id="insertSelective" parameterType="com.spring.pojo.Department">
    insert into table_dept
    <trim prefix="(" suffix=")" suffixOverrides=",">
      <if test="deptId != null">
        dept_id,
      </if>
      <if test="deptName != null">
        dept_name,
      </if>
    </trim>
    <trim prefix="values (" suffix=")" suffixOverrides=",">
      <if test="deptId != null">
        #{deptId,jdbcType=INTEGER},
      </if>
      <if test="deptName != null">
        #{deptName,jdbcType=VARCHAR},
      </if>
    </trim>
  </insert>
  <select id="countByExample" parameterType="com.spring.pojo.DepartmentExample" resultType="java.lang.Long">
    select count(*) from table_dept
    <if test="_parameter != null">
      <include refid="Example_Where_Clause" />
    </if>
  </select>
  <update id="updateByExampleSelective" parameterType="map">
    update table_dept
    <set>
      <if test="record.deptId != null">
        dept_id = #{record.deptId,jdbcType=INTEGER},
      </if>
      <if test="record.deptName != null">
        dept_name = #{record.deptName,jdbcType=VARCHAR},
      </if>
    </set>
    <if test="_parameter != null">
      <include refid="Update_By_Example_Where_Clause" />
    </if>
  </update>
  <update id="updateByExample" parameterType="map">
    update table_dept
    set dept_id = #{record.deptId,jdbcType=INTEGER},
      dept_name = #{record.deptName,jdbcType=VARCHAR}
    <if test="_parameter != null">
      <include refid="Update_By_Example_Where_Clause" />
    </if>
  </update>
  <update id="updateByPrimaryKeySelective" parameterType="com.spring.pojo.Department">
    update table_dept
    <set>
      <if test="deptName != null">
        dept_name = #{deptName,jdbcType=VARCHAR},
      </if>
    </set>
    where dept_id = #{deptId,jdbcType=INTEGER}
  </update>
  <update id="updateByPrimaryKey" parameterType="com.spring.pojo.Department">
    update table_dept
    set dept_name = #{deptName,jdbcType=VARCHAR}
    where dept_id = #{deptId,jdbcType=INTEGER}
  </update>
</mapper>
```

### EmployerMapper

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="com.spring.mapper.EmployerMapper">
  <resultMap id="BaseResultMap" type="com.spring.pojo.Employer">
    <id column="emp_id" jdbcType="INTEGER" property="empId" />
    <result column="emp_name" jdbcType="VARCHAR" property="empName" />
    <result column="gender" jdbcType="CHAR" property="gender" />
    <result column="email" jdbcType="VARCHAR" property="email" />
    <result column="d_id" jdbcType="INTEGER" property="dId" />
  </resultMap>

  <resultMap id="BaseWithDeptResultMap" type="com.spring.pojo.Employer">
    <id column="emp_id" jdbcType="INTEGER" property="empId" />
    <result column="emp_name" jdbcType="VARCHAR" property="empName" />
    <result column="gender" jdbcType="CHAR" property="gender" />
    <result column="email" jdbcType="VARCHAR" property="email" />
    <result column="d_id" jdbcType="INTEGER" property="dId" />
    <association property="department" javaType="com.spring.pojo.Department">
      <id column="dept_id" property="deptId"/>
      <id column="dept_name" property="deptName"/>
    </association>
  </resultMap>

  <sql id="Example_Where_Clause">
    <where>
      <foreach collection="oredCriteria" item="criteria" separator="or">
        <if test="criteria.valid">
          <trim prefix="(" prefixOverrides="and" suffix=")">
            <foreach collection="criteria.criteria" item="criterion">
              <choose>
                <when test="criterion.noValue">
                  and ${criterion.condition}
                </when>
                <when test="criterion.singleValue">
                  and ${criterion.condition} #{criterion.value}
                </when>
                <when test="criterion.betweenValue">
                  and ${criterion.condition} #{criterion.value} and #{criterion.secondValue}
                </when>
                <when test="criterion.listValue">
                  and ${criterion.condition}
                  <foreach close=")" collection="criterion.value" item="listItem" open="(" separator=",">
                    #{listItem}
                  </foreach>
                </when>
              </choose>
            </foreach>
          </trim>
        </if>
      </foreach>
    </where>
  </sql>
  <sql id="Update_By_Example_Where_Clause">
    <where>
      <foreach collection="example.oredCriteria" item="criteria" separator="or">
        <if test="criteria.valid">
          <trim prefix="(" prefixOverrides="and" suffix=")">
            <foreach collection="criteria.criteria" item="criterion">
              <choose>
                <when test="criterion.noValue">
                  and ${criterion.condition}
                </when>
                <when test="criterion.singleValue">
                  and ${criterion.condition} #{criterion.value}
                </when>
                <when test="criterion.betweenValue">
                  and ${criterion.condition} #{criterion.value} and #{criterion.secondValue}
                </when>
                <when test="criterion.listValue">
                  and ${criterion.condition}
                  <foreach close=")" collection="criterion.value" item="listItem" open="(" separator=",">
                    #{listItem}
                  </foreach>
                </when>
              </choose>
            </foreach>
          </trim>
        </if>
      </foreach>
    </where>
  </sql>
  <sql id="Base_Column_List">
    emp_id, emp_name, gender, email, d_id
  </sql>
  <sql id="Base_Column_WithDept_List">
    emp_id, emp_name, gender, email, d_id,dept_id, dept_name
  </sql>

  <select id="countByExample" parameterType="com.spring.pojo.EmployerExample" resultType="java.lang.Long">
    select count(*) from table_emp
    <if test="_parameter != null">
      <include refid="Example_Where_Clause" />
    </if>
  </select>
  <select id="selectByExample" parameterType="com.spring.pojo.EmployerExample" resultMap="BaseResultMap">
    select
    <if test="distinct">
      distinct
    </if>
    <include refid="Base_Column_List" />
    from table_emp
    <if test="_parameter != null">
      <include refid="Example_Where_Clause" />
    </if>
    <if test="orderByClause != null">
      order by ${orderByClause}
    </if>
  </select>
  <select id="selectByPrimaryKey" parameterType="java.lang.Integer" resultMap="BaseResultMap">
    select 
    <include refid="Base_Column_List" />
    from table_emp
    where emp_id = #{empId,jdbcType=INTEGER}
  </select>


  <select id="selectByExampleWithDept" resultMap="BaseWithDeptResultMap">
    select
    <if test="distinct">
      distinct
    </if>
    <include refid="Base_Column_WithDept_List" />
    from table_emp,table_dept
    <where>
      d_id = dept_id
    </where>
    <if test="_parameter != null">
      <include refid="Example_Where_Clause" />
    </if>
    order by emp_id
  </select>
  <select id="selectByPrimaryKeyWithDept" resultMap="BaseWithDeptResultMap">
    select
    <include refid="Base_Column_WithDept_List" />
    from table_emp, table_dept
    <where>
      emp_id = #{empId,jdbcType=INTEGER} and d_id = dept_id
    </where>
  </select>


  <delete id="deleteByPrimaryKey" parameterType="java.lang.Integer">
    delete from table_emp
    where emp_id = #{empId,jdbcType=INTEGER}
  </delete>
  <delete id="deleteByExample" parameterType="com.spring.pojo.EmployerExample">
    delete from table_emp
    <if test="_parameter != null">
      <include refid="Example_Where_Clause" />
    </if>
  </delete>


  <insert id="insert" parameterType="com.spring.pojo.Employer">
    insert into table_emp (emp_id, emp_name, gender, 
      email, d_id)
    values (#{empId,jdbcType=INTEGER}, #{empName,jdbcType=VARCHAR}, #{gender,jdbcType=CHAR}, 
      #{email,jdbcType=VARCHAR}, #{dId,jdbcType=INTEGER})
  </insert>
  <insert id="insertSelective" parameterType="com.spring.pojo.Employer">
    insert into table_emp
    <trim prefix="(" suffix=")" suffixOverrides=",">
      <if test="empId != null">
        emp_id,
      </if>
      <if test="empName != null">
        emp_name,
      </if>
      <if test="gender != null">
        gender,
      </if>
      <if test="email != null">
        email,
      </if>
      <if test="dId != null">
        d_id,
      </if>
    </trim>
    <trim prefix="values (" suffix=")" suffixOverrides=",">
      <if test="empId != null">
        #{empId,jdbcType=INTEGER},
      </if>
      <if test="empName != null">
        #{empName,jdbcType=VARCHAR},
      </if>
      <if test="gender != null">
        #{gender,jdbcType=CHAR},
      </if>
      <if test="email != null">
        #{email,jdbcType=VARCHAR},
      </if>
      <if test="dId != null">
        #{dId,jdbcType=INTEGER},
      </if>
    </trim>
  </insert>



  <update id="updateByExampleSelective" parameterType="map">
    update table_emp
    <set>
      <if test="record.empId != null">
        emp_id = #{record.empId,jdbcType=INTEGER},
      </if>
      <if test="record.empName != null">
        emp_name = #{record.empName,jdbcType=VARCHAR},
      </if>
      <if test="record.gender != null">
        gender = #{record.gender,jdbcType=CHAR},
      </if>
      <if test="record.email != null">
        email = #{record.email,jdbcType=VARCHAR},
      </if>
      <if test="record.dId != null">
        d_id = #{record.dId,jdbcType=INTEGER},
      </if>
    </set>
    <if test="_parameter != null">
      <include refid="Update_By_Example_Where_Clause" />
    </if>
  </update>
  <update id="updateByExample" parameterType="map">
    update table_emp
    set emp_id = #{record.empId,jdbcType=INTEGER},
      emp_name = #{record.empName,jdbcType=VARCHAR},
      gender = #{record.gender,jdbcType=CHAR},
      email = #{record.email,jdbcType=VARCHAR},
      d_id = #{record.dId,jdbcType=INTEGER}
    <if test="_parameter != null">
      <include refid="Update_By_Example_Where_Clause" />
    </if>
  </update>
  <update id="updateByPrimaryKeySelective" parameterType="com.spring.pojo.Employer">
    update table_emp
    <set>
      <if test="empName != null">
        emp_name = #{empName,jdbcType=VARCHAR},
      </if>
      <if test="gender != null">
        gender = #{gender,jdbcType=CHAR},
      </if>
      <if test="email != null">
        email = #{email,jdbcType=VARCHAR},
      </if>
      <if test="dId != null">
        d_id = #{dId,jdbcType=INTEGER},
      </if>
    </set>
    where emp_id = #{empId,jdbcType=INTEGER}
  </update>
  <update id="updateByPrimaryKey" parameterType="com.spring.pojo.Employer">
    update table_emp
    set emp_name = #{empName,jdbcType=VARCHAR},
      gender = #{gender,jdbcType=CHAR},
      email = #{email,jdbcType=VARCHAR},
      d_id = #{dId,jdbcType=INTEGER}
    where emp_id = #{empId,jdbcType=INTEGER}
  </update>
</mapper>
```



## Util

### WebPathInitServlet

```java
package com.spring.utils;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;

@WebServlet(urlPatterns = {}, loadOnStartup = 2)
public class WebPathInitServlet extends HttpServlet {

    @Override
    public void init(ServletConfig config) throws ServletException {
        config.getServletContext().setAttribute("context", config.getServletContext().getContextPath());
        super.init(config);
    }
}
```



### Message

```java
package com.spring.utils;

import java.util.HashMap;
import java.util.Map;

/**
 * 通用的返回json数据的类
 */
public class Message {
    // 状态码
    private int code;

    //提示信息
    private String msg;

    //用户返回给浏览器的数据
    private Map<String, Object> extend = new HashMap<>();


    public static Message success(){
        Message result = new Message();
        result.setCode(100);
        result.setMsg("处理成功！");
        return result;
    }

    public static Message fail(){
        Message result = new Message();
        result.setCode(200);
        result.setMsg("处理失败！");
        return result;
    }

    public Message add(String key, Object value){
        this.getExtend().put(key, value);
        return this;
    }


    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getExtend() {
        return extend;
    }

    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }
    
}
```

## 前端

### index.xml

```jsp
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>员工列表</title>

    <script type="text/javascript" src="${context}/static/js/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="${context}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="${context}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css">
</head>
<body>

<!-- 添加员工的模态框 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">添加员工</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="emp_add_form">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">EmpName</label>
                        <div class="col-sm-6">
                            <input type="text" name="empName" class="form-control" id="empName_add_input"
                                   placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">Email</label>
                        <div class="col-sm-6">
                            <input type="text" name="email" class="form-control" id="email_add_input"
                                   placeholder="email">
                            <span class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">Gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">Dept</label>
                        <div class="col-sm-4">
                            <%--添加部门时，提交id即可--%>
                            <select class="form-control" name="dId" id="dept_add_select">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>

<%--修改员工信息的模态框--%>
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">修改信息</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="emp_update_form">
                    <div class="form-group">
                        <label for="empName_update_static" class="col-sm-2 control-label">EmpName</label>
                        <div class="col-sm-6">
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="email_update_input" class="col-sm-2 control-label">Email</label>
                        <div class="col-sm-6">
                            <input type="text" name="email" class="form-control" id="email_update_input"
                                   placeholder="email">
                            <span class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">Gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked">
                                男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">Dept</label>
                        <div class="col-sm-4">
                            <%--添加部门时，提交id即可--%>
                            <select class="form-control" name="dId" id="dept_update_select">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>


<%--搭建现实页面--%>
<div class="container">
    <%--标题--%>
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <%--按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-danger" id="delete_all">删除</button>
        </div>
    </div>
    <%--现实数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_all">
                    </th>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Gender</th>
                    <th>Email</th>
                    <th>DeptName</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>

    </div>
    <%--显示分页信息--%>
    <div class="row">
        <%--分页文字信息--%>
        <div class="col-md-6" id="page_info_area">
        </div>
        <%--分页条信息--%>
        <div class="col-md-6" id="page_nav_area"></div>
    </div>
</div>
<script type="text/javascript">
    //总记录数
    var totalRecord;
    //当前页码
    var currentNum;
    //1、页面加载完成后，发送ajax请求，提取数据
    $(function () {
        to_page(1);
    });

    function to_page(pn) {
        $.ajax({
            url: "${context}/employee/getEmps",
            data: "pn=" + pn,
            type: "GET",
            success: function (result) {
                //1、解析并显示员工数据
                build_emps_table(result);
                //2、解析并显示分页信息
                build_page_info(result);
                //3、显示分页条信息
                build_page_nav(result);

            }
        });
    }

    function build_emps_table(result) {

        $("#emps_table tbody").empty();

        var emps = result.extend.pageInfo.list;
        $.each(emps, function (index, item) {
            var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender == 'M' ? "男" : "女");
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);

            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn").append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
            //为editBtn添加一个属性，表示员工的ID
            editBtn.attr("edit-id", item.empId);
            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn").append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
            //为delBtn添加一个属性，表示员工的ID
            delBtn.attr("del-id", item.empId);
            var btnTd = $("<td></td>").append(editBtn).append("&nbsp;").append(delBtn);

            $("<tr></tr>").append(checkBoxTd).append(empIdTd).append(empNameTd).append(genderTd).append(emailTd).append(deptNameTd).append(btnTd).appendTo("#emps_table tbody");
        })
    }

    function build_page_info(result) {

        $("#page_info_area").empty();

        currentNum = result.extend.pageInfo.pageNum;
        totalRecord = result.extend.pageInfo.total;
        var pages = result.extend.pageInfo.pages;
        $("#page_info_area").append("当前第" + currentNum + "页，总共" + pages + "页，共" + totalRecord + "条记录")
    }

    function build_page_nav(result) {

        $("#page_nav_area").empty();

        var navEle = $("<nav></nav>");
        var ul = $("<ul></ul>").addClass("pagination");
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));


        //如果当前页没有上一页，则上一页按钮和首页按钮不能被点击
        if (result.extend.pageInfo.hasPreviousPage == false) {
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        } else {
            //为首页添加单击事件
            firstPageLi.click(function () {
                to_page(1);
            });

            //为上一页按钮添加单击事件
            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum - 1);
            });
        }

        //如果当前页没有下一页，则下一页按钮和末页按钮不能被点击
        if (result.extend.pageInfo.hasNextPage == false) {
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        } else {
            //为下一页按钮添加单击事件
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum + 1);
            });
            //为末页添加单击事件
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            });
        }

        //添加首页和上一页
        ul.append(firstPageLi).append(prePageLi);
        //遍历分页条上显示的数据
        $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item));

            if (result.extend.pageInfo.pageNum == item) {
                numLi.addClass("active");
            }

            numLi.click(function () {

                to_page(item);
            });

            //添加遍历页码
            ul.append(numLi);
        });
        //添加下一页和末页
        ul.append(nextPageLi).append(lastPageLi);
        navEle.append(ul);
        navEle.appendTo("#page_nav_area");
    }

    function resert_form(ele) {
        // 重置表单内容
        $(ele)[0].reset();
        // 重置表单样式
        $(ele).find("*").removeClass("has-error has-success");
        $(ele).find(".help-block").text("");

    }

    // 点击新增按钮，弹出模态框
    $("#emp_add_modal_btn").click(function () {
        //清除表单数据（表单重置）和表单样式
        // $("#empAddModal form")[0].reset();
        resert_form("#empAddModal form");
        //发送ajax请求，查询部门信息，显示在下拉列表中
        getDepts("#dept_add_select");
        $("#empAddModal").modal({
            backdrop: "static"
        })
    });

    //查询所有的部门信息，显示在下拉列表中
    function getDepts(ele) {
        //清空下拉列表
        $(ele).empty();
        $("#dept_add_select").empty();
        $.ajax({
            url: "${context}/dept/getDepts",
            type: "GET",
            success: function (result) {
                // console.log(result);
                // $("#dept_add_select")
                // 遍历部门信息
                $.each(result.extend.depts, function () {
                    var optionEle = $("<option></option>").append(this.deptName).attr("value", this.deptId);
                    optionEle.appendTo(ele);
                })

            }
        });
    }

    //校验表单数据
    // function validate_add_form() {
    //     //使用正则表达式校验用户名
    //     var empName = $("#empName_add_input").val();
    //     var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
    //     if (!regName.test(empName)) {
    //         // alert("用户名可以是2-5为中文或者6-16为英文和数字的组合。");
    //         show_validate_msg("#empName_add_input", "error", "用户名可以是2-5为中文或者6-16为英文和数字的组合。");
    //         return false;
    //     } else {
    //         show_validate_msg("#empName_add_input", "success", "用户名可用。");
    //
    //     }
    //
    //     return true;
    // }


    // $("#empName_add_input").change(function () {
    //     var empName = $("#empName_add_input").val();
    //     var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
    //     if (!regName.test(empName)) {
    //         // alert("用户名可以是2-5为中文或者6-16为英文和数字的组合。");
    //         show_validate_msg("#empName_add_input", "error", "用户名可以是2-5为中文或者6-16为英文和数字的组合。");
    //         $("#emp_save_btn").attr("ajax-validate", "error");
    //     } else {
    //         show_validate_msg("#empName_add_input", "success", "用户名可用。");
    //         $("#emp_save_btn").attr("ajax-validate", "success");
    //     }
    // });

    function checkEmpName(){
        $("#empName_add_input").change(function () {
            var empName = $("#empName_add_input").val();
            var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
            if (!regName.test(empName)) {
                // alert("用户名可以是2-5为中文或者6-16为英文和数字的组合。");
                show_validate_msg("#empName_add_input", "error", "用户名可以是2-5为中文或者6-16为英文和数字的组合。");
                $("#emp_save_btn").attr("ajax-validate", "error");
            } else {
                show_validate_msg("#empName_add_input", "success", "用户名可用。");
                $("#emp_save_btn").attr("ajax-validate", "success");
            }
        });
    }


    //验证邮箱格式是否正确
    $("#email_add_input").change(function () {
        //使用正则表达式校验邮箱
        var email = $("#email_add_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            // alert("邮箱格式不正确");
            show_validate_msg("#email_add_input", "error", "邮箱格式不正确。");
            $("#emp_save_btn").attr("ajax-validate", "error");
        } else {
            show_validate_msg("#email_add_input", "success", "邮箱可用。");
            $("#emp_save_btn").attr("ajax-validate", "success");
        }
    });

    //显示验证消息
    function show_validate_msg(ele, status, msg) {
        // 清除当前元素的校验状态
        $(ele).parent().removeClass("has-success has-error");

        if ("success" == status) {
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        } else if ("error" == status) {
            $(ele).parent().addClass("has-error");
            $(ele).next("span").html(msg);
        }
    }

    //校验用户名是否已经存在
    $("#empName_add_input").change(function () {
        //发送ajax请求校验用户名是否可用
        var empName = this.value;
        $.ajax({
            url: "${context}/employee/checkUserName",
            data: "empName=" + empName,
            type: "POST",
            success: function (result) {
                if (result.code == 100) {
                    show_validate_msg("#empName_add_input", "success", "用户名可用");
                    $("#emp_save_btn").attr("ajax-validate", "success");
                } else if (result.code == 200) {
                    show_validate_msg("#empName_add_input", "error", result.extend.validate_info);
                    $("#emp_save_btn").attr("ajax-validate", "error");
                }
            }
        })

    });

    //点击保存
    $("#emp_save_btn").click(function () {
        //1、模态框中填写的数据提交给服务器进行保存
        //对拟提交给服务器的数据进行校验
        // if (!validate_add_form()) {
        //     return false;
        // }

        checkEmpName();


        //验证用户名是否已经存在，如果存在，则保存按钮不可用
        if ($("#emp_save_btn").attr("ajax-validate") == "error") {
            return false;
        }

        //2、发送ajax请求保存员工信息

        // alert($("#empAddModal form").serialize());

        $.ajax({
            url: "${context}/employee/insertEmp",
            type: "POST",
            data: $("#empAddModal form").serialize(),
            success: function (result) {
                // alert(result.msg);
                if (result.code == 100) {
                    //处理成功后
                    //1、关闭模态框
                    $("#empAddModal").modal('hide');
                    //2、发送Ajax请求显示最后一页数据
                    to_page(totalRecord);
                } else {
                    //处理失败
                    //现实失败信息
                    // console.log(result);
                    if (undefined != result.extend.errorField.email) {
                        //显示邮箱错误信息
                        show_validate_msg("#email_add_input", "error", result.extend.errorField.email);
                    }

                    if (undefined != result.extend.errorField.empName) {
                        //显示用户名错误信息
                        show_validate_msg("#empName_add_input", "error", result.extend.errorField.empName);
                    }
                }
            }
        })

    });

    //给编辑按钮绑定事件
    $(document).on("click", ".edit_btn", function () {
        // alert("Edit");

        // 1、查询部门信息，并显示部门列表
        getDepts("#empUpdateModal select");
        // 2、查询员工信息
        getEmp($(this).attr("edit-id"));
        // 3、弹出模态框，把员工id传递给模态框的更新按钮
        $("#emp_update_btn").attr("edit-id", $(this).attr("edit-id"));
        $("#empUpdateModal").modal({
            backdrop: "static"
        })

    });

    //取得员工信息
    function getEmp(empId) {
        $.ajax({
            url: "${context}/employee/getEmp/" + empId,
            type: "GET",
            success: function (result) {
                // console.log(result);
                var empDate = result.extend.employer;
                //显示员工姓名
                $("#empName_update_static").text(empDate.empName);
                //显示员工邮箱
                $("#email_update_input").val(empDate.email);
                //显示性别
                $("#empUpdateModal input[name=gender]").val([empDate.gender]);
                //显示部门信息
                $("#empUpdateModal select").val([empDate.dId]);

            }
        })

    }
    //给更新保存按钮绑定事件
    $("#emp_update_btn").click(function () {
        //校验邮箱信息
        //使用正则表达式校验邮箱
        var email = $("#email_update_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            // alert("邮箱格式不正确");
            show_validate_msg("#email_update_input", "error", "邮箱格式不正确。");
            return false;
        } else {
            show_validate_msg("#email_update_input", "success", "");
        }

        //发送ajax请求
        $.ajax({
            url: "${context}/employee/updateEmp/" + $(this).attr("edit-id"),
            type: "POST",
            data: $("#empUpdateModal form").serialize(),
            success: function (result) {
                //1、关闭模态框
                $("#empUpdateModal").modal('hide');
                //2、回到当前页面
                to_page(currentNum);
            }
        });
    });

    //给单个删除按钮绑定单击事件
    $(document).on("click", ".delete_btn", function () {
        // 弹出确认删除对话框
        //取得需要删除的员工姓名
        var empName = $(this).parents("tr").find("td:eq(2)").text();
        var empId = $(this).attr("del-id");
        // alert($(this).parents("tr").find("td:eq(1)").text());
        if (confirm("确认删除" + empName)) {
            //确认删除，发送ajax请求
            $.ajax({
                url: "${context}/employee/deleteEmp/" + empId,
                type: "DELETE",
                success: function (result) {
                    // alert(result.msg);

                    //删除成功，回到当前页
                    to_page(currentNum);
                }
            })
        }


    });

    //全选与全不选
    $("#check_all").click(function () {
        //使用attr获取自定义的属性值
        //使用prop获取原始属性值,给属性设置值
        // alert($("#check_all").prop("checked"));

        $(".check_item").prop("checked", $("#check_all").prop("checked"));

    });

    //让全选与单选同步
    $(document).on("click", ".check_item", function () {
        var flag = $(".check_item:checked").length==$(".check_item").length;
        $("#check_all").prop("checked", flag);
    });

    //批量删除
    $("#delete_all").click(function () {
        var empNames = "";
        var del_idsStr = "";
            $.each($(".check_item:checked"), function () {
            empNames += $(this).parents("tr").find("td:eq(2)").text() + ",";
            del_idsStr += $(this).parents("tr").find("td:eq(1)").text() + "-";
            });
        //去除末尾的逗号
        empNames = empNames.substring(0, empNames.length-1);
        //去除末尾的短横线
        del_idsStr = del_idsStr.substring(0,del_idsStr.length-1);

        if (confirm("确认删除" + empNames)){
            $.ajax({
                url:"${context}/employee/deleteEmp/" + del_idsStr,
                type:"DELETE",
                success:function (result) {
                    // alert(result.msg);
                    to_page(currentNum);
                    $("#check_all").prop("checked", false);
                }
            });
        }
    });

</script>
</body>
</html>
```