#!/bin/bash

###############
# Name: MinDoc 备份脚本
# author: ZhangTianJie
# email: ztj1993@gmail.com
###############

### 定义变量
BackupPath="${SoftwareBackupPath}/${SoftwareAlias}.${ConfigAlias}.backup.${DateTime}"

### 创建备份目录
mkdir -p "${BackupPath}"

### 定义批量复制路径
BatchCopyPaths=(
    "${SoftwareInstallPath}/database/mindoc.db=>${BackupPath}/mindoc.db"
    "${SoftwareInstallPath}/conf/app.conf=>${BackupPath}/app.conf"
    "${SoftwareInstallPath}/uploads=>${BackupPath}/uploads"
)

### 复制文件
source /data/shell/funs/batchCopy.sh
