# MySQL高级

## MySQL架构介绍

1. MySQL是一个关系型数据库。

2. 启动与关闭MySQL服务

   + 启动：service mysql start
   + 关闭：service mysql stop

3. 更改root用户的密码

   + mysqladmin -u root -password XXXX

4. 修改MySQL配置文件

   + 查看字符编码集

     show variables like '%char%';

   + 修改/usr/lib/share/mysql-huge.cnf文件

     在client节点字下添加：

     default-character-set=utf8

     在mysqld节点下添加：

     character_set_server=utf8

     character_set_client=utf8

     collation-server=utf8_general_ci

   + 在mysql节点下添加

     default-character-set=utf8

5. MySQL主要配置文件

   + 二进制日志文件（log-bin）：主要用户主从复制
   + 错误日志（log-error）：默认是关闭的，记录严重的警告与错误信息，每次启动和关闭的详细信息等。
   + 查询日志（log）：默认关闭，记录查询的sql语句。如果开启，会降低MySQL的整体性能，因为日志记录也需要消耗系统资源。
   + 数据文件
     1. 系统
        1. windows系统：MySQL_HOME/data
        2. Linux系统：/var/lib/mysql
     2. frm文件:存放表结构
     3. myd文件：存放表数据
     4. myi文件：存放表索引
   + 相关配置

6. MyISAM与InnoDB

   ![1557293519407](image\1557293519407.png)





## 索引优化分析

1. ### 性能下降SQL慢、执行时间长、等待时间长

   + 查询语句写得差
   + 索引失效
     1. 单值
     2. 复合
   + 关联查新太多join（设计缺陷或不得已的需求）
   + 服务器调优及各个参数设置（缓冲、线程数等）

2. ### 常见通用的Join查询

   + SQL执行顺序

     1. 手写

        select ... from ... where ... group by ... having ... order by ... limit

     2. 机读

        from ... where ... group by ... having ... select ... distinct ... order by ... limit

     3. 总结

        

   + Join图

   + 建表SQL

   + 7中JOIN

     1. 内连接

        select * from tbl_dept a ==inner join== tbl_emp b ==on a.id=b.deptId==;

        ![1557294035629](image\1557294035629.png)

     2. 左外连接

        select * from tbl_dept a ==left join== tbl_emp b ==on a.id=b.deptId==;

        ![1557294071647](image\1557294071647.png)

     3. 右外连接

        select * from tbl_dept a ==right join== tbl_emp b ==on a.id=b.deptId==;

        ![1557294115564](image\1557294115564.png)

     4. 左连接

        select * from tbl_dept a ==left join== tbl_emp b ==on a.id=b.deptId== where ==b.deptId is null==;

        ![1557294188060](image\1557294188060.png)

     5. 右连接

        select * from tbl_dept a ==right join== tbl_emp b on ==a.id=b.deptId== where ==a.id is null==;

        ![1557294208633](image\1557294208633.png)

     6. 全连接

        select * from tbl_dept a right join tbl_emp b on a.id=b.deptId 
        union 
        select * from tbl_dept a left join tbl_emp b on a.id=b.deptId;

        

        select * from TableA a ==full outer join== TableB b ==on a.key=b.key==;

        ![1557294232208](image\1557294232208.png)

     7. 两张表中都没有出现的数据集

        select * from tbl_dept a right join tbl_emp b on a.id=b.deptId where a.id is null 
        union 
        select * from tbl_dept a left join tbl_emp b on a.id=b.deptId where b.deptId is null;

        

        select * from TableA a ==full outer join== TableB b ==on a.key=b.key== where ==a.key IS NULL OR b.key IS NULL==;

        ![1557294262028](image\1557294262028.png)

     8. 

