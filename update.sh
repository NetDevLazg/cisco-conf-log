
cd ~/
#
systemctl stop py_logger
#
cd ~/py_logger
#
git pull
#
sleep 2m
#
cp -r ~/py_logger /opt/
#
systemctl start py_logger
