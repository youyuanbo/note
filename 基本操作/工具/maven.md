# Maven学习

# Maven简介

1. pom

   Project Object Model

2. Maven仓库：http://mavenrepository.com


## Maven配置

1. 修改conf文件夹下的setting文件，在settings标签下添加本地仓库路径

   ```xml
   <localRepository>F://development_jar/maven_repository</localRepository>
   ```

2. 配置仓库镜像

   ```xml
   <mirrors>
         <mirror>
             <id>alimaven</id>
             <name>aliyun maven</name>
             <url>http://maven.aliyun.com/nexus/content/groups/public/</url>
             <mirrorOf>central</mirrorOf>
         </mirror>
   ```

3. 、

## pom组成

1. groupId：组织名称，一般为公司域名的倒写
2. artifactId：项目，模块名称
3. version：版本号
4. name：项目名
5. properties：属性的定义
6. dependencies：依赖

## Maven项目的文件组成

1. java：存放所有的Java源代码
2. resources：存放资源文件（log4j.properties）,在java和test文件夹中都存在resources文件夹
3. test：测试程序