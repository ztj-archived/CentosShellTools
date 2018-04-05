#!/bin/bash

###############
# Name: 创建容器
# author: ZhangTianJie
# email: ztj1993@gmail.com
###############

docker run -itd -e "container=docker" \
    --net mydocker \
    --ip ${BindIp} \
    --privileged=true \
    --volume /sys/fs/cgroup:/sys/fs/cgroup \
    --name ${ContainerName} centos /usr/sbin/init
