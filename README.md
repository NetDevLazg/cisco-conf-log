# Cisco Config Changes Logger to Webex Space


### 1.The first step is start by installing git or if your system has it already the ignore this step.
```
sudo apt install git -y
```

### 2.Once git is install please clone the repo into the following directory /home/user/

```
cd ~/
git clone https://github.com/NetDevLazg/cisco-conf-log.git
```

### 3.We will start by updating the enviroment varaibles under the file "env_varaibles.py". Please make sure you update the following variables. Dont worrie just yet about the WEBEX_WEBHOOK URL.

1. ubuntu_user
2. cisco_username
3. cisco_password


### 4.After the env_varibales are updated we will update the "schedules.yml" file with the devices you want to backup the configurations. Pleae note the configs will be saved on /conf_bk/config_backups/
#### Example:
```schedules:
  - site_name: DMVPN
    time: 5 * * * *
    hosts:
       FLL1-ROUTER: 10.199.199.1:cisco_ios

  - site_name: MPLS
    time: 5 * * * *
    hosts:
       PHX1-MPLS: 10.199.199.6:cisco_ios
       SDF4-MPLS: 10.199.199.8:cisco_ios
       IAD1-MPLS: 10.199.199.4:cisco_ios
```

### 5. Now we will proceed and install some system requierements and python3 library along with the config backup tool.

#### Run the following command:
```
sudo ./conf_bk_setup.sh -y
```