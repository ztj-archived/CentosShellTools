#!/bin/bash

###############
# Name: MinDoc 安装脚本
# author: ZhangTianJie
# email: ztj1993@gmail.com
###############

### 判断软件是否已经安装
if [ -f "${SoftwareInstallPath}" ] || [ -d "${SoftwareInstallPath}" ]; then
    echo ">>>>> Error: ${Sign} - the software has been installed"
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
/data/shell/funs/pathBackup.sh ${SoftwareInstallPath}/conf/app.conf
# 绑定地址
sed -i "s@# httpaddr = 127.0.0.1@httpaddr=${httpaddr}" ${SoftwareInstallPath}/conf/app.conf
# 绑定端口
sed -i "s@httpport = 8181@httpport=${httpport}" ${SoftwareInstallPath}/conf/app.conf
# 修改 Session Key
sed -i "s@^beegoserversessionkey@#beegoserversessionkey=${sessionkey}@" ${SoftwareInstallPath}/conf/app.conf
# 启用 sqlite 数据库
sed -i "s@^db_@#db_@" ${SoftwareInstallPath}/conf/app.conf
sed -i "s@^#db_adapter=sqlite3@db_adapter=sqlite3@" ${SoftwareInstallPath}/conf/app.conf
sed -i "s@^#db_database=./@db_database=./@" ${SoftwareInstallPath}/conf/app.conf

### 设置开机启动项

### 其他处理
