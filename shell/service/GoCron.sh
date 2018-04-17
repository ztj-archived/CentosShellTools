#!/bin/bash

###############
# Name: GoCron service management
# Params 1: start|stop|restart
# author: ZhangTianJie
# email: ztj1993@gmail.com
###############

### 定义脚本名称
ShellName="GoCron"

### 定义帮助文本
if [ "${1}" == "help" ] || [ "${1}" == "" ]; then
    echo ">>> params 1 <Command>(start|stop|restart)"
    exit
fi

### 定义变量
Command=${1}
ServiceBin="/data/bin/gocron/gocron"
ServiceLog="/data/logs/service/${ShellName}.`date +%Y-%m-%d-%H-%M-%S`.log"
Pid=`pgrep -f "./gocron web" | sed -n 2p`

### 判断变量
if [ ! -f "${ServiceBin}" ]; then
    echo ">>>>> Error: the var <ServiceBin> does not exist"
    exit 0
fi

### 定义方法
function start(){
    [ -n "${Pid}" ] && echo ">>>>> Warning: Service has been started" && return 1
    /bin/su - gocron -c "cd /data/bin/gocron && ./gocron web &" &> ${ServiceLog}
}
function stop(){
    [ -n "${Pid}" ] && kill -9 ${Pid} && Pid=""
}
function restart(){
    stop
    sleep 3
    start
}

### 执行方法
if [ "$(type -t ${Command})" = "function" ] ; then
    ${Command}
else
    echo ">>>>> Error: the var <Command> does not exist"
fi
