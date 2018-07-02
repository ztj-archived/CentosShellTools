#!/bin/bash

###############
# Name: 数据库压缩包恢复
# author: ZhangTianJie
# email: ztj1993@gmail.com
###############

### 定义帮助文本
if [ "${1}" == "help" ] || [ "${1}" == "" ]; then
    echo ">>> params 1 <DbName>"
    echo ">>> params 2 <FilePath>"
    exit
fi

### 设置变量
DbName="${1}"
FilePath="${2}"

### 判断变量
if [ "${DbName}" == "" ]; then
    echo ">>>>> Error: the var <DbName> does not exist"
    exit 0
fi
if [ "${FilePath}" == "" ]; then
    echo ">>>>> Error: the var <FilePath> does not exist"
    exit 0
fi

#判断数据库文件是否存在
if [ ! -f "${FilePath}" ]; then
    echo ">>>>> Error: the <FilePath> does not exist"
    exit 0
fi

#引入数据库配置文件
source /data/shell/funs/loadConfigFile.sh mysql

#导入数据库文件
gunzip < ${FilePath} | mysql --host=${db_host} --port=${db_port} \
    --user=${db_root_user} --password=${db_root_pass} \
    --database=${DbName}
