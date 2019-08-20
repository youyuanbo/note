#!/bin/bash
echo"=======================正在开启集群服务===================="

echo"=======================正在开启Zookeeper节点===================="
for i in xiaoyou@hive130 xiaoyou@hive131 xiaoyou@hive132
do
	ssh $i '/opt/modules/zookeeper-3.4.10/bin/zkServer.sh start'
done

echo"=======================正在开启NameNode===================="
ssh xiaoyou@hive130 '/opt/modules/hadoop-2.7.2/sbin/hadoop-daemon.sh start namenode'


echo"=======================正在开启DataNode===================="
for i in xiaoyou@hive130 xiaoyou@hive131 xiaoyou@hive132
do
	ssh $i '/opt/modules/hadoop-2.7.2/sbin/hadoop-daemon.sh start datanode'
done


echo"=======================正在开启SecondaryNameNode===================="
ssh xiaoyou@hive132 '/opt/modules/hadoop-2.7.2/sbin/hadoop-daemon.sh start secondarynamenode'


echo"=======================正在开启ResourceManager===================="
ssh xiaoyou@hive131 '/opt/modules/hadoop-2.7.2/sbin/yarn-daemon.sh start resourcemanager'


echo"=======================正在开启NodeManager===================="
for i in xiaoyou@hive130 xiaoyou@hive131 xiaoyou@hive132
do
	ssh $i '/opt/modules/hadoop-2.7.2/sbin/yarn-daemon.sh start nodemanager'
done


echo"=======================正在开启JobHistoryServer===================="
	ssh xiaoyou@hive130 '/opt/modules/hadoop-2.7.2/sbin/mr-jobhistory-daemon.sh start historyserver'
