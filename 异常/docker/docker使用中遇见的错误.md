# Docker使用中遇见的错误

## Failed to start Docker Application Container Engine.

使用==systemctl start docker==命令启动docker，报错

```shell
Job for docker.service failed because the control process exited with error code. See "systemctl status docker.service" and "journalctl -xe" for details.
```

使用==systemctl status docker.service==命令查看具体的错误

```
Failed to start Docker Application Container Engine.
```

解决：

​	1、 使用==yum list installed | grep docker==命令查看与docker相关的安装包

​	2、 删除所有的安装包==yum -y remove xxx==

​	3、重新安装==yum -y install docker==

​	4、添加镜像：

```
curl -sSL https://get.daocloud.io/daotools/set_mirror.sh | sh -s http://f1361db2.m.daocloud.io
```

​	5、启动docker==systemctl start docker==

​	如果启动失败，修改daemon.json文件

```shell
vim /etc/docker/daemon.json
```

​	修改后的daemon.json文件

```shell
{"registry-mirrors": ["http://f1361db2.m.daocloud.io"]}
```

再次启动，完毕。



