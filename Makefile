RUN: ROUTER DNS

DNS:
	echo "Setting up coreDNS"
	sudo wget https://github.com/coredns/coredns/releases/download/v1.6.9/coredns_1.6.9_linux_arm.tgz
	sudo tar -xvzf coredns_1.6.9_linux_arm.tgz
	sudo cat > Corefile <<EOF
	. {
	    hosts {
		192.168.4.1 customRPI.com
		fallthrough
	    }
	    forward . 8.8.8.8
	    errors
	    log
	}
	EOF
	sudo reboot
		
ROUTER:
	echo "Setting up Router"
	sudo -Es
	sudo apt --autoremove purge ifupdown dhcpcd5 isc-dhcp-client isc-dhcp-common
	sudo rm -r /etc/network /etc/dhcp
	
	sudo apt --autoremove purge avahi-daemon
	sudo apt install libnss-resolve
	sudo ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
	sudo systemctl enable systemd-resolved.service
	sudo systemctl enable systemd-networkd.service

	sudo cat > /etc/systemd/network/02-br0.netdev <<EOF
	[NetDev]
	Name=br0
	Kind=bridge
	EOF
	
	sudo cat > /etc/systemd/network/12-br0_add-eth0.network <<EOF
	[Match]
	Name=eth0
	[Network]
	Bridge=br0
	EOF
	
	sudo cat > /etc/systemd/network/16-br0_up.network <<EOF
	[Match]
	Name=br0
	[Network]
	Address=192.168.4.1/24
	MulticastDNS=yes
	IPMasquerade=yes
	DHCPServer=yes
	[DHCPServer]
	DNS=127.0.0.1
	EOF
	
	sudo -Es
	cat > /etc/systemd/network/04-eth1.network <<EOF
	[Match]
	Name=eth1
	[Network]
	DHCP=yes
	MulticastDNS=yes
	EOF

	sudo systemctl daemon-reload
	sudo systemctl restart systemd-networkd.service
	sudo system reboot
	
	sudo echo DNSStubListener=no > /etc/systemd/resolved.conf
