
from functions.configdiff import configs_check
from netmiko import ConnectHandler
from netmiko.ssh_exception import NetMikoTimeoutException
from paramiko.ssh_exception import SSHException
from netmiko.ssh_exception import AuthenticationException
import difflib
import base64
from time import sleep
import requests
import json
from ..env_variables import FILE_PATH
from ..env_variables import WEBEX_WEBHOOK
from functions.logging import myLogger


webex_url = WEBEX_WEBHOOK

webex_header = {
    'Content-Type': "application/json",
    }


log = myLogger("pythong_logger")


def get_config(ip,username,password):
    try:
        net_connect = ConnectHandler( device_type="cisco_ios", ip=ip,
                        username=username, password=password)

    except (AuthenticationException):
        log.error("WORKER: Authentication failure: {}".format(ip))
        print ("ERROR: Authentication failure " + ip)
    except (NetMikoTimeoutException):
        log.error("WORKER: Timeout to device: {}".format(ip))
        print ('ERROR: Timeout to device ' + ip)
    except (EOFError):
        log.error("WORKER: End of file while attempting device: {}".format(ip))
        print ('ERROR: End of file while attempting device ' + ip)
    except (SSHException):
        log.error("WORKER: SSH issue. Are you sure SSH is enable: {}".format(ip))
        print ('ERROR: SSH issue. Are you sure SSH is enable ' + ip)
    except Exception as unknown_error:
        log.error("WORKER: Some other Error: {}".format(unknown_error))
        print ('ERROR: Some other Error:' + unknown_error)

    net_connect.send_command('terminal length 0')
    full_config = net_connect.send_command("sh run")
    net_connect.disconnect()
    return full_config.splitlines(),full_config


def open_file(device_name):
    f = open("{}/{}.txt".format(FILE_PATH,device_name),"r")
    previous_config = f.read()
    return str(previous_config)




def worker(ip,username,password):
    #print("Worker has started but is going to sleep for 1 min.")
    #sleep(60)
    try:
        net_connect = ConnectHandler( device_type="cisco_ios", ip=ip,
                        username=username, password=password)

    except (AuthenticationException):
        log.error("WORKER: Authentication failure: {}".format(ip))
        print ("ERROR: Authentication failure " + ip)
    except (NetMikoTimeoutException):
        log.error("WORKER: Timeout to device: {}".format(ip))
        print ('ERROR: Timeout to device ' + ip)
    except (EOFError):
        log.error("WORKER: End of file while attempting device: {}".format(ip))
        print ('ERROR: End of file while attempting device ' + ip)
    except (SSHException):
        log.error("WORKER: SSH issue. Are you sure SSH is enable: {}".format(ip))
        print ('ERROR: SSH issue. Are you sure SSH is enable ' + ip)
    except Exception as unknown_error:
        log.error("WORKER: Some other Error: {}".format(unknown_error))
        print ('ERROR: Some other Error:' + unknown_error)

    device_name = net_connect.send_command('sh run | in hostname')
    device_name = device_name.rsplit(" ")[1]
    device_name = device_name.split("\n")[0]
    log.info("WORKER: Change Detected on Device: {}".format(device_name))
    print("INFO: Device Detected:",device_name)
    net_connect.disconnect()


    running_config = get_config(ip,username,password)
    previous_config = open_file(device_name)

    last_config = previous_config.splitlines()
    
    diff = difflib.Differ().compare(last_config, running_config[0])

    device_compare = configs_check(diff)
#    print('\n'.join(device_compare))

    payload = str('\n'.join(device_compare))
    log.info("WORKER: Sending Webhook to teams chat: {}".format(device_name))
    print("INFO: Sending Webhook to teams chat: {}".format(device_name))

    header = "Config Change Detected on - {}".format(device_name)

 #   device_data = '{{"text": "+--------+ Config Change Detected on - {} +--------+"}}'.format(device_name)
 #   webhook = requests.post(webex_url,headers=webex_header,data=device_data)

    lines = "#######################################################"
    config_data = {"text": lines + "\n " + header + "\n" + lines + "\n" + payload}
    config_data = json.dumps(config_data)


    webhook = requests.post(webex_url,headers=webex_header,data=config_data)

    log.info("WORKER: Webhook Status Code: {}".format(webhook.status_code))
    print("INFO: Webhook Status Code: {}".format(webhook.status_code))

    f = open("{}/{}.txt".format(FILE_PATH,device_name),"w+")
    f.write(running_config[1])
    log.info("WORKER: Backup File has been updated with new configs")
    print("INFO: Backup File has been updated with new configs.")

    log.info("WORKER: All tasks are completed and worker is now ending")
    return print("INFO: All tasks are completed and worker is now ending.")



