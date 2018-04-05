#!/bin/bash

###############
# Name: 测试容器部署
# author: ZhangTianJie
# email: ztj1993@gmail.com
###############

### 定义变量
ContainerName="Test"
BindIp="172.18.0.9"
RootPwd="123456"

### 创建容器
source /data/shell/deploy/docker/common/Create.sh
### 开启 SSH
source /data/shell/deploy/docker/common/OpenSSH.sh
### 设置 root 密码
source /data/shell/deploy/docker/common/SetRootPwd.sh
### 重启容器
docker restart ${ContainerName}
