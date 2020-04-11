#!/bin/bash

cd ~/cisco-conf-log
#
echo '''
# Update with Server IP or Leaves as is if you want to automatically select the Server IP.
SERVER_IP = "0.0.0.0"

# Update the port you want to server to listen on or leave as is to use the below port.
SERVER_PORT = 10000

# Must Update with your Webex Webhook Link
WEBEX_WEBHOOK = ""

# Must Update with your users on the Ubuntu Server this is being installed on.
ubuntu_user = ''

# Must Update with a valid Cisco Users Credential in order to download config and do other tasks.
cisco_password = ''
cisco_username = ''

# Do not modify
FILE_PATH = "/home/{user}/cisco-conf-log/conf_bk/config_backups".format(user=ubuntu_user)
''' > ~/cisco-conf-log/env_variables.py
#
apt-get update
#
#
apt-get install python3
#
#
apt-get install python3-pip
#
$(which python3) -m pip install --upgrade pip
#
apt-get install build-essential
#
#
apt-get install libsystemd-dev
#
#
/usr/bin/pip3 install -r ~/cisco-conf-log/requirements.txt --user
#
#
cp -r ~/cisco-conf-log /opt/
#
#
touch /etc/systemd/system/cisco-conf-log.service
#

#
echo "
[Unit]
Description=cisco-conf-log Service
After=network.target

[Service]
Type=simple
ExecStart=/usr/bin/python3 /opt/cisco-conf-log/logger/main.py

[Install]
WantedBy=multi-user.target
" > /etc/systemd/system/cisco-conf-log.service
#
systemctl start cisco-conf-log
#
systemctl enable cisco-conf-log
#
#
echo "Logger Service has been installed"
#
echo "Installing Configuration Backup"
#
cp ~/cisco-conf-log/schedules.yml ~/cisco-conf-log/conf_bk/schedules.yml
#
cp ~/cisco-conf-log/env_variables.py ~/cisco-conf-log/conf_bk/env_variables.py
#
cp ~/cisco-conf-log/env_variables.py ~/cisco-conf-log/logger/env_variables.py
#
$(which python3) ~/cisco-conf-log/conf_bk/setup.py
#
echo "Configuration Backup Installed"
#