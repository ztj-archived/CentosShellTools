#!/bin/bash

###############
# Name: 更新系统
# author: ZhangTianJie
# email: ztj1993@gmail.com
###############

yum clean all &&
yum makecache &&
yum update

exit 0
