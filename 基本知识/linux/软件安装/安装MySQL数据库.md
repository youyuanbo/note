# 在Linux环境下安装Mysql数据库

## 使用yum安装

1. 检查是否已经安装

   rpm -qa | grep mysql

2. 如果安装有Mysql，则先卸载Mysql

   + 普通卸载：rpm -e XXX
   + 强制卸载：rpm -e XXX --nodeps

3. 再次检查

   rpm -qa | grep mysql

4. 下载安装包文件

   wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm

5. 安装rpm包

   rpm -ivh XXX.rpm

6. 查看相应的yum源文件

   + 在/etc/yum.repos.d/文件夹下，新增mysql-community.repo 、mysql-community-source.repo 两个 yum 源文件。
   + 执行 yum repolist all | grep mysql 命令查看可用的 mysql 安装文件。

7. 安装Mysql服务端

   yum -y install mysql-server

8. 检查Mysql是否安装成功

   rpm -qa | grep mysql

9.  mysql启动与停止

   + 启动：systemctl start mysqld.service | service mysql start
   + 停止：systemctl stop mysqld.service | service mysql stop
   + 重启：systemctl restart mysqld.service | service mysql restart
   + 开机自启：systemctl enable mysqld.service | service mysql start

10. 初始化root用户密码

     /usr/bin/mysqladmin -u root password XXX



## 使用安装包安装

1. 下载

   + 进入[Mysql官网](https://www.mysql.com/)
   + downloads
   + Community
   + Mysql Community Server
   + 选择版本
   + 选择操作系统：Red Hat Enterprise Linux / Oracle Linux

   + MySQL-server-5.5.62-1.el7.x86_64.rpm
   + MySQL-client-5.5.62-1.el7.x86_64.rpm

2. 安装

   + rpm -ivh MySQL-server-5.5.62-1.el7.x86_64.rpm
   + rpm - ivh MySQL-client-5.5.62-1.el7.x86_64.rpm

3. 初始化密码

   + /usr/bin/mysqladmin -u root password XXX

4. 开机自启

   + chkconfig mysql on

