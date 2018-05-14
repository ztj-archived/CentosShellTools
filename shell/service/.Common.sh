#!/bin/bash

###############
# Name: ServiceBin service common management
# Params 1: start|stop|restart|daemon_start|daemon_stop
# author: ZhangTianJie
# email: ztj1993@gmail.com
###############

### 定义帮助文本
if [ "${1}" == "help" ] || [ "${1}" == "" ]; then
    echo ">>> params 1 <Command>(start|stop|restart|daemon_start|daemon_stop)"
    exit
fi

### 判断变量是否存在
if [ "${ServiceName}" == "" ] || [ "${ServiceBin}" == "" ] || [ "${ServiceUser}" == "" ]; then
    echo ">>>>> Error: the var <ServiceName|ServiceBin|ServiceUser> does not exist"
    exit
fi

### 定义变量
Command=${1}
ServiceLog="/data/logs/service/${ServiceName}.`date +%Y-%m-%d-%H-%M-%S`.log"
PidGetCommand="ps aux | grep -w ${ServiceBin} | grep -v bash | grep -v grep | grep -v daemon | awk '{print $2}'"
Pid=`eval ${PidGetCommand}`
DaemonShell="/data/shell/funs/daemon.sh"

### 判断变量
if [ ! -f "${ServiceBin}" ]; then
    echo ">>>>> Error: the var <ServiceBin> does not exist"
    exit 0
fi

### 定义方法
function start(){
    [ -n "${Pid}" ] && echo ">>>>> Warning: Service has been started" && return 1
    /bin/su - "${ServiceUser}" -c "${ServiceBin} &" &> ${ServiceLog}
}
function stop(){
    [ -n "${Pid}" ] && kill -9 ${Pid} > /dev/null 2>&1
}
function restart(){
    stop
    sleep 3
    start
}
function daemon_start(){
    [ -n "${Pid}" ] && echo ">>>>> Warning: Service has been started" && return 1
    ${0} start
    /bin/su - "${ServiceUser}" -c "nohup ${DaemonShell} \"${PidGetCommand}\" \"${0} start\" &" &> /dev/null 2>&1
}
function daemon_stop(){
    Tmp=`ps aux | grep -w ${ServiceBin} | grep -w daemon | awk '{print $2}' | sed -n 1p`
    [ -n "${Tmp}" ] && kill -9 ${Tmp} > /dev/null 2>&1
    ${0} stop
}

### 执行方法
if [ "$(type -t ${Command})" = "function" ] ; then
    ${Command}
else
    echo ">>>>> Error: the var <Command> does not exist"
fi
