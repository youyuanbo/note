# 动态SQL

利用动态SQL查询数据

创建表，并添加测试数据

```sql
create table address(
    add_id                      int primary key auto_increment,
    city                        varchar(20),
    province                    varchar(20),
    country                     varchar(20),
    zip                         varchar(10)
);


insert into address(city, province, country, zip)
VALUES ('成都','四川','中国','10010');

insert into address(city, province, country, zip)
VALUES ('绵阳','四川','中国','10020');

insert into address(city, province, country, zip)
VALUES ('达州','四川','中国','10030');

insert into address(city, province, country, zip)
VALUES ('广州','广东','中国','20010');

insert into address(city, province, country, zip)
VALUES ('深圳','广东','中国','20020');

insert into address(city, province, country, zip)
VALUES ('唐人街','旧金山','美国','30010');
```



1. 利用where标签和if标签

   ```wh
   <select id="queryByCityAndProvince" resultType="com.mybatis03.pojo.Address">
       select * from address
       <where>
           <if test="city != null ">
               and city = #{city}
           </if>
   
           <if test="province != null ">
               and province = #{province}
           </if>
       </where>
   </select>
   ```

   ```java
       @Test
       public void test03(){
           SqlSession session = MyBatisUtil.getSession();
           AddressMapper mapper = session.getMapper(AddressMapper.class);
           Address address = mapper.queryByCityAndProvince("成都","四川");
           System.out.println(address);
       }
   ```

2. choose标签、when标签和otherwise标签

   ```xml
   <select id="queryByList" resultType="com.mybatis03.pojo.Address"
           parameterType="com.mybatis03.pojo.Address">
       select * from address
       <where>
           <choose>
               <when test="country != null">
                   and country = #{country}
               </when>
               <when test="province != null">
                   and province = #{province}
               </when>
               <otherwise>
                   and city = #{city}
               </otherwise>
           </choose>
       </where>
   </select>
   
   ```

   ```java
       @Test
       public void test06(){
           SqlSession session = MyBatisUtil.getSession();
           AddressMapper mapper = session.getMapper(AddressMapper.class);
           Address address = new Address();
           address.setProvince("四川");
           List<Address> list = mapper.queryByList(address);
           System.out.println(list);
       }
   ```

3. trim标签

   ```xml
   <select id="queryByTrim" resultType="com.mybatis03.pojo.Address"
           parameterType="com.mybatis03.pojo.Address">
       select * from address
       <trim prefix="WHERE" suffixOverrides="AND">
           <if test="city != null and city!='' ">
               city = #{city} and
           </if>
           <if test="province != null and province!='' ">
               province = #{province} and
           </if>
           <if test="country != null and country!='' ">
               country = #{country} and
           </if>
           <if test="zip != null and zip!='' ">
               zip = #{zip} and
           </if>
       </trim>
   
       </select>
   ```

   ```java
       @Test
       public void test07(){
           SqlSession session = MyBatisUtil.getSession();
           AddressMapper mapper = session.getMapper(AddressMapper.class);
           Address address = new Address();
           address.setProvince("四川");
           List<Address> list = mapper.queryByTrim(address);
           System.out.println(list);
       }
   ```

4. foreach标签

   ```xml
   <select id="queryByIds" resultType="com.mybatis03.pojo.Address">
       select * from address
       <where>
           add_id in
           <foreach collection="list" open="(" close=")" item="item" separator=",">
               #{item}
           </foreach>
       </where>
   </select>
   ```

   ```java
   @Test
   public void test08(){
       SqlSession session = MyBatisUtil.getSession();
       AddressMapper mapper = session.getMapper(AddressMapper.class);
       List<Integer> ids = new ArrayList<>();
       ids.add(4);
       ids.add(5);
       ids.add(6);
       List<Address> list = mapper.queryByIds(ids);
       System.out.println(list);
   }
   ```

5. 模糊查询

   ```xml
   <select id="queryByLike" resultType="com.mybatis03.pojo.Address">
       select * from address
       <where>
           province like concat('%',#{city},'%')
       </where>
   </select>
   ```

   ```java
   @Test
   public void test09(){
       SqlSession session = MyBatisUtil.getSession();
       AddressMapper mapper = session.getMapper(AddressMapper.class);
       String province = "川";
       List<Address> list = mapper.queryByLike(province);
       System.out.println(list);
   }
   ```

6. 设置常用查询列

   ```xml
   <sql id="baseColumn">
       city,province,country
   </sql>
   <select id="queryByAll" resultType="com.mybatis03.pojo.Address">
       select
       <include refid="baseColumn"/>
       from address
   </select>
   ```

   ```java
   @Test
   public void test10(){
       SqlSession session = MyBatisUtil.getSession();
       AddressMapper mapper = session.getMapper(AddressMapper.class);
       List<Address> list = mapper.queryByAll();
       System.out.println(list);
   }
   ```

7. set标签（更新）

   ```xml
   <update id="update" parameterType="com.mybatis03.pojo.Address">
       update address
       <set>
           <if test="city != null and city!='' ">
               city = #{city},
           </if>
           <if test="province != null and province!='' ">
               province = #{province},
           </if>
           <if test="country != null and country!='' ">
               country = #{country},
           </if>
           <if test="zip != null and zip!='' ">
               zip = #{zip}
           </if>
       </set>
       <where>
           add_id = #{addId}
       </where>
   </update>
   ```

   ```java
   @Test
   public void test05(){
       SqlSession session = MyBatisUtil.getSession();
       AddressMapper mapper = session.getMapper(AddressMapper.class);
       Address address = new Address();
       address.setAddId(3);
       address.setCity("杭州");
       address.setProvince("浙江");
       address.setCountry("中国");
       address.setZip("40010");
       mapper.update(address);
       session.commit();
       session.close();
   }
   ```

8. \

9. \

