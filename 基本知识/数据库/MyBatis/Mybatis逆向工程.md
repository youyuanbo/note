# Mybatis逆向工程

## 修改pom.xml文件

+ 添加依赖

  ```xml
  <!-- https://mvnrepository.com/artifact/org.mybatis.generator/mybatis-generator-maven-plugin -->
  <dependency>
      <groupId>org.mybatis.generator</groupId>
      <artifactId>mybatis-generator-maven-plugin</artifactId>
      <version>1.3.7</version>
  </dependency>
  ```

+ 添加插件（在“project-->build-->pluginManagement-->plugins”节点下添加）

  ```xml
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
  ```

## 在resources下新建mybatis-generator.xml文件

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE generatorConfiguration
        PUBLIC "-//mybatis.org//DTD MyBatis Generator Configuration 1.0//EN"
        "http://mybatis.org/dtd/mybatis-generator-config_1_0.dtd">

<generatorConfiguration>
    <!--配置数据库驱动位置-->
    <classPathEntry location="E:\\development_jar\\mysql-connector-java-5.1.47.jar"/>
    <context id="DB2Tables" targetRuntime="MyBatis3">
        <!--配置数据库连接信息-->
        <jdbcConnection driverClass="com.mysql.jdbc.Driver"
                        connectionURL="jdbc:mysql://localhost:3306/ssm?useSSL=false"
                        userId="root"
                        password="root">
        </jdbcConnection>


        <javaTypeResolver>
            <property name="forceBigDecimals" value="false"/>
        </javaTypeResolver>

        <!--指定javaBean生成的位置-->
        <javaModelGenerator targetPackage="com.spring.pojo" targetProject="src/main/java">
            <property name="enableSubPackages" value="false"/>
            <property name="trimStrings" value="false"/>
        </javaModelGenerator>

        <!--指定sql接口文件生成的位置-->
        <sqlMapGenerator targetPackage="com.spring.mapper" targetProject="src/main/java">
            <property name="enableSubPackages" value="false"/>
        </sqlMapGenerator>

        <!--指定Mapper映射文件生成位置-->
        <javaClientGenerator type="XMLMAPPER" targetPackage="com.spring.mapper" targetProject="src/main/java">
            <property name="enableSubPackages" value="false"/>
        </javaClientGenerator>

        <!--table指定每个表的生成策略-->
        <table tableName="table_emp" domainObjectName="TableEmp"></table>
        <table tableName="table_dept" domainObjectName="TableDept"></table>

    </context>
</generatorConfiguration>
```

## 新建generator运行器

+ 点击“Edit Configuration”

  ![1551526997023](E:\笔记\MyBatis\img\%5CUsers%5CCentos%5CAppData%5CRoaming%5CTypora%5Ctypora-user-images%5C1551526997023.png)

+ 点击“+”

  ![1551527102303](E:\笔记\MyBatis\img\%5CUsers%5CCentos%5CAppData%5CRoaming%5CTypora%5Ctypora-user-images%5C1551527102303.png)

+ 选择Maven

  ![1551527149504](E:\笔记\MyBatis\img\%5CUsers%5CCentos%5CAppData%5CRoaming%5CTypora%5Ctypora-user-images%5C1551527149504.png)

+ 编辑相关信息

  ![1551527241901](E:\笔记\MyBatis\img\%5CUsers%5CCentos%5CAppData%5CRoaming%5CTypora%5Ctypora-user-images%5C1551527241901.png)

  给该运行器取名

  选择相关的项目

  编辑命令：mybatis-generator:generate -e

+ 选择generator

  ![1551527346827](E:\笔记\MyBatis\img\%5CUsers%5CCentos%5CAppData%5CRoaming%5CTypora%5Ctypora-user-images%5C1551527346827.png)

+ 点击运行

  ![1551527382843](E:\笔记\MyBatis\img\%5CUsers%5CCentos%5CAppData%5CRoaming%5CTypora%5Ctypora-user-images%5C1551527382843.png)

+ 完成

  ![1551527449506](E:\笔记\MyBatis\img\%5CUsers%5CCentos%5CAppData%5CRoaming%5CTypora%5Ctypora-user-images%5C1551527449506.png)