3. ### 索引简介

   + 定义：索引（index）是帮助Mysql高效获取数据的数据结构

   + 本质：数据结构，排好序的快速查找数据结构

     1. 在数据之外，数据库系统还维护着满足特定查找算法的数据结构，这写数据结构以某种方式引用（指向）数据，这样可以在这些数据结构上实现高级查找算法。这种数据结构，就是索引。
     2. 一般来说索引本身也很大，不可能全部存储在内存中，因此索引往往以索引文件的形式存储在磁盘中。
     3. ==平常所说的索引，如果没有特别指明，都是指B树（多路搜索树，并不一定是二叉的）结构组织的索引。==其中聚集索引，次要索引，覆盖索引，符合索引，前缀索引，唯一索引默认都是使用==B+树==，统称为索引。当然，除了B+树这种类型的索引之外，还有哈希索引（Hash index）等。
     4. 

   + 目的：提高查找效率

   + 优势

     1. ==提高数据检索效率==，降低数据库的IO成本
     2. 通过索引列对数据进行排序，==降低数据排序的成本==，降低了CPU的消耗

   + 劣势

     1. 实际上索引也是一张表，该表保存了主键与索引字段，并指向实体表的记录，所以索引列也是要占用空间的。
     2. 虽然索引大大提高了查询速度，同时却会降低更新表的速度，如对表进行Insert、Update和Delete。因为更新表时，MySQL不仅要保存数据，还要保存索引文件每次更新添加了索引的字段，都会调整因为更新所带来的键值变化后的索引信息。
     3. 索引只是提高效率的一个因素，如果MySQL有大数据量的表，就需要花时间研究建立最优秀的索引，或者优化查询。

   + Mysql索引分类

     1. 单值索引：一个索引只包含单个列，一个表可以有多个单列索引
     2. 唯一索引：索引列的值必须唯一，但允许有空值
     3. 复合索引：一个索引包含多个列
     4. 覆盖索引：select的数据列只从索引中就能够取得，不必读取数据行，Mysql可以利用索引返回select列表中的子段，而不必根据索引再次读取数据文件，换句话说，查询列要被所建的索引覆盖。
     5. 基本语法
        - ==创建==：
          1. Create [Unique] Index indexName On TableName(ColumnName(length));
          2. Alter TableName Add [Unique] Index [IndexName] On (ColumnName(length));
        - ==删除==：Drop Index [IndexName] On TableName;
        - ==查看==：Show Index From TableName;
        - ==Alter命令==
          1. Alter Table TableName Add Primary Key(column_list): 添加一个主键，这意味着索引值必须唯一且不为空
          2. Alter Table TableName Add Unique IndexName(column_list)：创建索引的值必须唯一，但是可以存在多个null
          3. Alter Table TableName Add Index IndexName(column_list)：添加普通索引，索引值可以出现多次
          4. Alter Table TableName Add FullText IndexName(column_list)：指定索引为全文索引，可用于全文索引。

   + Mysql索引结构

     1. ==BTree索引==

        所有真实数据存储在叶子节点，非叶子节点只存储指引索引方向的数据项。

     2. Hash索引

     3. full-text索引

     4. R-Tree索引

   + 哪些情况需要创建索引

     1. 主键自动建立唯一索引。
     2. 频繁作为查询条件的字段应该创建索引。
     3. 查询中与其它表关联的字段，外键关系建立索引。
     4. 频繁更新的字段不适合创建索引：因为更新时，不仅更新记录，还会更新索引。
     5. where条件中用不到的字段不创建索引。
     6. 在高并发下倾向于创建组合索引。
     7. 查询中排序的字段，排序字段若通过索引访问将大大提高排序速度
     8. 查询中统计或者分组字段

   + 哪些情况不能要创建索引

     1. 表记录太少
     2. 经常增删改的表：如果建立索引，在提高了查询速度的时候，也降低了更新表的速度。因为在更新表时，Mysql不仅要保存数据，还要保存索引文件。
     3. 数据重复且分布均匀的表字段。因为数据列包含许多重复，为该列建立索引就没有太大的实际效果。

     索引的选择性：索引的选择性是指索引列中不同值得数目与表中记录数的比。如果一个表中有2000条数据，表索引列有1980个不同的值，那么这个索引的选择性就是1980/2000=0.99。一个索引的选择性越接近1，这个索引的效率就越高。

