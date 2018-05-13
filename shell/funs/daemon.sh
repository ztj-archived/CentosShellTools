#!/bin/bash

###############
# Name: 守护进程脚本
# Params 1: 获取进程编号命令
# Params 2: 启动命令
# author: ZhangTianJie
# email: ztj1993@gmail.com
###############

### 定义帮助文本
if [ "${1}" == "help" ] || [ "${1}" == "" ]; then
    echo ">>> params 1 <CommandPid>"
    echo ">>> params 2 <CommandStart>"
    exit
fi

### 设置变量
CommandPid="${1}"
CommandStart="${2}"
ExecNum=1
LogFile="/data/logs/daemon.log"

### 判断变量
if [ ! -n "${CommandPid}" ]; then
    echo ">>> Error: param <CommandPid(1)> does not set"
    exit 1
fi
if [ ! -n "${CommandStart}" ]; then
    echo ">>> Error: param <CommandStart(2)> does not set"
    exit 1
fi

### 判断获取进程编号命令是否有效
Pid=`eval ${CommandPid}`
if [ "${Pid}" == "" ]; then
    echo ">>> Error: param <CommandPid(1)> is invalid"
    exit 1
fi

### 执行进程守护
while [[ ${ExecNum} < 5 ]];
do
    Pid=`eval ${CommandPid}`
    if [ "${Pid}" == "" ]; then
        echo -e "`date "+%Y-%m-%d %H:%M:%S"`\n${CommandPid}\n${CommandStart}\n${ExecNum}\n\n" >> ${LogFile}
        ${CommandStart}
        ExecNum=$[${ExecNum} + 1]
    fi
done
exit 0
