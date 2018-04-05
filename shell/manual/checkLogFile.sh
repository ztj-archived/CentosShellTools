#!/bin/bash

###############
### 检查日志文件
###############

LogFile="${1}"

if [ ! -f "${LogFile}" ]; then
     echo ">>>>> Error: log file does not exist, Please check!"
     exit 1
fi

echo -e "\033[34m `cat "${LogFile}"  | grep 'warn'` \033[0m"
echo -e "\033[34m `cat "${LogFile}"  | grep 'Warn'` \033[0m"
echo -e "\033[31m `cat "${LogFile}"  | grep 'erro'` \033[0m"
echo -e "\033[31m `cat "${LogFile}"  | grep 'Erro'` \033[0m"

exit 0
