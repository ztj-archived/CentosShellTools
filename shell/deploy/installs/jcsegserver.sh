#!/bin/bash

###############
# Name: 安装 JcsegServer
# author: ZhangTianJie
# email: ztj1993@gmail.com
###############

### 引入配置文件

### 命令行参数

### 变量定义
SoftwareVersion="2.2.0"
SoftwareUrl="http://search.maven.org/remotecontent?filepath=org/lionsoul/jcseg-server/${SoftwareVersion}/jcseg-server-${SoftwareVersion}.jar"
SoftwareName=${SoftwareUrl##*/}
SoftwarePackagePath="/data/backups/softwares/${SoftwareName}"
SoftwareInstallPath="/data/bin/jcseg-server/jcseg-server.jar"

### 判断软件是否已经安装
if [ -f "/data/bin/jcseg-server/jcseg-server.jar" ]; then
    echo ">>>>> Error: the software has been installed"
    exit 1
fi

### 安装前置软件
/data/shell/funs/yumInstallSoftware.sh java
[ $? -ne 0 ] && exit 1

### 判断软件是否具备安装条件

### 安装软件
/data/shell/funs/wget.sh ${SoftwareUrl}
[ $? -ne 0 ] && exit 1
mkdir -p `dirname ${SoftwareInstallPath}`
cp ${SoftwarePackagePath} ${SoftwareInstallPath}

### 验证软件安装


### 配置系统

### 配置软件

### 设置开机启动项

### 其他处理

exit 0
