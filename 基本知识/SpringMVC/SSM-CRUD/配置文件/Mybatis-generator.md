# Mybatis-generator

+ 引入数据库连接信息的资源文件
+ 指定数据库连接驱动的位置信息
+ 配置数据库连接信息
+ 指定javaBean生成的位置
+ 指定Mapper接口文件生成位置
+ 指定Mapper映射文件生成的位置
+ 指定每个表的生成策略（数据库中的表与pojo类一一对应）

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE generatorConfiguration
        PUBLIC "-//mybatis.org//DTD MyBatis Generator Configuration 1.0//EN"
        "http://mybatis.org/dtd/mybatis-generator-config_1_0.dtd">

<generatorConfiguration>
    <!--引入数据库资源文件-->
    <properties resource="jdbc.properties"></properties>
    <!--引入数据库连接驱动的位置信息-->
    <classPathEntry location="${classPath}"/>
    <context id="DB2Tables" targetRuntime="MyBatis3">
        <commentGenerator>
            <property name="suppressAllComments" value="true" />
        </commentGenerator>

        <!--配置数据库连接信息-->
        <jdbcConnection driverClass="${driverClass}"
                        connectionURL="${jdbcUrl}"
                        userId="${user}"
                        password="${password}">
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
        <table tableName="table_emp" domainObjectName="Employer"></table>
        <table tableName="table_dept" domainObjectName="Department"></table>
    </context>
</generatorConfiguration>
```