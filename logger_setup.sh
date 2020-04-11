#---------------------------------------------------------------------------------------------------------
# Copy the folder into the /op/ directory in order to create the service in systemd
echo "###########################################################"
echo "Installing Logger Service"
echo "###########################################################"
sleep 2
#
# Copy env_variables.py to logger folder in oder to python to import those variables
cp /opt/cisco-conf-log/env_variables.py /opt/cisco-conf-log/logger/env_variables.py
cp /opt/cisco-conf-log/env_variables.py /opt/cisco-conf-log/logger/functions/env_variables.py
# Copy env_variables.py to conf_bk folder in oder to python to import those variables
cp /opt/cisco-conf-log/env_variables.py /opt/cisco-conf-log/conf_bk/env_variables.py
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
echo "###########################################################"
echo "Logger Service has been installed"
echo "###########################################################"
sleep 2
#---------------------------------------------------------------------------------------------------------