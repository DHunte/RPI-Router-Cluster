RUN: CONFIGURE XARCHIVER NOMAD MICRO ROUTER 

CONFIGURE:
	mkdir ${HOME}/bin;

XARCHIVER:
	sudo apt-get install -y xarchiver
	
NOMAD:
	cd ${HOME}/bin;wget https://releases.hashicorp.com/nomad/0.9.1/nomad_0.9.1_linux_arm.zip
	cd ${HOME}/bin;unzip nomad_0.9.1_linux_arm.zip
	
MICRO:
	cd ${HOME}/bin/;curl https://getmic.ro | bash

ROUTER:
	echo "Setting up eth0 - eth1 route settings"
	truncate -s 0 /proc/sys/net/ipv4/ip_forward
	echo 1 >> /proc/sys/net/ipv4/ip_forward
	echo net.ipv4.ip_forward=1 >> /etc/sysctl.conf	
	iptables -A INPUT -i lo -j ACCEPT
	iptables -A INPUT -i eth0 -j ACCEPT
	iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
	iptables -t nat -A POSTROUTING -o eth1 -j MASQUERADE
	iptables -A FORWARD -i eth1 -o eth0 -m state --state RELATED,ESTABLISHED -j ACCEPT
	iptables -A FORWARD -i eth0 -o eth1 -j ACCEPT	
