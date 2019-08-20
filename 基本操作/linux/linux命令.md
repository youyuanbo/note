# Linux命令

## 常用命令

+ 关机：poweroff
+ 重启：init 6
+ 重启网络服务：service network restart
+ 修改主机名称：hostnamectl set-hostname XXX
+ 在XShell中连接centos：ssh root@192.168.192.101

## Linux简单命令一

+ type 查找命令的路径，判断命令类型
+ cd 路径转换
+ man 外部命令帮助
+ help 内部命令帮助
+ 安装man命令： yum install man -y
+ whereis 定位命令位置
+ file 文件类型
+ echo 打印到标准输出
+ $PATH  环境变量：路径
+ ps -ef   查看进程列表
+ 定义数组： a=(1 2 3)
+ 输出数组中的任意项：echo ${a[1]}
+ echo $$   输出当前shell的PID
+ hash -r 清楚缓存
+ df -h   查看挂载分区

## Linux文件系统

+ /bin：可执行文件，用户命令
+ /sbin：管理命令
+ /boot：系统启动相关的文件
+ /dev：设备文件
+ /etc：配置文件
+ /home：用户的家目录，每一个用户的家目录通常默认为/home/USERNAME
+ /root：管理员的家目录
+ /lib：库文件
+ /media：挂载点目录，移动设备
+ /mnt：挂载点目录，额外的临时文件系统
+ /opt：可选目录，第三方程序的安装目录
+ /proc：伪文件系统，内核映射文件
+ /sys：伪文件系统，跟硬件设备相关的属性映射文件
+ /tmp：临时文件，/var/temp
+ /var：可变化的文件

## Linux 文件系统命令

+ df：显示磁盘使用情况（df -h）
+ du：显示文件系统使用情况(du -h)
+ ls：显示目录
+ cd：切换工作目录
+ pwd：显示当前工作目录
+ mkdir：创建目录
+ rm：删除
+ cp：拷贝
+ mv：移动
+ ln：链接
+ stat：元数据
+ touch：

## ls -l

+ 文件类型：
  + -：普通文件（f）
  + d：目录文件
  + b：块设备文件（block）
  + c：字符设备文件（character）
  + l：符号连接文件（symbolic link file）
  + p：命令管道文件（pipe）
  + s：套接字文件（socket）
+ 文件权限：9位，每3位一组，3组权限（User，Group，Other），每一组：rwx（读，写，执行）
+ 文件硬链接的次数
+ 文件的属主（owner）
+ 文件的属组（group）
+ 文件大小（size），单位是字节
+ 时间戳（timestamp）：最近一次被修改的时间
  + 访问：access
  + 修改：modify，文件内容发生了改变
  + 改变：change，metadata，元数据

## Linux文本操作命令

+ cat
  + -more
  + -less
  + -head   从前往后看
    + head  -5   XXX
  + -tail     从后往前看
    + tail    -5 XXX
    + tail -f  XXX    查看追加的内容
+ 管道
  + cat b.txt  | head  -3
  + 管道前的输出将作为管道后的输入

## VI编辑

+ 直接定位到某一行：vi +33 XXX
+ 在文本左侧显示行数：:set nu
+ 取消文本左侧显示行数：:set nonu
+ 打开文件
  + vim XXX
  + vim +n    打开文件，直接定位到第n行
  + vim  +      打开文件，定位到最后一行
  + vim  + /pattern  打开文件，定位到第一次被pattern匹配的位置
+ 关闭文件
  + :q  退出，没有修改过文件
  + :wq    保存并退出
  + :w!      不保存推出
  + :w       保存
  + :w!      强行保存
  + :wq      简写为    :x
  + ZZ      保存并退出
+ 几种模式的转换
  + 编辑——>输入
    + i：在当前光标所在字符的前面，转为输入模式
    + a：在当前光标所在字符的后面，转为输入模式
    + o：在当前光标所在行的下方，新建一行，并转为输入模式
    + O：在当前光标所在行的上方，新建一行，并转为输入模式
    + I：在当前光标所在行的行首，转换为输入模式
    + A：在当前光标所在行的行尾，转换为输入模式
  + 输入——>编辑
    + ESC
  + 末行——>编辑
    + ESC ，ESC



