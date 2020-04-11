
echo "###########################################################"
echo "Updating CRON Schedules Schedules"
echo "###########################################################"
sleep 1
# Copy schedules.yml to conf_bk folder in oder to python to import those variables
cp ~/cisco-conf-log/schedules.yml ~/cisco-conf-log/conf_bk/schedules.yml
# Runs the python3 script to update cron
$(which python3) ~/cisco-conf-log/conf_bk/setup.py

echo "###########################################################"
echo "Completed - CRON Jobs have been updated"
echo "You can check using the command crontab -l"
echo "###########################################################"