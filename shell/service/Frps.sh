#!/bin/bash

###############
# Name: Frps service management
# Params 1: start|stop|restart
# Params 2: config file path
# author: ZhangTianJie
# email: ztj1993@gmail.com
###############

### 定义脚本名称
ShellName="Frps"

### 定义帮助文本
if [ "${1}" == "help" ] || [ "${1}" == "" ]; then
    echo ">>> params 1 <Command>(start|stop|restart)"
    echo ">>> params 2 <ServiceConfig>(FilePath)"
    exit
fi

### 定义变量
Command="${1}"
ServiceConfig="${2}"
ServiceBin="/data/bin/frp/frps"
ServiceDefaultConfig="/data/configs/frp/frps.ini"
ServiceLog="/data/logs/service/${ShellName}.`date +%Y-%m-%d-%H-%M-%S`.log"

### 判断变量
if [ ! -f "${ServiceBin}" ]; then
    echo ">>>>> Error: the var <ServiceBin> does not exist"
    exit 0
fi
if [ "${ServiceConfig}" == "" ]; then
    ServiceConfig="${ServiceDefaultConfig}"
fi
if [ ! -f "${ServiceConfig}" ]; then
    echo ">>>>> Error: the var <ServiceConfig> does not exist"
    exit 0
fi

### 定义方法
function start(){
    Pid=`pgrep -f "${ServiceConfig}"`
    [ -n "${Pid}" ] && echo ">>>>> Warning: Service has been started" && return 1
    /bin/su - root -c "${ServiceBin} -c ${ServiceConfig} &" &> ${ServiceLog}
}
function stop(){
    Pid=`pgrep -f "${ServiceConfig}"`
    [ -n "${Pid}" ] && kill -9 ${Pid}
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
