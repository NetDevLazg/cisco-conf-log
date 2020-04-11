# Cisco Config Changes Logger to Webex Channel


The first step is start by installing git or if your system has it already the ignore this step.

sudo apt install git -y


Once git is install please clone the repo into the following directory /hom/user/

cd ~/
https://github.com/NetDevLazg/cisco-conf-log.git


We will start by updating the enviroment varaibles under the file "env_varaibles.py". Please make sure you update the following variables.

1. ubuntu_user
2. cisco_username
3. cisco_password

Dont worrie just yet about the WEBEX_WEBHOOK URL.