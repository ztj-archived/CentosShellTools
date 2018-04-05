#!/bin/bash

#
# 路径压缩恢复
#

if [ "${1}" == "help" ]; then
    echo "本脚本有【二】个参数，分别为：【压缩包路径】，【恢复目录】"
    exit
fi
if [ "${1}" == "" ]; then
    echo ">>>>> Error: 请输入【压缩包路径】"
    exit
fi
if [ "${2}" == "" ]; then
    echo ">>>>> Error: 请输入【恢复目录】"
    exit
fi

#判断压缩包是否存在
if [ ! -f "${1}" ]; then
    echo ">>>>> Error: 【压缩包】不存在，请检查"
    exit
fi

#创建目录
mkdir -p "${2}"

#解压文件
tar -xzf "${1}" -C "${2}"
