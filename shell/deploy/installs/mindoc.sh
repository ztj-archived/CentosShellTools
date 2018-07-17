#!/bin/bash

###############
# Name: 安装 MinDoc
# author: ZhangTianJie
# email: ztj1993@gmail.com
###############

### 引入配置文件
source /data/shell/funs/loadConfigFile.sh softwares

### 命令行参数

### 变量定义
SoftwareUrl="https://github.com/lifei6671/mindoc/releases/download/v${MinDocVersion}/mindoc_linux_amd64.zip"
SoftwareName="mindoc_linux_amd64_${MinDocVersion}.zip"
SoftwarePackagePath="/data/backups/packages/${SoftwareName}"
SoftwareInstallPath="/data/bin/mindoc"
SoftwareConfigPath=""

### 判断软件是否已经安装
if [ -f "${SoftwareInstallPath}/mindoc" ]; then
    echo ">>>>> Error: the software has been installed"
    exit 1
fi

### 安装前置软件
/data/shell/funs/yumInstallSoftware.sh unzip
[ $? -ne 0 ] && exit 1

### 判断软件是否具备安装条件

### 安装软件
/data/shell/funs/wget.sh ${SoftwareUrl}
[ $? -ne 0 ] && exit 1
mkdir -p ${SoftwareInstallPath}
unzip ${SoftwarePackagePath} -d ${SoftwareInstallPath}

### 验证软件安装

### 配置系统

### 配置软件
# 修改 Session Key
# 注释所有的 db_
sed -i "s@^db_@#db_@" /data/bin/mindoc/conf/app.conf
# 启用 sqlite 数据库
sed -i "s@^#db_adapter=sqlite3@db_adapter=sqlite3@" /data/bin/mindoc/conf/app.conf
sed -i "s@^#db_database=./@db_database=./@" /data/bin/mindoc/conf/app.conf

### 设置开机启动项

### 其他处理

exit 0
