# centos网络配置

## 基本步骤

1. 进入系统

2. cd /etc/sysconfig/network-scripts

3. vi ifcfg-ens33

4. 在ifcfg-ens33添加

   ```json
   ONBOOT=yes
   NM_CONTROLLED=yes
   BOOTPROTO=static
   IPADDR=192.168.192.101
   NETMASK=255.255.255.0
   GATEWAY=192.168.192.2
   DNS1=114.114.114.114
   DNS2=8.8.8.8
   ```

5. cd /etc/udev/rules.d/

   删除 70-persistent-net.rules


## 查看网络属性

1. 查看子网ip和子网掩码

   点击编辑，点击虚拟网络编辑器

   ![1548828009122](E:\笔记\linux\img\%5CUsers%5Ccentos%5CAppData%5CRoaming%5CTypora%5Ctypora-user-images%5C1548828009122.png)

2. 查看子网ip，子网掩码

   ![1548828199995](E:\笔记\linux\img\%5CUsers%5Ccentos%5CAppData%5CRoaming%5CTypora%5Ctypora-user-images%5C1548828199995.png)

3. 、

## 快照

1. 点击快照按钮

   ![1548835187947](E:\笔记\linux\img\%5CUsers%5Ccentos%5CAppData%5CRoaming%5CTypora%5Ctypora-user-images%5C1548835187947.png)

2. 点击拍摄快照

   ![1548835231432](E:\笔记\linux\img\%5CUsers%5Ccentos%5CAppData%5CRoaming%5CTypora%5Ctypora-user-images%5C1548835231432.png)

3. 为快照取名和添加描述

   ![1548835338421](E:\笔记\linux\img\%5CUsers%5Ccentos%5CAppData%5CRoaming%5CTypora%5Ctypora-user-images%5C1548835338421.png)


4. 拍摄完成

   ![1548835409688](E:\笔记\linux\img\%5CUsers%5Ccentos%5CAppData%5CRoaming%5CTypora%5Ctypora-user-images%5C1548835409688.png)

## 克隆

1. 点击快照管理按钮
2. 点击克隆
3. 依次点击下一步
4. 克隆完成