#!/bin/bash

###############
### 加载配置文件
###############

### 设置变量
File="/data/shell/config/${1}.conf"
DefaultFile="/data/shell/config/${1}.default.conf"
### 判断目标路径是否存在
if [ ! -f "${File}" ] && [ ! -f "${DefaultFile}" ]; then
    echo ">>> Error: config file does not exist"
    exit 1
fi
### 加载文件
if [ -f "${File}" ]; then
    source ${File}
else
    source ${DefaultFile}
fi