4. ### 性能分析

   + MySql Query Optimizer

   + MySQL常见瓶颈

     1. CPU：CPU在饱和的时候一般发生在数据装入内存或从磁盘上读取数据时候
     2. IO：磁盘IO瓶颈发生在装入数据远大于内存容量的时候
     3. 服务器硬件的性能瓶颈：top、free、iostat和vmstat来查看系统的性能状态

   + Explain

     1. 定义：用户查看执行计划

     2. 功能：

        - 表的读取顺序
        - 数据读取操作的操作类型
        - 哪些索引可以使用
        - 哪些索引被实际使用
        - 表之间的引用
        - 每张表有多少行被优化器查询

     3. 使用方法

        Explain + SQL语句

     4. 各字段名字解释

        - ==id==: select查询的序列号，包含一组数字，表示查询中执行select子句或操作表的顺序

          有三种情况

          1. id相同，执行顺序由上至下
          2. id不同，如果是子查询，id的序号会递增，id值越大优先级越高，越先被执行
          3. id相同不同，同时存在。id如果相同，可以认为是一组，从上往下顺序执行。

        - select_type: 查询类型

          查询的类型，主要用于区别普通查询、联合查询、子查询等复杂查询。

          1. Simple：简单的select查询，查询中不包含子查询或者联合查询
          2. Primary：查询中包含任何复杂的子部分，最外层查询则被标记为Primary（最后加载的）
          3. Subquery：在Select或where列表中包含了子查询
          4. Derived：在From列表中包含了子查询会被标记为Derived（衍生），MySQL会递归执行这些子查询，把结果放在临时表中。
          5. Union：若第二个select出现在Union之后，则会被标记为Union；若from子句的中包含子查询，并且该子查询中包含Union，外层的select将会被标记为Derived
          6. UnionResult：从Union表获取结果的select

        - table: 显示这一行的数据是关于哪张表的

        - ==type==：访问类型排列

          从最好到最差依次是：

          所有：system > const > eq_ref > ref > fulltext > ref_or_null > index_merge > unique_subquery > range > idnex > ALL

          ==常用：system > const > eq_ref > ref > range > index > ALL==

          一般来说：需要保证查询至少达到range级别，最好达到ref

          1. system：表中只有一行记录（等于系统表），这是const类型的特例，平时不会出现，这个也可以忽略。
          2. const：表通过索引依次九找到了，const用于比较Primary key或者unique索引。因为只匹配一行数据，所以很快。如果将主键置于where列表中，MySQL就能将该查询转换为一个常量。
          3. eq_ref：唯一性索引扫描，对于每个索引键，表中只有一条记录与之匹配。常用语主键或唯一索引扫描。
          4. ==ref==：非唯一索引扫描，返回匹配某个单独值的所有行。本质上也是一种索引访问，它返回所有匹配某个单独值的行，然而，它可能会找到多个符合条件的行，所以他应该属于查找和扫描的混合体。
          5. ==range==：只检索给定范围的行，使用一个索引来选择行。key列显示使用了哪个索引，一般就是在where语句中出现了between、<、>、in等的查询。这种范围扫描索引比全表扫描要好，因为它只需要开始于索引的某一点，而结束另一点，不用扫描全部索引。
          6. index：Full index scan，index与All的区别是：index类型只遍历索引树，通常比All快。因为索引文件通常比数据文件小。（index与All都是读全表，但是index是从索引读取，而All是从磁盘中读取）。
          7. All：Full Table Scan将遍历全表，以找到匹配的行（读取磁盘数据）。

        - possible_keys: 显示==可能应用在这张表中的索引==，一个或多个。查询涉及在到的字段上若存在索引，则该索引将被列出，但不一定被查询实际使用。

        - ==key==: ==实际使用的索引==。如果为NULL，则没有使用索引。查询中若使用了覆盖索引，则该索引仅出现在key列表中。

          覆盖索引：

        - key_len: 表示索引中使用的字节数，可以通过该列计算查询中使用的索引的长度。在不损失精确性的情况下，长度越短越好。==key_len显示的值为索引字段的最大可能长度，并非实际使用长度==，即key_len是根据表定义计算而得，不是通过表内检索出的。

        - ref: 显示索引的哪一列被使用了，如果可能的话，是一个常数。哪些列或常量被用于查找索引列上的值

        - ==rows==: 根据表统计信息及索引选用情况，大致估算出找到所需的记录要读取的行数。

        - ==Extra==:  包含不适合在其它列中显示，但又非常重要的信息

          1. Using filesort：说明Mysql会对数据使用一个外部的索引排序，而不是按照表内的索引顺序进行读取。MySQL中无法利用索引完成的排序操作称为“文件排序”。
          2. Using temporary：使用了临时表保存中间结果，MySQL在对查询结果排序时使用临时表。常见于排序order by和分组查询group by。
          3. Using Index：表示相应的select操作中使用了覆盖索引（Covering Index），避免访问了表的数据行，效率不错。如果同时出现Using where，表明索引被用来执行索引键值的查找；如果没有同时出现Using where，表明索引用来读取数据而非执行查找动作
          4. Using where：表明使用了where过滤
          5. Using Join buffer：使用了连接缓存
          6. impossible where
          7. select tables optimized away
          8. distinct 

        - 、

        - 

     5. 案例

     6. 

   + 方法

5. ### 索引优化

   

6. 、

## 查询截取分析

## MySQL锁机制

## 主从复制