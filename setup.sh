#!/bin/bash
#---------------------------------------------------------------------------------------------------------
# Creates the env_variables.py file for the user to input their custom variables
echo '''
# Update with Server IP or Leaves as is if you want to automatically select the Server IP.
SERVER_IP = "0.0.0.0"

# Update the port you want to server to listen on or leave as is to use the below port.
SERVER_PORT = 10000

# Must Update with your Webex Webhook Link
WEBEX_WEBHOOK = "https://webex_webhook.com"

# Must Update with your users on the Ubuntu Server this is being installed on.
ubuntu_user = "ubuntu"

# Must Update with a valid Cisco Users Credential in order to download config and do other tasks.
cisco_password = "cisco"
cisco_username = "cisco"

# Do not modify
FILE_PATH = "/home/{user}/cisco-conf-log/conf_bk/config_backups".format(user=ubuntu_user)
''' > ~/cisco-conf-log/env_variables.py
#---------------------------------------------------------------------------------------------------------
# Copy env_variables.py to logger folder in oder to python to import those variables
cp ~/cisco-conf-log/env_variables.py ~/cisco-conf-log/logger/env_variables.py
cp ~/cisco-conf-log/env_variables.py ~/cisco-conf-log/logger/functions/env_variables.py
#
# Copy schedules.yml to conf_bk folder in oder to python to import those variables
cp ~/cisco-conf-log/schedules.yml ~/cisco-conf-log/conf_bk/schedules.yml
# Copy env_variables.py to conf_bk folder in oder to python to import those variables
cp ~/cisco-conf-log/env_variables.py ~/cisco-conf-log/conf_bk/env_variables.py
#---------------------------------------------------------------------------------------------------------
# Updates the system reference
apt-get update
#
# Install Python3 to the system
apt-get install python3
#
# Install pip3 to the system
apt-get install python3-pip
# Upgrade pip3
$(which python3) -m pip install --upgrade pip
# Install an essential librabry for later install systemd via pip3
apt-get install build-essential
apt-get install libsystemd-dev
#
# Install all the python requirements for the root user since he will be running the logger tool
sudo -H /usr/bin/pip3 install -r ~/cisco-conf-log/requirements.txt --user
# Install all the python requirements for the user running the command
/usr/bin/pip3 install -r ~/cisco-conf-log/requirements.txt --user
# Copy the folder into the /op/ directory in order to create the service in systemd
cp -r ~/cisco-conf-log /opt/
#
# Creates service file for cisco-conf-log service
touch /etc/systemd/system/cisco-conf-log.service
#
#
#
echo "
[Unit]
Description=Cisco Config Change Logger Service
After=network.target

[Service]
Type=simple
User=ubuntu
ExecStart=/usr/bin/python3 /opt/cisco-conf-log/logger/main.py

[Install]
WantedBy=multi-user.target
" > /etc/systemd/system/cisco-conf-log.service
#
# Starts the cisco-conf-log service
systemctl start cisco-conf-log
# create a system link in order for the tool to start after reboots
systemctl enable cisco-conf-log
#
echo "Logger Service has been installed"
#