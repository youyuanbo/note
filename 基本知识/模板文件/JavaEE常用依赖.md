# 常用依赖

1. MySQL

   ```xml
   <!-- https://mvnrepository.com/artifact/mysql/mysql-connector-java -->
   <dependency>
       <groupId>mysql</groupId>
       <artifactId>mysql-connector-java</artifactId>
       <version>5.1.47</version>
   </dependency>
   
   ```

2. MyBatis

   ```xml
   <!-- https://mvnrepository.com/artifact/org.mybatis/mybatis -->
   <dependency>
       <groupId>org.mybatis</groupId>
       <artifactId>mybatis</artifactId>
       <version>3.4.6</version>
   </dependency>
   
   <!-- https://mvnrepository.com/artifact/org.mybatis.generator/mybatis-generator-core -->
   <dependency>
       <groupId>org.mybatis.generator</groupId>
       <artifactId>mybatis-generator-core</artifactId>
       <version>1.3.7</version>
   </dependency>
   
   <!-- https://mvnrepository.com/artifact/com.github.pagehelper/pagehelper -->
   <dependency>
       <groupId>com.github.pagehelper</groupId>
       <artifactId>pagehelper</artifactId>
       <version>5.1.8</version>
   </dependency>
   
   
   ```

3. junit

   ```xml
   <groupId>junit</groupId>
   <artifactId>junit</artifactId>
   <version>4.12</version>
   <scope>test</scope>
   </dependency>
   ```

4. Spring

   ```xml
   <dependency>
       <groupId>org.springframework</groupId>
       <artifactId>spring-core</artifactId>
       <version>5.1.3.RELEASE</version>
   </dependency>
   
   <dependency>
       <groupId>org.springframework</groupId>
       <artifactId>spring-beans</artifactId>
       <version>5.1.3.RELEASE</version>
   </dependency>
   
   <dependency>
       <groupId>org.springframework</groupId>
       <artifactId>spring-context</artifactId>
       <version>5.1.3.RELEASE</version>
   </dependency>
   
   <!-- https://mvnrepository.com/artifact/org.springframework/spring-context-support -->
   <dependency>
       <groupId>org.springframework</groupId>
       <artifactId>spring-context-support</artifactId>
       <version>5.1.3.RELEASE</version>
   </dependency>
   
   <!-- https://mvnrepository.com/artifact/org.springframework/spring-aop -->
   <dependency>
     <groupId>org.springframework</groupId>
     <artifactId>spring-aop</artifactId>
     <version>5.1.3.RELEASE</version>
   </dependency>
   
   <!-- https://mvnrepository.com/artifact/org.springframework/spring-web -->
   <dependency>
       <groupId>org.springframework</groupId>
       <artifactId>spring-web</artifactId>
       <version>5.1.3.RELEASE</version>
   </dependency>
   
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
   
   <!-- https://mvnrepository.com/artifact/org.springframework/spring-tx -->
   <dependency>
       <groupId>org.springframework</groupId>
       <artifactId>spring-tx</artifactId>
       <version>5.1.3.RELEASE</version>
   </dependency>
   
   <!-- https://mvnrepository.com/artifact/org.springframework/spring-expression -->
   <dependency>
       <groupId>org.springframework</groupId>
       <artifactId>spring-expression</artifactId>
       <version>5.1.3.RELEASE</version>
   </dependency>
   
   <!-- https://mvnrepository.com/artifact/org.springframework/spring-test -->
   <dependency>
       <groupId>org.springframework</groupId>
       <artifactId>spring-test</artifactId>
       <version>5.1.3.RELEASE</version>
       <scope>test</scope>
   </dependency>
   
   ```

5. aspectjweaver

   ```xml
   <!-- https://mvnrepository.com/artifact/org.aspectj/aspectjweaver -->
   <dependency>
     <groupId>org.aspectj</groupId>
     <artifactId>aspectjweaver</artifactId>
     <version>1.9.2</version>
   </dependency>
   ```

6. 日志

  ```xml
  <!-- https://mvnrepository.com/artifact/org.apache.logging.log4j/log4j-core -->
  <dependency>
      <groupId>org.apache.logging.log4j</groupId>
      <artifactId>log4j-core</artifactId>
      <version>2.11.2</version>
  </dependency>
  
  <!-- https://mvnrepository.com/artifact/org.slf4j/slf4j-api -->
  <dependency>
      <groupId>org.slf4j</groupId>
      <artifactId>slf4j-api</artifactId>
      <version>1.8.0-beta4</version>
  </dependency>
  
  <!-- https://mvnrepository.com/artifact/org.slf4j/slf4j-log4j12 -->
  <dependency>
      <groupId>org.slf4j</groupId>
      <artifactId>slf4j-log4j12</artifactId>
      <version>1.8.0-beta4</version>
      <scope>test</scope>
  </dependency>
  
  <!-- https://mvnrepository.com/artifact/log4j/log4j -->
  <dependency>
      <groupId>log4j</groupId>
      <artifactId>log4j</artifactId>
      <version>1.2.17</version>
  </dependency>
  	
  ```

