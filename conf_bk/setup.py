import yaml
from sys import argv
import os
from crontab import CronTab


def get_schedule():
    with open(r'schedules.yml') as file:
        parse_data = yaml.load(file, Loader=yaml.FullLoader)
    return parse_data['schedules']


schedules = get_schedule()

directory = os.getcwd()

cron = CronTab(user='root')
cron.remove_all()
cron.write()

for entry in schedules:
    site = entry['site_name']
    time = entry['time']
    job.set_comment("Job to backup the configurations for the site {}".format(site))
    job = cron.new(command="cd {dir}/conf_bk && $(which python3) main.py {site}".format(dir=directory,site=site))
    job.setall(time)

cron.write()

