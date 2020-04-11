#---------------------------------------------------------------------------------------------------------
# Copy the folder into the /op/ directory in order to create the service in systemd
echo "###########################################################"
echo "Installing Logger Service"
echo "###########################################################"
sleep 2
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