7. servlet

   ```xml
   <!-- https://mvnrepository.com/artifact/javax.servlet/javax.servlet-api -->
   <dependency>
       <groupId>javax.servlet</groupId>
       <artifactId>javax.servlet-api</artifactId>
       <version>4.0.1</version>
       <scope>provided</scope>
   </dependency>
   
   <!-- https://mvnrepository.com/artifact/javax.servlet.jsp/javax.servlet.jsp-api -->
   <dependency>
       <groupId>javax.servlet.jsp</groupId>
       <artifactId>javax.servlet.jsp-api</artifactId>
       <version>2.3.3</version>
       <scope>provided</scope>
   </dependency>
   
   <!-- https://mvnrepository.com/artifact/javax.servlet.jsp.jstl/jstl -->
   <dependency>
     <groupId>javax.servlet</groupId>
     <artifactId>jstl</artifactId>
     <version>1.2</version>
   </dependency>
   
   ```

8. json

   ```xml
   <!-- https://mvnrepository.com/artifact/com.fasterxml.jackson.core/jackson-databind -->
   <dependency>
       <groupId>com.fasterxml.jackson.core</groupId>
       <artifactId>jackson-databind</artifactId>
       <version>2.9.8</version>
   </dependency>
   
   
   <!-- https://mvnrepository.com/artifact/com.fasterxml.jackson.core/jackson-core -->
   <dependency>
       <groupId>com.fasterxml.jackson.core</groupId>
       <artifactId>jackson-core</artifactId>
       <version>2.9.8</version>
   </dependency>
   
   <!-- https://mvnrepository.com/artifact/com.fasterxml.jackson.core/jackson-annotations -->
   <dependency>
       <groupId>com.fasterxml.jackson.core</groupId>
       <artifactId>jackson-annotations</artifactId>
       <version>2.9.8</version>
   </dependency>
   
   <!-- https://mvnrepository.com/artifact/net.sf.json-lib/json-lib -->
   <dependency>
       <groupId>net.sf.json-lib</groupId>
       <artifactId>json-lib</artifactId>
       <version>2.4</version>
   </dependency>
   
   <!-- https://mvnrepository.com/artifact/org.codehaus.jackson/jackson-core-asl -->
   <dependency>
       <groupId>org.codehaus.jackson</groupId>
       <artifactId>jackson-core-asl</artifactId>
       <version>1.9.13</version>
   </dependency>
   
   <!-- https://mvnrepository.com/artifact/org.codehaus.jackson/jackson-mapper-asl -->
   <dependency>
       <groupId>org.codehaus.jackson</groupId>
       <artifactId>jackson-mapper-asl</artifactId>
       <version>1.9.13</version>
   </dependency>
   
   
   
   ```

9. jquery

   ```xml
   <!-- https://mvnrepository.com/artifact/org.webjars.bower/jquery -->
   <dependency>
       <groupId>org.webjars.bower</groupId>
       <artifactId>jquery</artifactId>
       <version>3.3.1</version>
   </dependency>
   ```

10. jackson-dataformat-xml

   ```xml
   <!-- https://mvnrepository.com/artifact/com.fasterxml.jackson.dataformat/jackson-dataformat-xml -->
   <dependency>
       <groupId>com.fasterxml.jackson.dataformat</groupId>
       <artifactId>jackson-dataformat-xml</artifactId>
       <version>2.9.8</version>
   </dependency>
   
   ```

11. commons

    ```xml
    <!-- https://mvnrepository.com/artifact/commons-fileupload/commons-fileupload -->
    <dependency>
        <groupId>commons-fileupload</groupId>
        <artifactId>commons-fileupload</artifactId>
        <version>1.4</version>
    </dependency>
    
    <!-- https://mvnrepository.com/artifact/commons-logging/commons-logging -->
    <dependency>
        <groupId>commons-logging</groupId>
        <artifactId>commons-logging</artifactId>
        <version>1.2</version>
    </dependency>
    
    
    ```

12. 数据源

    ```xml
    <!-- https://mvnrepository.com/artifact/com.mchange/c3p0 -->
    <dependency>
        <groupId>com.mchange</groupId>
        <artifactId>c3p0</artifactId>
        <version>0.9.5.3</version>
    </dependency>
    
    ```

13. spring与Mybatis整合

    ```xml
    <!-- https://mvnrepository.com/artifact/org.mybatis/mybatis-spring -->
    <dependency>
        <groupId>org.mybatis</groupId>
        <artifactId>mybatis-spring</artifactId>
        <version>2.0.0</version>
    </dependency>
    
    ```

14. joda-time（处理日期时间）

    ```xml
    <!-- https://mvnrepository.com/artifact/joda-time/joda-time -->
    <dependency>
        <groupId>joda-time</groupId>
        <artifactId>joda-time</artifactId>
        <version>2.10.1</version>
    </dependency>
    
    ```

15. pagehelper（分页）

    ```xml
    <!-- https://mvnrepository.com/artifact/com.github.pagehelper/pagehelper -->
    <dependency>
        <groupId>com.github.pagehelper</groupId>
        <artifactId>pagehelper</artifactId>
        <version>5.1.8</version>
    </dependency>
    
    ```

16. commons-codec (md5加密)

    ```xml
    <!-- https://mvnrepository.com/artifact/commons-codec/commons-codec -->
    <dependency>
        <groupId>commons-codec</groupId>
        <artifactId>commons-codec</artifactId>
        <version>1.12</version>
    </dependency>
    
    ```

17. \

18. \

19. \

20. \

21. \

