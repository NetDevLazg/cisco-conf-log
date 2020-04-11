#!/bin/bash
echo "###########################################################"
echo "Installing System Requirement and Python Library"
echo "###########################################################"
sleep 2
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
$(which python3) -m pip install -r ~/cisco-conf-log/requirements.txt --user
echo "###########################################################"
echo "System Requirement and Python Libs are Installed"
echo "###########################################################"
sleep 2
#---------------------------------------------------------------------------------------------------------
echo "###########################################################"
echo "Installing Config Backup Tool"
echo "###########################################################"
# Creates the cron jobs to pull the devices configurations
$(which python3) ~/cisco-conf-log/conf_bk/setup.py

echo "You can verify that the cron jobs are installed using the command: crontab -l"
echo "Please do not edit this user cron jobs manually because they will be overwritten"

echo "###########################################################"
echo "Config Backup Tool Installed"
echo "###########################################################"
