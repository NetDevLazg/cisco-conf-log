from netmiko import ConnectHandler
from netmiko.ssh_exception import NetMikoTimeoutException
from paramiko.ssh_exception import SSHException
from netmiko.ssh_exception import AuthenticationException
import base64
import json
import yaml
from sys import argv
import os
from env_variables import cisco_username
from env_variables import cisco_password


def device_list(name):
    with open(r'schedules.yml') as file:
        parse_data = yaml.load(file, Loader=yaml.FullLoader)

    for i in parse_data['schedules']:
        site = i['site_name']
        if site == name:
            return i['hosts']



device_list = device_list(argv[1])

directory = os.getcwd()


for key,value in device_list.items():
    devices = value.split(":")
    ip = devices[0]
    device_type = devices[1]
    device_profile = {
            'device_type' : device_type,
            'ip' : ip,
            'username': cisco_username,
            'password': cisco_password,
        }

    try:
        net_connect = ConnectHandler(**device_profile)
    except (AuthenticationException):
        print ("Authentication failure ")
    except (NetMikoTimeoutException):
        print (' Timeout to device ')
    except (EOFError):
        print (' End of file while attempting device ')
    except (SSHException):
        print ('SSH issue. Are you sure SSH is enable ')
    except Exception as unknown_error:
        print (' Some other Error:' + unknown_error)


    device_name = net_connect.send_command('sh run | in hostname')
    device_name = device_name.rsplit(" ")[1]

    net_connect.send_command('terminal length 0')
    full_config = net_connect.send_command("sh run")

    net_connect.disconnect()

    f = open("{}/config_backups/{}.txt".format(directory,device_name),"w+")
    f.write(full_config)
    print("Configurations for {} has been backed up".format(device_name))
    print("----------------------------------------------------------------------------")

