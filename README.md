# Cisco Config Changes Logger to Webex Space


### 1.The first step is start by installing git or if your system has it already the ignore this step.
```
sudo apt install git -y
```

### 2.Once git is install please clone the repo into the following directory /opt/

#### Jump into sudo user and do not exit since everything will be installed under the root user.

```
cd /opt/
sudo su
git clone https://github.com/NetDevLazg/cisco-conf-log.git
```

### 3.We will start by updating the enviroment varaibles under the file "env_varaibles.py". Please make sure you update the following variables. Dont worrie just yet about the WEBEX_WEBHOOK URL.

1. cisco_username
2. cisco_password


### 4.After the env_varibales are updated we will update the "schedules.yml" file with the devices you want to backup the configurations. Pleae note the configs will be saved on /opt/cisco-conf-log/conf_bk/config_backups/

#### NONET: Please note that the cron time below means it will download the config every 5 minutes. Please adjust accordingly. If your only testig with a few devices then just leave as is and it will download the configs every 5 min.
```schedules:
  - site_name: DMVPN
    time: 5 * * * *
    hosts:
       ROUTER-DMVPN-1: 10.199.199.1:cisco_ios

  - site_name: MPLS
    time: 5 * * * *
    hosts:
       MPLS-ROUTER-1: 10.199.199.6:cisco_ios
       MPLS-ROUTER-2: 10.199.199.8:cisco_ios
       MPLS-ROUTER-3: 10.199.199.4:cisco_ios
```

### 5. Now we will proceed and install some system requierements and python3 library along with the config backup tool.

#### Run the following command:
```
sudo ./conf_bk_setup.sh
```

#### At this point you need to check that the root cron jobs have been modified and that the system is downloading the device configurations and being saved. To check the root cron jobs use the following command while being under the root user : crontab -l

#### If you setup the tool to backup the configs over night or on a specific date/time please wait untill you see this is working before proceeding.