#!/bin/bash

cd ~/py_logger
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
FILE_PATH = "/home/{user}/py_logger/conf_bk/config_backups".format(user=ubuntu_user)
''' > ~/py_logger/env_variables.py
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
/usr/bin/pip3 install -r ~/py_logger/requirements.txt --user
#
#
cp -r ~/py_logger /opt/
#
#
touch /etc/systemd/system/py_logger.service
#

#
echo "
[Unit]
Description=Py_Logger Service
After=network.target

[Service]
Type=simple
ExecStart=/usr/bin/python3 /opt/py_logger/logger/main.py

[Install]
WantedBy=multi-user.target
" > /etc/systemd/system/py_logger.service
#
systemctl start py_logger
#
systemctl enable py_logger
#
#
echo "Logger Service has been installed"
#
echo "Installing Configuration Backup"
#
cp ~/py_logger/schedules.yml ~/py_logger/conf_bk/schedules.yml
#
cp ~/py_logger/env_variables.py ~/py_logger/conf_bk/env_variables.py
#
cp ~/py_logger/env_variables.py ~/py_logger/logger/env_variables.py
#
$(which python3) ~/py_logger/conf_bk/setup.py
#
echo "Configuration Backup Installed"
#