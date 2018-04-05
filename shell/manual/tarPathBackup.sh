#!/bin/bash

#
# 路径压缩备份
#

if [ "${1}" == "help" ]; then
    echo "本脚本有【三】个参数，分别为：【备份的路径】，【放置备份的路径】，【文件别名】"
    exit
fi
if [ "${1}" == "" ]; then
    echo ">>>>> Error: 请输入【要备份的路径】"
    exit
fi
if [ "${2}" == "" ]; then
    echo ">>>>> Error: 请输入【放置备份的路径】"
    exit
fi
if [ "${3}" == "" ]; then
    echo ">>>>> Error: 请输入【文件别名】"
    exit
fi

#获取当前系统时间
datetime=`date +%Y-%m-%d-%H-%M-%S`

#判断文件目录是否存在
if [ ! -d "${1}" ]; then
    echo ">>>>> Error: 【要备份的路径】不存在，请检查"
    exit
fi
if [ ! -d "${2}" ]; then
    echo ">>>>> Error: 【放置备份的路径】不存在，请检查"
    exit
fi

#备份网站文件
tar cpPfz "${2}/${3}.${datetime}.tar.gz" -C "${1}" "."

echo ">>>>> Success: 备份路径成功，${3}.${datetime}.tar.gz"
