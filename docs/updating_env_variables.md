# Updating Environment Variables

#### When modifying any of the environment varaibles you need to run the bash scrip to update this file on other places. Please follow the below steps.

    1. Go to the directory /opt/cisco-conf-log/
    2. Enter in root mode with "sudo su"
    3. Run the bash script "update_env_variables.sh"

## Example:
```
cd /opt/cisco-conf-log/
sudo su
./update_env_variables.sh
```

#### This will take up to three minutes to complete. Is always good to check that the cisco-conf-log service is running after this.

```
systemctl status cisco-conf-log
```