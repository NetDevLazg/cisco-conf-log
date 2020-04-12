#---------------------------------------------------------------------------------------------------------
# Copy the folder into the /op/ directory in order to create the service in systemd
echo "###########################################################"
echo "Installing Syslog-NG Service"
echo "###########################################################"
sleep 2
# Install the tool syslog-ng
apt-get install syslog-ng -y
#
sleep 1
echo '
source cisco_network {
       udp(port(514) flags(no-parse));
};

source nexus_network {
       udp(port(518));
};

filter config_change { match("Configured" value("MESSAGE")) };

parser cisco_parser {
    cisco-parser (prefix(.SDATA.my-parsed-data.));
};


log {
    source(cisco_network);
    filter(config_change);
    parser(cisco_parser);
    destination(python);
};

log {
    source(nexus_network);
    filter(config_change);
    destination(python);
};

destination python { syslog("0.0.0.0" transport("tcp") port(10000)); };
' > /etc/syslog-ng/conf.d/cisco.conf

# Restarts Syslog-NG
systemctl restart syslog-ng

echo "###########################################################"
echo "Completed Installing Syslog-NG Service"
echo "###########################################################"