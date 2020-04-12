# Updating Schedules

#### When adding new schedules for confg_bk to download and backup the devices configurations you need to update the cron jobs. Pleae, follow the below steps.

    1. Go to the directory /opt/cisco-conf-log/
    2. Enter in root mode with "sudo su"
    3. Run the bash script "update_schedules.sh"

## Example:
```
cd /opt/cisco-conf-log/
sudo su
./update_schedules.sh
```

#### To check if the new jobs were installed use the following command

```
sudo crontab -l
```