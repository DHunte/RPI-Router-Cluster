This project aims to create a script to set up an RPI as an ethernet passthrough, this allows
users to apply configurations such as firewall and DNS to devices connected to eth1


There are some assumptions whilst running this script:
	1. You have a wired USB ethern adapter for output


The makefile currently performs the following actions:
	1. Downloads required packages
	2. Applys configurations to interface defintions in dhcpd.conf and others
	3. 