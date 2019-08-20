# MySQL解压版安装

1. 下载MySQL数据库，解压在指定目录中

2. 在系统环境变量中

   + 新增MYSQL_HOME，值为数据库解压目录

   ```
   D:\SoftwareInstallation\mysql-5.7.24-winx64
   ```

   + 在path中添加 %MYSQL_HOME%\bin

3. 在D:\SoftwareInstallation\mysql-5.7.24-winx64下新建“my.ini”文件，内容如下：

   ```ini
   
   [mysqld]
   
   port = 3306
   
   basedir=D:/SoftwareInstallation/mysql-5.7.24-winx64
   datadir=D:/SoftwareInstallation/mysql-5.7.24-winx64/data 
   
   max_connections=200
   
   character-set-server=utf8
   
   default-storage-engine=INNODB
   
   sql_mode=NO_ENGINE_SUBSTITUTION,STRICT_TRANS_TABLES
   
   [mysql]
   
   default-character-set=utf8
   
   ```

4. 以管理员身份打开cmd命令窗口，进入到D:/SoftwareInstallation/mysql-5.7.24-winx64/bin目录下

   在目录下新建一个目录——data

5. 执行以下程序初始化数据库

   ```cmd
   mysqld --initialize-insecure --user=mysql
   ```

6. 执行以下命令安装数据库

   ```cmd
   mysqld -install --defaults-file=D:\SoftwareInstallation\mysql-5.7.24-winx64\my.ini
   ```

7. 启动数据库服务

   ```cmd
   net start mysql
   ```

8. 设置密码

   ```cmd
   mysqladmin -u root -p password
   ```

   或者使用下面的方式初始化root用户的密码：

   + mysql -u root mysql
   + update user set authentication_string=password("newPassword") where user=”root”;
   + flush privileges;

9. 关闭数据库服务器

   ```cmd
   net stop mysql
   ```

## 初始化密码

在初始化数据库之后，不能直接登录mysql。需要执行以下步骤：

1. 关闭MySQL服务

   net stop mysql

2. 设置无权限登录MySQL

   mysqld --user=mysql --skip-grant-tables --skip-networking&

3. 启动MySQL服务

   net start mysql

4. 登录MySQL

   mysql -u root mysql

5. 更新user表

   update user set authentication_string=password("newPassword") where user=”root”;	

6. 刷新权限

   flush privileges;

7. 退出重新登录

   exit;

   mysql -u root -p root