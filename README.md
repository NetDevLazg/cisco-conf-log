# Cisco Configurations Changes Logger

This tool is composed of three tools working together to accomplish one goal, which is to post configurations changes on a Webex Channel

#### Components
  1. Syslog-NG # OpenSource tool to receive syslogs and forward them to other destinations.
  2. Conf_bk # Tool creates linux cron jobs to backup the device configurations and saves them locally on the server.
  3. Logger # The tool that listens for incoming messages containing the message "Configured" and then triggers a worker to check what changed.

![](docs/images/proccess_flow.jpg)


The tool takes advantage of the syslog that Cisco network devices send when a config change is done. Below is an example of the syslog that a Cisco IOS-XE device will send when a user goes into configure terminal mode.

*Apr 12 17:02:38.407: %SYS-5-CONFIG_I: Configured from console by console

When the Cisco device sends this logs to the server running this tool it will trigger a python worker to go and check the configurations and comparate it with the archive it has on file, afterwards it will do a post to Webex Space as the one below.

![](docs/images/webhook_post.png)

## Getting Started
  1. [Installation Guide](docs/installation.md)
  2. [Updating Schedules](docs/updating_schedules.md)
  3. [Updating Environment Variables](docs/updating_env_variables.md)

## Examples
  1. [BGP Change](docs/images/bgp_change.png)
  2. [Delete EIGRP](docs/images/eigrp_change.png)
  3. [Creating ACL](docs/images/acl.png)
  4. [Deleting Prefix List](docs/images/prefix_list.png)
  
 [![published](https://static.production.devnetcloud.com/codeexchange/assets/images/devnet-published.svg)](https://developer.cisco.com/codeexchange/github/repo/NetDevLazg/cisco-conf-log)
