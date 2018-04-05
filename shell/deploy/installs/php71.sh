#!/bin/bash

###############
# Name: 安装 PHP 7.1
# author: ZhangTianJie
# email: ztj1993@gmail.com
###############

### 引入配置文件

### 命令行参数

### 变量定义

### 判断软件是否已经安装
php -v > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo ">>>>> Error: the software has been installed"
    exit 1
fi


### 安装前置软件
rpmSoftwareUrl="https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm"
rpmSoftwareName=$(basename ${rpmSoftwareUrl} .rpm)
/data/shell/funs/rpmInstallSoftware.sh ${rpmSoftwareName} ${rpmSoftwareUrl}
[ $? -ne 0 ] && exit 1
rpmSoftwareUrl="https://mirror.webtatic.com/yum/el7/webtatic-release.rpm"
rpmSoftwareName=$(basename ${rpmSoftwareUrl} .rpm)
/data/shell/funs/rpmInstallSoftware.sh ${rpmSoftwareName} ${rpmSoftwareUrl}
[ $? -ne 0 ] && exit 1

### 判断软件是否具备安装条件

### 安装软件
/data/shell/funs/yumInstallSoftware.sh php71w-common
[ $? -ne 0 ] && exit 1
/data/shell/funs/yumInstallSoftware.sh php71w-fpm
[ $? -ne 0 ] && exit 1
/data/shell/funs/yumInstallSoftware.sh php71w-cli
[ $? -ne 0 ] && exit 1
/data/shell/funs/yumInstallSoftware.sh mod_php71w
[ $? -ne 0 ] && exit 1
/data/shell/funs/yumInstallSoftware.sh php71w-mbstring
[ $? -ne 0 ] && exit 1
/data/shell/funs/yumInstallSoftware.sh php71w-mysqlnd
[ $? -ne 0 ] && exit 1
/data/shell/funs/yumInstallSoftware.sh php71w-mcrypt
[ $? -ne 0 ] && exit 1
/data/shell/funs/yumInstallSoftware.sh php71w-gd
[ $? -ne 0 ] && exit 1
/data/shell/funs/yumInstallSoftware.sh php71w-xml
[ $? -ne 0 ] && exit 1
/data/shell/funs/yumInstallSoftware.sh php71w-opcache
[ $? -ne 0 ] && exit 1

### 验证软件安装

### 配置系统
id -u www >/dev/null 2>&1
[ $? -ne 0 ] && useradd -M -s /sbin/nologin www

### 配置软件
chown -R www.www /var/lib/php/session
/data/shell/funs/backupPath.sh /etc/php-fpm.d/www.conf
sed -i "s@^listen = 127.0.0.1:9000@listen = /dev/shm/php-cgi.sock@" /etc/php-fpm.d/www.conf
sed -i "s@^;listen.owner = nobody@listen.owner = www@" /etc/php-fpm.d/www.conf
sed -i "s@^;listen.group = nobody@listen.group = www@" /etc/php-fpm.d/www.conf
sed -i "s@^;listen.mode = 0666@listen.mode = 0666@" /etc/php-fpm.d/www.conf
# 优化 PHP
/data/shell/funs/backupPath.sh /etc/php.ini
sed -i 's@^expose_php = On@expose_php = Off@' /etc/php.ini
sed -i 's@^request_order.*@request_order = "CGP"@' /etc/php.ini
sed -i 's@^;date.timezone.*@date.timezone = Asia/Shanghai@' /etc/php.ini
sed -i 's@^post_max_size.*@post_max_size = 100M@' /etc/php.ini
sed -i 's@^upload_max_filesize.*@upload_max_filesize = 50M@' /etc/php.ini
sed -i 's@^max_execution_time.*@max_execution_time = 10@' /etc/php.ini
sed -i 's@^;realpath_cache_size.*@realpath_cache_size = 2M@' /etc/php.ini
sed -i 's@^short_open_tag = Off@short_open_tag = On@' /etc/php.ini

### 设置开机启动项

### 其他处理
httpd -v > /dev/null 2>&1
[ $? -eq 0 ] && systemctl restart httpd.service

exit 0
