#!/bin/bash

###############
# Name: 安装 MySQL 5.7
# author: ZhangTianJie
# email: ztj1993@gmail.com
###############

### 引入配置文件
source /data/shell/funs/loadConfigFile.sh mysql

### 命令行参数

### 变量定义
rpmSoftwareUrl="https://dev.mysql.com/get/mysql57-community-release-el7-9.noarch.rpm"
rpmSoftwareName=$(basename ${rpmSoftwareUrl} .rpm)
SoftwarePwd="${db_root_pass}"

### 判断软件是否已经安装
mysql -V > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo ">>>>> Error: the software has been installed"
    exit 1
fi


### 安装前置软件
/data/shell/funs/rpmInstallSoftware.sh ${rpmSoftwareName} ${rpmSoftwareUrl}
[ $? -ne 0 ] && exit 1

### 判断软件是否具备安装条件

### 安装软件
/data/shell/funs/yumInstallSoftware.sh mysql-community-server
[ $? -ne 0 ] && exit 1
systemctl start mysqld.service
if [ $? -ne 0 ]; then
    echo ">>>>> Error: software install error"
    exit 1
fi

### 验证软件安装

### 配置系统

### 配置软件
/data/shell/funs/pathBackup.sh /etc/my.cnf
grep "sql_mode=" /etc/my.cnf > /dev/null
[ $? -ne 0 ] && echo -e "sql_mode=" >> /etc/my.cnf
grep "server-id=1" /etc/my.cnf > /dev/null
[ $? -ne 0 ] && echo -e "server-id=1" >> /etc/my.cnf
grep "log-bin=mysql-bin" /etc/my.cnf > /dev/null
[ $? -ne 0 ] && echo -e "log-bin=mysql-bin" >> /etc/my.cnf
grep "validate_password=off" /etc/my.cnf > /dev/null
[ $? -ne 0 ] && echo -e "validate_password=off" >> /etc/my.cnf
grep "group_concat_max_len" /etc/my.cnf > /dev/null
[ $? -ne 0 ] && echo -e "group_concat_max_len = 102400" >> /etc/my.cnf

# 获取初始密码
defaultmysqlpwd=`grep 'A temporary password' /var/log/mysqld.log | awk -F"root@localhost: " 'END{ print $2}'`
echo ">>>>> message: MySQL default password:${defaultmysqlpwd}"
# 更改密码与全局设置
mysqladmin --user=root --password=${defaultmysqlpwd} password ${SoftwarePwd}
mysql --host=localhost --port=3306 --user=root --password=${SoftwarePwd} -e "set global validate_password_policy=0;"
mysql --host=localhost --port=3306 --user=root --password=${SoftwarePwd} -e "set global validate_password_length=4;"

### 设置开机启动项
systemctl enable mysqld.service

### 其他处理
yum remove ${rpmSoftwareName} -y &>> /dev/null

exit 0
