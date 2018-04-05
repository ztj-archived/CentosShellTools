#!/bin/bash

###############
# Name: 设置 Root 用户密码
# author: ZhangTianJie
# email: ztj1993@gmail.com
###############

docker exec ${ContainerName} yum install passwd -y
echo root:${RootPwd} | docker exec -i ${ContainerName} chpasswd

