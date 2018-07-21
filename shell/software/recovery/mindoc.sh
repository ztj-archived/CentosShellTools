#!/bin/bash

###############
# Name: MinDoc 恢复脚本
# author: ZhangTianJie
# email: ztj1993@gmail.com
###############

### 定义变量
BackupPath="${SoftwareBackupPath}/${SoftwareAlias}.${ConfigAlias}.backup"

### 定义批量复制路径
BatchCopyPaths=(
    "${BackupPath}/mindoc.db=>${SoftwareInstallPath}/database/mindoc.db"
    "${BackupPath}/app.conf=>${SoftwareInstallPath}/conf/app.conf"
    "${BackupPath}/uploads=>${SoftwareInstallPath}/uploads"
)

### 复制文件
source /data/shell/funs/batchCopy.sh
