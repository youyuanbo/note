[TOC]





# Mybatis配置与参数

## Mybatis配置

1. 添加mysql依赖

   ```xml
   <!-- https://mvnrepository.com/artifact/mysql/mysql-connector-java -->
       <dependency>
         <groupId>mysql</groupId>
         <artifactId>mysql-connector-java</artifactId>
         <version>5.1.47</version>
       </dependency>
   ```

2. 添加MyBatis依赖

   ```xml
   <!-- https://mvnrepository.com/artifact/org.mybatis/mybatis -->
         <dependency>
             <groupId>org.mybatis</groupId>
             <artifactId>mybatis</artifactId>
             <version>3.4.4</version>
         </dependency>
   ```

3. 在mybatis.cfg.xml配置文件中配置MySQL属性

   ```xml
   <!--在mybatis.cfg.xml中编写相应的配置-->
   <environments default="dev">
       <environment id="dev">
           <transactionManager type="JDBC"></transactionManager>
           <dataSource type="UNPOOLED">
               <property name="url" value="${url}"/>
               <property name="driver" value="${driver}"/>
               <property name="username" value="${username}"/>
               <property name="password" value="${password}"/>
           </dataSource>
       </environment>
   </environments>
   ```


```xml

```



4. 配置资源文件(jdbc.properties)

   ```xml
   url=jdbc:mysql://localhost:3306/mybatis
   driver=com.mysql.jdbc.Driver
   username=root
   password=root
   ```

   ```xml
   <!--在mybatis.cfg.xml中编写相应的配置-->
   <environments default="dev">
       <environment id="dev">
           <transactionManager type="JDBC"></transactionManager>
           <dataSource type="UNPOOLED">
               <property name="url" value="${url}"/>
               <property name="driver" value="${driver}"/>
               <property name="username" value="${username}"/>
               <property name="password" value="${password}"/>
           </dataSource>
       </environment>
   </environments>
   ```

5. 格转换为驼峰命名风格

   ```xml
   <settings>
       <!-- 
               开启下划线风格转变为驼峰命名风格
               数据库设计采用下划线命名风格
               JavaBean采用驼峰命名风格
               解决不匹配问题
           -->
       <setting name="mapUnderscoreToCamelCase" value="true"/>
   </settings>
   ```

6. 引入mapper.xml文件的方式

   ```xml
   <mappers>
       通过类路劲方式引入XML文件
       <mapper resource="com/mybatis/mapper/GirlMapper.xml"/>
       通过接口的权限定名引入，接口与xml文件必须在同包之下
       <mapper class="com.mybatis.mapper.GirlMapper"/>
       引入包的方式
       <package name="com.mybatis.mapper"/>
   </mappers>
   ```


## MyBatis参数

1. 单个基本参数类型

   如果仅仅是简单的一个单值传入，那么#{}表达式里面随便传入什么都可以。因为只有一个参数，MyBatis没有入参绑定的问题。但是为了规范，应当写入相应的参数名称。

2. 单个JavaBean

   默认通过JavaBean中的属性的名称去引用，通过getter方法去找这些属性

3. 单个或多个非基本数据类型

   例如：java.lang.String

   单个：与基本数据类型一致

   多个：

   ```xml
   select * from girl where name=#{param1} and flower=#{param2}; 
   select * from girl where name=#{arg0} and flower=#{arg1};
   
   ```

   推荐使用

   ```java
   public Girl queryByNameAndFlower(@Param("name") String name, @Param("flower") String flower);
   ```

   ```xml
   select * from girl where name = #{name} and flower = #{flower};
   ```

4. map

   ```java
   Map<String, Object> map = new HashMap<>();
   map.put("name","小梁");
   map.put("flower","玫瑰");
   Girl girl1 = mapper.queryByMap(map);
   ```

   ```xml
   <select id="queryByMap" resultType="com.mybatis.pojo.Girl">
       select * from girl where name = #{name} and flower = #{flower};
   </select>
   ```


6. javaBean







