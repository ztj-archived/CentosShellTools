#!/bin/bash

###############
### 恢复原始路径
### recoveryOriginalPath 原始路径 备份的路径
###############

### 设置变量
originalPath="${1}"
originalName=`basename "${1}"`
targetPath="${2}"
### 变量是否设置
if [ ! -n "${originalPath}" ]; then
    echo ">>> Error: original path does not set"
    exit 1
fi
if [ ! -n "${targetPath}" ]; then
    targetPath="${originalPath}"
else
    targetPath="${targetPath}/${originalName}"
fi
### 原始文件路径是否存在
if [ ! -f "${targetPath}.bak" ] && [ ! -d "${targetPath}.bak" ]; then
    echo ">>> Error: original path does not exist"
    exit 1
fi
### 恢复原始路径
\cp -fR "${targetPath}.bak" "${originalPath}"
### 判断命令是否存在异常
if [ $? -ne 0 ];then
    echo ">>> Error: recovery original path fail"
    exit 1
fi
exit 0
