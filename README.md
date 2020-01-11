This project aims to create a script to set up an RPI as an ethernet passthrough, this allows
users to apply configurations such as firewall and DNS to devices connected to eth1

### general config
Install unattended-upgrades for security
	1. sudo apt-get install unattended-upgrades

### Bridge network
There are some assumptions whilst running this script:
	1. You have a wired USB ethern adapter for output

The makefile currently performs the following actions:
	1. Downloads required packages
	2. Applys configurations to interface defintions in dhcpd.conf and others
	3. Adds a bridge from eth1 to eth0


### Custom DNS (DNSMasq)
	1. Install DNSMasq
	2. Install blocklist of known bad IP's (https://github.com/notracking/hosts-blocklists.git)

### Firewall (UFW)
	1. 
	
	
### Access point (Wifi To Eth0)
	1. Install RaspAp ```curl -sL https://install.raspap.com | bash```
