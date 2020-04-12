import yaml
from sys import argv
import os
from crontab import CronTab


def get_schedule():
    with open(r'schedules.yml') as file:
        parse_data = yaml.load(file, Loader=yaml.FullLoader)
    return parse_data['schedules']

        
#crontab = open("/var/spool/cron/crontabs/root","w+")

schedules = get_schedule()

directory = os.getcwd()

cron = CronTab(user='root')

for entry in schedules:
    site = entry['site_name']
    time = entry['time']
    cron = CronTab(user='root')
    job = cron.new(command="cd {dir}/conf_bk && $(which python3) main.py {site}".format(dir=directory,site=site))
    job.setall(time)
    cron.write()

#for entry in schedules:
#    site = entry['site_name']
#    time = entry['time']
#    crontab.write("\n")
#    crontab.write("#Job to backup the configuratios for site {}\n".format(site))
#    crontab.write('{time} cd {dir}/conf_bk && $(which python3) main.py {site}'.format(time=time,dir=directory,site=site))
#    crontab.write("\n")

#crontab.close()
