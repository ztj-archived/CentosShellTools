#!/bin/bash

###############
# Name: 站点部署脚本示例文件
# author: ZhangTianJie
# email: ztj1993@gmail.com
###############

### 定义站点变量
SiteSign="sitewww"
SiteRootPath="/data/wwwroot/site/www"
ServerName="www.site.com"
ServerAlias="site.com"
MainDomain="www.site.com"

### 创建站点
/data/shell/funs/createNginxApacheSite.sh ${SiteSign} ${SiteRootPath} ${ServerName} "${ServerAlias}" ${MainDomain}

### 定义数据库变量
DbUserName="site"
DbUserPwd="site123"
DbUserHost="localhost"

### 创建数据库用户
/data/shell/funs/createMysqlUser.sh ${DbUserName} ${DbUserPwd} ${DbUserHost}

### 设置数据库权限：支持主从
/data/shell/funs/execSql.sh "GRANT RELOAD, REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO '${DbUserName}'@'${DbUserHost}';"

### 创建指定数据库
/data/shell/funs/execSql.sh "CREATE DATABASE IF NOT EXISTS \`${DbUserName}_www\`;"

exit 0
