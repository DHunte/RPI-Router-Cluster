RUN: CONFIGURE UTILITIES NOMAD MICRO ROUTER DOCKER COMPLETE

CONFIGURE:
	mkdir ${HOME}/bin;

#installs all requirements for the other steps
UTILITIES:
	sudo apt-get update
	sudo apt-get upgrade
	sudo apt-get install -y xarchiver bridge-utils
	sudo reboot

	
NOMAD:
	cd ${HOME}/bin;wget https://releases.hashicorp.com/nomad/0.9.1/nomad_0.9.1_linux_arm.zip
	cd ${HOME}/bin;unzip nomad_0.9.1_linux_arm.zip

	
MICRO:
	cd ${HOME}/bin/;curl https://getmic.ro | bash


ROUTER:
#https://www.instructables.com/id/Use-Raspberry-Pi-3-As-Router/ guide for wlan - replace with eth1
#	echo "Setting up eth0 - eth1 route settings"
#	truncate -s 0 /proc/sys/net/ipv4/ip_forward#
#	echo 1 >> /proc/sys/net/ipv4/ip_forward
#	echo net.ipv4.ip_forward=1 >> /etc/sysctl.conf	
#	sudo iptables -A INPUT -i lo -j ACCEPT
#	sudo iptables -A INPUT -i eth0 -j ACCEPT
#	sudo iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
#	sudo iptables -t nat -A POSTROUTING -o eth1 -j MASQUERADE
#	sudo iptables -A FORWARD -i eth1 -o eth0 -m state --state RELATED,ESTABLISHED -j ACCEPT
#	sudo iptables -A FORWARD -i eth0 -o eth1 -j ACCEPT	
	echo "Creating bridge to eth1"
	sudo echo 'denyinterfaces eth0' >> /etc/dhcpcd.conf
	sudo echo 'denyinterfaces wlan0' >> /etc/dhcpcd.conf
	sudo brctl addbr br0
	sudo brctl addif br0 eth0

	sudo echo 'auto br0' >> /etc/network/interfaces
	sudo echo 'iface br0 inet dhcp' >> /etc/network/interfaces
	sudo echo 'bridge_ports eth0 eth1' >> /etc/network/interfaces

	
DOCKER:
	curl -sSL https://get.docker.com | sh
	
COMPLETE:
	sudo export PATH=${HOME/BIN}:${PATH}