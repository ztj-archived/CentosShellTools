[Unit]
Description=<%=${SoftwareAlias}.${ConfigAlias}=%>
After=mariadb.service mysqld.service memcached.service redis.service

[Service]
Type=simple
User=root
Group=root
WorkingDirectory=<%=${SoftwareInstallPath}=%>
ExecStart=<%=${SoftwareInstallPath}=%>/mindoc_linux_amd64
Restart=always

[Install]
WantedBy=multi-user.target
