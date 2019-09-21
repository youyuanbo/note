# Mysql



## 在windows上连接Linux上的Mysql

1. 确保防火墙关闭

2. 授权

   对任何用户授权：GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root' WITH GRANT OPTION;

3. 刷新权限

   FLUSH PRIVILEGES;

4. 连接

