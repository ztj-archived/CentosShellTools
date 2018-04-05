#!/bin/bash

###############
# Name: docker container management
# Params 1: start|stop|restart|uninstall|exec
# Params 2: container name
# author: ZhangTianJie
# email: ztj1993@gmail.com
###############

### 定义脚本名称
ShellName="DockerContainer"

### 定义帮助文本
if [ "${1}" == "help" ] || [ "${1}" == "" ]; then
    echo ">>> params 1 <Command>(start|stop|restart|uninstall|exec)"
    echo ">>> params 2 <ContainerName>(String)"
    exit
fi

### 定义变量
Command="${1}"
ContainerName="${2}"

### 判断变量

### 定义方法
function uninstall(){
    docker stop ${ContainerName}
    docker rm ${ContainerName}
}
function start(){
    docker start ${ContainerName}
}
function stop(){
    docker stop ${ContainerName}
}
function restart(){
    docker restart ${ContainerName}
}
function exec(){
    docker exec -it ${ContainerName} /bin/bash
}

### 执行方法
if [ "$(type -t ${Command})" = "function" ] ; then
    ${Command}
else
    echo ">>>>> Error: the var <Command> does not exist"
fi
