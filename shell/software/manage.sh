#!/bin/bash

###############
# Name: 软件管理脚本
# Params 1: <CommandAlias> 软件命令
# Params 2: <SoftwareAlias> 软件别名
# Params 3: <ConfigAlias> 配置别名
# author: ZhangTianJie
# email: ztj1993@gmail.com
###############

### 定义帮助文本
if [ "${1}" == "help" ] || [ "${1}" == "" ]; then
    echo ">>> params 1 <CommandAlias>[install|uninstall|upgrade|init|start|stop|restart|reload|backup|recovery]"
    echo ">>> params 2 <SoftwareAlias>"
    echo ">>> params 3 <ConfigAlias>"
    exit
fi

### 定义变量
CommandAlias=${1}
SoftwareAlias=${2}
ConfigAlias=${3}
Sign=""
DateTime=`date +%Y-%m-%d-%H-%M-%S`

### 处理变量
[ "${ConfigAlias}" == "" ] && ConfigAlias="default"
Sign="${CommandAlias}.${SoftwareAlias}.${ConfigAlias}"

### 判断变量
if [ ! -d "/data/shell/software/${CommandAlias}" ]; then
    echo ">>>>> Error: ${Sign} - the var <CommandAlias> does not exist"
    exit 0
fi
if [ ! -f "/data/shell/software/${CommandAlias}/${SoftwareAlias}.sh" ]; then
    echo ">>>>> Error: ${Sign} - the var <SoftwareAlias> does not exist"
    exit 0
fi
if [ ! -f "/data/configs/software/${SoftwareAlias}.${ConfigAlias}.conf" ]; then
    echo ">>>>> Error: ${Sign} - the var <ConfigAlias> does not exist"
    exit 0
fi

### 引入配置文件与命令脚本
echo ">>>>> Message: start exec ${Sign}"
source "/data/configs/software/${SoftwareAlias}.${ConfigAlias}.conf"
source "/data/shell/software/${CommandAlias}/${SoftwareAlias}.sh"
echo ">>>>> Message: end exec ${Sign}"
