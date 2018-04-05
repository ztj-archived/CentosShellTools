#!/bin/bash

#
# 数据库压缩恢复
#

if [ "${1}" == "help" ]; then
    echo "本脚本有【二】个参数，分别为：【要恢复的数据库名】，【备份文件的路径】"
    exit
fi
if [ "${1}" == "" ]; then
    echo ">>>>> Error: 请输入【要恢复的数据库名】"
    exit
fi
if [ "${2}" == "" ]; then
    echo ">>>>> Error: 请输入【备份文件的路径】"
    exit
fi

#判断数据库文件是否存在
if [ ! -f "${2}" ]; then
    echo ">>>>> Error: 【备份文件的路径】不存在，请检查"
    exit
fi

#引入数据库配置文件
source /data/shell/funs/loadConfigFile.sh mysql

#导入数据库文件
gunzip < ${2} | mysql --host=${db_host} --port=${db_port} \
    --user=${db_root_user} --password=${db_root_pass} \
    --database=${1}
