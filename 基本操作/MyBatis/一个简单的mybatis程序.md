# 编写一个简单的MyBatis程序



## 引入依赖

```xml
<!-- https://mvnrepository.com/artifact/mysql/mysql-connector-java -->
<dependency>
    <groupId>mysql</groupId>
    <artifactId>mysql-connector-java</artifactId>
    <version>5.1.47</version>
</dependency>
<!-- https://mvnrepository.com/artifact/org.mybatis/mybatis -->
<dependency>
    <groupId>org.mybatis</groupId>
    <artifactId>mybatis</artifactId>
    <version>3.5.0</version>
</dependency>
```

## myBatis-cfg.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE configuration PUBLIC "-//mybatis.org//DTD Config 3.0//EN" "http://mybatis.org/dtd/mybatis-3-config.dtd">
<configuration>
    <environments default="dev">
        <environment id="dev">
            <transactionManager type="JDBC"></transactionManager>
            <dataSource type="UNPOOLED">
                <property name="url" value="jdbc:mysql://localhost:3306/mybatis"/>
                <property name="driver" value="com.mysql.jdbc.Driver"/>
                <property name="username" value="root"/>
                <property name="password" value="root"/>
            </dataSource>
        </environment>
    </environments>

    <mappers>
        <mapper resource="com/mybatis/mapper/GirlMapper.xml"></mapper>
    </mappers>
</configuration>
```

## MyBatisUtil.java

```java
package com.mybatis.util;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import java.io.IOException;
import java.io.InputStream;

public class MyBatisUtil {
    private static SqlSessionFactory sqlSessionFactory;
    static{
        String resource = "myBatis-cfg.xml";
        InputStream stream = null;
        try {
            stream = Resources.getResourceAsStream(resource);
            sqlSessionFactory = new SqlSessionFactoryBuilder().build(stream);
        } catch (IOException e) {
            e.printStackTrace();
        }finally {
            if (stream != null){
                try {
                    stream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    public static SqlSession getSession(){
        return sqlSessionFactory.openSession();
    }
}

```

# 数据库程序

```sql
create database mybatis;

use mybatis;

drop table if exists Girl;
create table Girl(
  id            int auto_increment ,
  name          varchar(10),
  flower        varchar(10),
  primary key (id)
);
```

## 编写pojo类

```java
package com.mybatis.pojo;

public class Girl {
    private Integer id;
    private String name;
    private String flower;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getFlower() {
        return flower;
    }

    public void setFlower(String flower) {
        this.flower = flower;
    }
}

```

## 编写mapper接口

```java
package com.mybatis.mapper;

import com.mybatis.pojo.Girl;

public interface GirlMapper {
    int insert(Girl girl);

}

```

每一个mapper接口文件对应一个mapper.xml映射文件

## 编写 mapper.xml 文件

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="com.mybatis.mapper.GirlMapper">

    <insert id="insert">
        insert into girl(name, flower) values (#{name}, #{flower})
    </insert>
</mapper>
```

## 编写测试程序

```java
package com.mybatis;

import com.mybatis.mapper.GirlMapper;
import com.mybatis.pojo.Girl;
import com.mybatis.until.MyBatisUtil;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;

public class TestMyBatis {
    @Test
    public void test01(){
        SqlSession session = MyBatisUtil.getSession();
        GirlMapper mapper = session.getMapper(GirlMapper.class);
        Girl girl = new Girl();
        girl.setName("小梁");
        girl.setFlower("玫瑰");
        mapper.insert(girl);
        session.commit();
        session.close();
    }

}
```