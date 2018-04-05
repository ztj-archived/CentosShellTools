#!/bin/bash

###############
# Name: Gogs 数据初始化
# Params 1: <TarPath>(FilePath)
# author: ZhangTianJie
# email: ztj1993@gmail.com
###############

### 引入配置文件

### 命令行参数
if [ "${1}" == "help" ] || [ "${1}" == "" ]; then
    echo ">>> Params 1 <TarPath>(FilePath)"
    exit
fi

### 变量定义
TarPath=${1}

### 判断软件是否已经安装
if [ -d "/data/bin/gogs/data" ]; then
    echo ">>>>> Error: gogs data has already existed"
    exit 0
fi

### 安装前置软件

### 判断软件是否具备安装条件
if [ ! -f "/data/bin/gogs/gogs" ]; then
    echo ">>>>> Error: gogs software is not installed"
    exit 1
fi
if [ ! -f "${TarPath}" ]; then
    echo ">>>>> Error: gogs data file does not exist"
    return 0
fi

### 安装软件
mkdir -p /data/bin/gogs/data
tar -xf ${TarPath} -C /data/bin/gogs/data
chown -R git.git /data/bin/gogs/data

### 验证软件安装

### 配置系统

### 配置软件
mkdir /home/git/.ssh
cp -rf /data/bin/gogs/data/ssh/authorized_keys /home/git/.ssh/authorized_keys
chown -R git.git /home/git/.ssh
chmod 600 home/git/.ssh/authorized_keys
chmod 700 home/git/.ssh

### 设置开机启动项

### 其他处理

exit 0
