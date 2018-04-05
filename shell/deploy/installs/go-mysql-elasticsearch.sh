#!/bin/bash

###############
# Name: 部署安装 go-mysql-elasticsearch
# author: ZhangTianJie
# email: ztj1993@gmail.com
###############

### 引入配置文件

### 命令行参数

### 变量定义
SoftwareUrl="github.com/siddontang/go-mysql-elasticsearch"
GoPath="/data/bin/go"
SoftwareInstallPath="${GoPath}/src/github.com/siddontang/go-mysql-elasticsearch"

### 判断软件是否已经安装
if [ -d "${SoftwareInstallPath}" ]; then
    echo ">>>>> Error: the software has been installed"
    exit 1
fi

### 安装前置软件
/data/shell/funs/yumInstallSoftware.sh go
[ $? -ne 0 ] && exit 1
/data/shell/funs/yumInstallSoftware.sh git
[ $? -ne 0 ] && exit 1

### 判断软件是否具备安装条件

### 安装软件
export GOPATH="${GoPath}"
go get ${SoftwareUrl}
cd ${SoftwareInstallPath} && make

### 验证软件安装

### 配置系统

### 配置软件

### 设置开机启动项

### 其他处理

exit 0
