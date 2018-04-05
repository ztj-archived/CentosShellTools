#!/bin/bash

#
# 数据库压缩备份
#

if [ "${1}" == "help" ]; then
    echo "本脚本有【二】个参数，分别为：【要备份的数据库名】，【放置备份文件的路径】"
    exit
fi
if [ "${1}" == "" ]; then
    echo ">>>>> Error: 请输入【要备份的数据库名】"
    exit
fi
if [ "${2}" == "" ]; then
    echo ">>>>> Error: 请输入【放置备份文件的路径】"
    exit
fi

#获取当前系统时间
datetime=`date +%Y-%m-%d-%H-%M-%S`

#引入数据库配置文件
source /data/shell/funs/loadConfigFile.sh mysql

#备份数据库
mysqldump --host="${db_host}" --port="${db_port}" \
    --user="${db_root_user}" --password="${db_root_pass}" \
    "${1}" | gzip > "${2}/${1}.${datetime}.sql.gz"
