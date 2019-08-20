# 使用CopSSH搭建自己的Git服务器

## 安装CopSSH

+ 用户名：Copssh
+ 密码：www.Copssh.com

## 在计算机中新增用户

+ 用户名：coder_yyb
+ 密码：coder_yyb

## 将coder_yyb用户配置到CopSSH之中

+ 打开CopSSH控制面板

  ![1552477509642](E:\笔记\工具\使用CopSSH搭建自己的Git服务器\img\%5CUsers%5Ccentos%5CAppData%5CRoaming%5CTypora%5Ctypora-user-images%5C1552477509642.png)

+ 选择Users

  ![1552477649794](E:\笔记\工具\使用CopSSH搭建自己的Git服务器\img\%5CUsers%5Ccentos%5CAppData%5CRoaming%5CTypora%5Ctypora-user-images%5C1552477649794.png)

+ 点击forward

  ![1552477683150](E:\笔记\工具\使用CopSSH搭建自己的Git服务器\img\%5CUsers%5Ccentos%5CAppData%5CRoaming%5CTypora%5Ctypora-user-images%5C1552477683150.png)

+ 选择主机与用户

  ![1552477719986](E:\笔记\工具\使用CopSSH搭建自己的Git服务器\img\%5CUsers%5Ccentos%5CAppData%5CRoaming%5CTypora%5Ctypora-user-images%5C1552477719986.png)

+ 只能通过SSH连接，关闭密码验证

  ![1552477779785](E:\笔记\工具\使用CopSSH搭建自己的Git服务器\img\%5CUsers%5Ccentos%5CAppData%5CRoaming%5CTypora%5Ctypora-user-images%5C1552477779785.png)

+ 点击forward

  ![1552477855797](E:\笔记\工具\使用CopSSH搭建自己的Git服务器\img\%5CUsers%5Ccentos%5CAppData%5CRoaming%5CTypora%5Ctypora-user-images%5C1552477855797.png)

+ 点击Apply完成

  ![1552477883352](E:\笔记\工具\使用CopSSH搭建自己的Git服务器\img\%5CUsers%5Ccentos%5CAppData%5CRoaming%5CTypora%5Ctypora-user-images%5C1552477883352.png)

+ 返回到主界面

  ![1552477921247](E:\笔记\工具\使用CopSSH搭建自己的Git服务器\img\%5CUsers%5Ccentos%5CAppData%5CRoaming%5CTypora%5Ctypora-user-images%5C1552477921247.png)

## 为用户手工配置SSH-KEY（一）

+ 拷贝生成的公钥信息（位置：C:\Users\centos\.ssh\id_rsa.pub）
+ 粘贴到指定的目录(coder_yyb的家目录)：D:\SoftwareInstallation\CopSSH\home\coder_yyb\.ssh
+ 修改公钥文件名称为：authorized_keys

## 为用户手工配置SSH-KEY（二）

+ 选中用户，点击Add

  ![1552479193249](E:\笔记\工具\使用CopSSH搭建自己的Git服务器\img\%5CUsers%5Ccentos%5CAppData%5CRoaming%5CTypora%5Ctypora-user-images%5C1552479193249.png)

+ 点击add

  ![1552479243022](E:\笔记\工具\使用CopSSH搭建自己的Git服务器\img\%5CUsers%5Ccentos%5CAppData%5CRoaming%5CTypora%5Ctypora-user-images%5C1552479243022.png)

+ 选择forwward

  ![1552479274557](E:\笔记\工具\使用CopSSH搭建自己的Git服务器\img\%5CUsers%5Ccentos%5CAppData%5CRoaming%5CTypora%5Ctypora-user-images%5C1552479274557.png)

+ 将comment改为配置公钥时的邮箱

  ![1552479329296](E:\笔记\工具\使用CopSSH搭建自己的Git服务器\img\%5CUsers%5Ccentos%5CAppData%5CRoaming%5CTypora%5Ctypora-user-images%5C1552479329296.png)

+ 输出公钥的保护密码

  ![1552479510280](E:\笔记\工具\使用CopSSH搭建自己的Git服务器\img\%5CUsers%5Ccentos%5CAppData%5CRoaming%5CTypora%5Ctypora-user-images%5C1552479510280.png)

+ 选择公钥的保存位置

  ![1552479482475](E:\笔记\工具\使用CopSSH搭建自己的Git服务器\img\%5CUsers%5Ccentos%5CAppData%5CRoaming%5CTypora%5Ctypora-user-images%5C1552479482475.png)

+ 填写公钥的文件名

  ![1552479559554](E:\笔记\工具\使用CopSSH搭建自己的Git服务器\img\%5CUsers%5Ccentos%5CAppData%5CRoaming%5CTypora%5Ctypora-user-images%5C1552479559554.png)

+ 点击forward并点击apply就完成了

  ![1552479618758](E:\笔记\工具\使用CopSSH搭建自己的Git服务器\img\%5CUsers%5Ccentos%5CAppData%5CRoaming%5CTypora%5Ctypora-user-images%5C1552479618758.png)

+ 配置成功

  ![1552479655468](E:\笔记\工具\使用CopSSH搭建自己的Git服务器\img\%5CUsers%5Ccentos%5CAppData%5CRoaming%5CTypora%5Ctypora-user-images%5C1552479655468.png)



## 连接服务器

+ 在git bash中输入命令：ssh coder_yyb@ + ipaddr

  ssh coder_yyb@192.168.252.1

+ 密码：coder_yyb

## 修改以下两个文件

+ D:\SoftwareInstallation\CopSSH\etc\profile

  配置git的执行命令路径

  + D:\SoftwareInstallation\Git\mingw64\bin
  + D:\SoftwareInstallation\Git\mingw64\libexec\git-core

  配置完成：

  export PATH="/bin:$syspath:$winpath:/cygdrive/D/SoftwareInstallation/Git/mingw64/bin:/cygdrive/D/SoftwareInstallation/Git/mingw64/libexec/git-core"

+ D:\SoftwareInstallation\CopSSH\home\coder_yyb\.bashrc

## 重启CopSSH服务

## 在git bash中连接服务器

- ssh coder_yyb@192.168.252.1
- 密码：coder_yyb

## 创建仓库

+ 创建仓库：mkdir yyb  .git
+ 进入到仓库： cd yyb .git
+ 初始化仓库：git init --bare
+ 从远程仓库中克隆：git clone coder_yyb@192.168.252.1:yyb.git



