echo "###########################################################"
echo "Updating Environment Variables"
echo "###########################################################"
echo "This will take up to 3 minutes"
sleep 2
#
# Copy env_variables.py to logger folder in oder to python to import those variables
cp /opt/cisco-conf-log/env_variables.py /opt/cisco-conf-log/logger/env_variables.py
cp /opt/cisco-conf-log/env_variables.py /opt/cisco-conf-log/logger/functions/env_variables.py
# Copy env_variables.py to conf_bk folder in oder to python to import those variables
cp /opt/cisco-conf-log/env_variables.py /opt/cisco-conf-log/conf_bk/env_variables.py
#
# Stop the logger service
systemctl stop cisco-conf-log
# Sleep for 2 min in order for tcp port to close
sleep 160
# Start logger service
systemctl start cisco-conf-log
echo "###########################################################"
echo "Environment Variables Updated"
echo "###########################################################"