#!/bin/bash

###############
# Name: 初始化部署
# author: ZhangTianJie
# email: ztj1993@gmail.com
###############

### 判断软件目录是否存在
if [ -d "/data" ]; then
    echo ">>>>> Error: the /data directory already exists"
    exit 1
fi

### 安装软件
yum -y install git

### 定义变量
GitRepos="https://github.com/ztj1993/CentosShellTools.git"

### 配置系统
git config --global user.email "empty@empty"
git config --global user.name "empty"
git config --global core.autocrlf false
git config --global core.safecrlf true
git config --global core.filemode false

### 克隆文件
mkdir -p /data
git clone ${GitRepos} /data
chmod -R 700 /data/shell

exit 0
