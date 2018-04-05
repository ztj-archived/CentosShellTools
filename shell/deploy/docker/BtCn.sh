#!/bin/bash

###############
# Name: 宝塔面板容器部署
# author: ZhangTianJie
# email: ztj1993@gmail.com
###############

### 定义变量
ContainerName="BtCn"
BindIp="172.18.0.2"
RootPwd="123456"

### 创建容器
source /data/shell/deploy/docker/common/Create.sh
### 开启 SSH
source /data/shell/deploy/docker/common/OpenSSH.sh
### 设置 root 密码
source /data/shell/deploy/docker/common/SetRootPwd.sh
### 安装
docker exec ${ContainerName} yum install -y wget
docker exec ${ContainerName} wget -O install.sh http://download.bt.cn/install/install.sh
echo y | docker exec -i ${ContainerName} sh install.sh
### 配置开机启动项
docker exec ${ContainerName} chmod +x /etc/rc.d/rc.local
docker exec ${ContainerName} echo "/etc/init.d/bt start" >> /etc/rc.d/rc.local
### 重启容器
docker reset ${ContainerName}
