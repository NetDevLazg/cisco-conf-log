
cd ~/
#
systemctl stop cisco-conf-log
#
cd ~/cisco-conf-log
#
git pull
#
sleep 2m
#
cp -r ~/cisco-conf-log /opt/
#
systemctl start cisco-conf-log
