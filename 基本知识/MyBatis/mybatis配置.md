# MyBatis配置

## 采用资源文件配置数据库访问

1. 在resources路径下新建“jdbc.properties”资源文件，并添加代码

   ```properties
   url=jdbc:mysql://localhost:3306/mybatis
   driver=com.mysql.jdbc.Driver
   username=root
   password=root
   ```

2. 在resources下新建文件夹：“com/mybatis/***”，一定要写“/”

3. 修改mybatis.cfg.xml文件

   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <!DOCTYPE configuration PUBLIC "-//mybatis.org//DTD Config 3.0//EN" "http://mybatis.org/dtd/mybatis-3-config.dtd">
   <configuration>
   	<!--引入外部资源文件-->
       <properties resource="jdbc.properties"></properties>
   
       <!--配置数据库连接-->
       <environments default="development">
           <environment id="development">
               <transactionManager type="JDBC"></transactionManager>
               <dataSource type="POOLED">
                   <!--数据库连接属性-->
                   <property name="url" value="${url}"/>
                   <property name="driver" value="com.mysql.jdbc.Driver"/>
                   <property name="username" value="root"/>
                   <property name="password" value="root"/>
               </dataSource>
           </environment>
       </environments>
   
       <!--绑定mapper文件-->
       <mappers>
           <mapper resource="com/mybatis/mapper/GirlMapper.xml"></mapper>
       </mappers>
   </configuration>
   ```

## typeAliases 别名

不推荐使用

```xml
<typeAliases>
    <!--注册一个简写的类名-->
    <typeAlias type="com.mybatis.pojo.Girl" alias="girl"/>
</typeAliases>
```

## 下划线转变为驼峰命名

```xml
<settings>
    <!--开启下划线转变为驼峰命名-->
    <!--数据库采用下划线命名-->
    <!--JavaBean采用驼峰命名-->
    <setting name="mapUnderscoreToCamelCase" value="true" />
</settings>
```

## mapper的几种写法

```xml
<!--绑定mapper文件-->
<mappers>
    <!--第一种，直接引入xml文件-->
    <mapper resource="com/mybatis/mapper/GirlMapper.xml"></mapper>
    <!--第二种，通过URL协议-->
    <mapper url="file:///E:/workspace/idea/MyBatis/demo2/src/main/resources/com/mybatis/mapper/GirlMapper.xml"></mapper>
    <!--第三种，通过类路径方式引入mapper接口，必须保证接口与mapper.xml文件在同包之下-->
    <mapper class="com.mybatis.mapper.GirlMapper"></mapper>
    <!--第四种，引入一个包，在该包下的mapper文件都可以引入-->
    <package name="com.mybatis.mapper"></package>
</mappers>
```

