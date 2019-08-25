# Redis

## 在windows下连接Linux中的redis

1. 修改对应的redis.conf
   + 注释掉：bind 127.0.0.1
   + 添加： bind XXX.XXX.XXX.XXX
   + 关闭安全模式：protected-mode no
   + 允许redis后台运行：daemonize yes
2. 启动redis服务 redis-server + 对应的conf文件
3. 连接



## Redis连接（指定IP）

1. 启动服务

    redis-server + 对应的conf文件

2. 连接

   redis-cli -h XXX.XXX.XXX.XXX -p XXXX