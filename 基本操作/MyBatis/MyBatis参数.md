# MyBatis 参数

## 单个基本参数类型

如果是单个参数，那么#{}表达式里面可以任意填写一个字符串，但是为了规范，应该写具有含义的名称。

```java
Girl queryById(Integer id);
```

```xml
<select id="queryById" resultType="com.mybatis.pojo.Girl">
    select * from girl where id = #{id}
</select>
```

## 非基本参数类型（String）

1. 单个参数

   ```java
   Girl queryByName(String name);
   ```

   ```xml
   <select id="queryByName" resultType="com.mybatis.pojo.Girl">
       select * from girl where name = #{name}
   </select>
   ```

   ```java
   @Test
   public void test03(){
       SqlSession session =MyBatisUtil.getSession();
       GirlMapper mapper = session.getMapper(GirlMapper.class);
       Girl girl = mapper.queryByName("小梁");
       System.out.println(girl);
   }
   ```

2. 多个参数

   ```java
   Girl queryByNameAndFlower(String name, String flower);
   ```

   在传递参数时，可以使用param或者arg，（param下标从1开始，arg下标从0开始），

   ```xml
   <select id="queryByNameAndFlower" resultType="com.mybatis.pojo.Girl">
       select * from girl where name = #{param1} and flower = #{param2}
   </select>
   ```

   ```xml
   <select id="queryByNameAndFlower" resultType="com.mybatis.pojo.Girl">
       select * from girl where name = #{arg0} and flower = #{arg1}
   </select>
   ```

   使用自定义参数（推荐使用）

   ```java
   Girl queryByParam(@Param("name") String name, @Param("flower") String flower);
   ```

   ```xml
   <select id="queryByParam" resultType="com.mybatis.pojo.Girl">
       select * from girl where name=#{name} and flower=#{flower};
   </select>
   ```

## 单个JavaBean

```java
Girl queryByJavaBean(Girl girl);
```

```xml
<select id="queryByJavaBean" resultType="com.mybatis.pojo.Girl">
    select * from girl where name = #{name} and flower = #{flower};
</select>
```

```java
@Test
public void test05(){
    SqlSession session = MyBatisUtil.getSession();
    GirlMapper mapper = session.getMapper(GirlMapper.class);
    Girl girl = new Girl();
    girl.setName("小梁");
    girl.setflower("玫瑰");
    Girl girl1 = mapper.queryByJavaBean(girl);
    System.out.println(girl1);
    session.commit();
    session.close();
}
```

## Map

Mapper接口

```java
Girl queryByMap(Map<String, Object> map);
```

mapper.xml文件

```xml
<select id="queryByMap" resultType="com.mybatis.pojo.Girl">
    select * from girl where name = #{name} and flower = #{flower};
</select>
```

测试程序

```java
@Test
public void test06(){
    SqlSession session = MyBatisUtil.getSession();
    GirlMapper mapper = session.getMapper(GirlMapper.class);
    Map<String, Object> map = new HashMap<>();
    map.put("name","小梁");
    map.put("flower", "玫瑰");
    Girl girl = mapper.queryByMap(map);
    System.out.println(girl);
    session.commit();
    session.close();
}
```

## 多个JavaBean

A类

```java
package com.mybatis.pojo;

public class A {
    private String name;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
```

B类

```java
package com.mybatis.pojo;

public class B {
    private String flower;

    public String getFlower() {
        return flower;
    }

    public void setFlower(String flower) {
        this.flower = flower;
    }
}
```

mapper接口

```java
Girl queryByJavaBeans(@Param("A") A a, @Param("B") B b);
```

mapper.xml文件

```xml
<select id="queryByJavaBeans" resultType="com.mybatis.pojo.Girl">
    select * from girl where name = #{A.name} and flower = #{B.flower};
</select>
```

测试程序

```java
@Test
public void test07(){
    SqlSession session = MyBatisUtil.getSession();
    GirlMapper mapper = session.getMapper(GirlMapper.class);
    A a = new A();
    B b = new B();
    a.setName("小梁");
    b.setFlower("玫瑰");
    Girl girl = mapper.queryByJavaBeans(a,b);
    System.out.println(girl);
    session.commit();
    session.close();
}
```

