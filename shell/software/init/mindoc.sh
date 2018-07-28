#!/bin/bash

###############
# Name: MinDoc 备份脚本
# author: ZhangTianJie
# email: ztj1993@gmail.com
###############

### 执行安装
${SoftwareBackupPath}/mindoc_linux_amd64 install

### 生成 Systemd 管理服务
ServicePath=/data/configs/systemd/${SoftwareAlias}.${ConfigAlias}.service
TplPath=/data/tpls/systemd/${SoftwareAlias}.tpl
TplContent=$(cat ${TplPath})
source /data/shell/source/tpl.sh
echo "${TplContent}" > ${ServicePath}
