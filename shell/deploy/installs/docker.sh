#!/bin/bash

###############
# Name: docker 联网部署
# author: ZhangTianJie
# email: ztj1993@gmail.com
###############

### 引入配置文件
source /data/shell/funs/loadConfigFile.sh softwares

### 命令行参数

### 变量定义
AliyunMirror="${DockerAliyunMirror}"

### 判断软件是否已经安装
docker -v > /dev/null 2>&1
[ $? -eq 0 ] && echo ">>>>> Error: The software has been installed" && exit 1

### 安装前置软件
rm -rf /etc/yum.repos.d/docker-ce.repo
/data/shell/funs/wget.sh https://download.docker.com/linux/centos/docker-ce.repo
[ $? -ne 0 ] && exit 1
cp -rf /data/backups/packages/docker-ce.repo /etc/yum.repos.d/docker-ce.repo

### 判断软件是否具备安装条件

### 安装软件
/data/shell/funs/yumInstallSoftware.sh docker-ce
[ $? -ne 0 ] && echo ">>>>> Error: software install error" && exit 1

### 验证软件安装
docker -v > /dev/null 2>&1
[ $? -ne 0 ] && echo ">>>>> Error: software install fail" && exit 1

### 配置系统

### 配置软件
mkdir -p /etc/docker
cat > /etc/docker/daemon.json <<EOF
{
  "registry-mirrors": ["${AliyunMirror}"]
}
EOF
# 创建自定义网络
systemctl start docker.service
docker network create --subnet=172.18.0.0/16 mydocker

### 设置开机启动项
systemctl daemon-reload
systemctl enable docker.service

### 其他处理
rm -rf /etc/yum.repos.d/docker-ce.repo

exit 0
