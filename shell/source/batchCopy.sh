#!/bin/bash

###############
# Name: 批量复制文件
# Params: <BatchCopyPaths> 复制的路径, TargetPath=OriginalPath
# author: ZhangTianJie
# email: ztj1993@gmail.com
###############

### 使用示例
# declare -A BatchCopyPaths
# BatchCopyPaths=(["${TargetPath}"]="${OriginalPath}")

### 判断是否定义了路径
if [ "${BatchCopyPaths[*]}" == "" ]; then
    echo ">>>>> Error: var {BatchCopyPaths} does not exist"
    exit 1
fi

### 循环数组
for TargetPath in ${!BatchCopyPaths[@]}
do
    ### 复制文件
    \cp -fR "${BatchCopyPaths[${TargetPath}]}" "${TargetPath}"
    [ $? -ne 0 ] && echo ">>>>> Error: copy path error" && exit 1
done
