#!/bin/bash
echo"=======================正在关闭集群服务===================="

echo"=======================正在关闭JobHistoryServer===================="
	ssh xiaoyou@hive130 '/opt/modules/hadoop-2.7.2/sbin/mr-jobhistory-daemon.sh stop historyserver'

echo"=======================正在关闭ResourceManager===================="
	ssh xiaoyou@hive131 '/opt/modules/hadoop-2.7.2/sbin/yarn-daemon.sh stop resourcemanager'


echo"=======================正在关闭NodeManager===================="
for i in xiaoyou@hive130 xiaoyou@hive131 xiaoyou@hive132
do
	ssh $i '/opt/modules/hadoop-2.7.2/sbin/yarn-daemon.sh stop nodemanager'
done

echo"=======================正在关闭NameNode===================="
	ssh xiaoyou@hive130 '/opt/modules/hadoop-2.7.2/sbin/hadoop-daemon.sh stop namenode'

echo"=======================正在关闭SecondaryNameNode===================="
	ssh xiaoyou@hive132 '/opt/modules/hadoop-2.7.2/sbin/hadoop-daemon.sh stop secondarynamenode'

echo"=======================正在关闭DataNode===================="
for i in xiaoyou@hive130 xiaoyou@hive131 xiaoyou@hive132
do
	ssh $i '/opt/modules/hadoop-2.7.2/sbin/hadoop-daemon.sh stop datanode'
done


echo"=======================正在关闭Zookeeper节点===================="
for i in xiaoyou@hive130 xiaoyou@hive131 xiaoyou@hive132
do
	ssh $i '/opt/modules/zookeeper-3.4.10/bin/zkServer.sh stop'
done



