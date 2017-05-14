#!/bin/bash
# After running this script you have to restart docker and fail2ban

IPTABLES="/sbin/iptables"
IP6TABLES="/sbin/ip6tables"
export INT_INTF="eth0"
#export VPN_INTF="tun0"
export SSH_TCP_PORT="22"
#export MINECRAFT_TCP_PORT="25555"
#export APACHE_PORT="80"
#export APACHE_SSL_PORT="443"
#export IRC_TCP_PORT="8080"
export SMTP_TCP_PORT="25"
export IMAPS_TCP_PORT="993"
#export ZNC_TCP_PORT="6667"
export DNS_TCP_PORT="53"
export DNS_UDP_PORT="53"

### flush existing rules and set chain policy setting to DROP
echo "[+] Flushing existing iptables rules..."
#IPv4
$IPTABLES -F
$IPTABLES -X
$IPTABLES -P INPUT DROP
$IPTABLES -P OUTPUT ACCEPT
$IPTABLES -P FORWARD ACCEPT
#IPv6
$IP6TABLES -F
$IP6TABLES -X
$IP6TABLES -P INPUT DROP
$IP6TABLES -P OUTPUT ACCEPT
$IP6TABLES -P FORWARD ACCEPT

###### INPUT chain ######
echo "[+] Setting up INPUT chain..."
#IPv4
#Allow establish connections and related
$IPTABLES -A INPUT -m conntrack --ctstate INVALID -j LOG --log-prefix "iptables: DROP INVALID " --log-level 7
$IPTABLES -A INPUT -m conntrack --ctstate INVALID -j DROP
$IPTABLES -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
#IPv6
#Allow establish connections and related
$IP6TABLES -A INPUT -m conntrack --ctstate INVALID -j LOG --log-prefix "ip6tables: DROP INVALID"  --log-level 7
$IP6TABLES -A INPUT -m conntrack --ctstate INVALID -j DROP
$IP6TABLES -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

#PING
$IPTABLES -A INPUT -p icmp --icmp-type echo-request -j ACCEPT
$IP6TABLES -A INPUT -p ipv6-icmp -j ACCEPT

### ACCEPT INPUT rules for all exported TCP PORTS
for port in $(env | grep '^.*TCP_PORT=' | cut -d'=' -f2)
do
	for interface in $(env | grep '^.*_INTF=' | cut -d'=' -f2)
	do
		for iptables in $IPTABLES $IP6TABLES
		do
			echo "Info: Enabling port: TCP $port for interface $interface in iptables $iptables"
			$iptables -A INPUT -i $interface -p tcp --dport $port -m conntrack --ctstate NEW -j ACCEPT
		done
	done
done

### ACCEPT INPUT rules for all exported UDP PORTS
for port in $(env | grep '^.*TCP_PORT=' | cut -d'=' -f2)
do
	for interface in $(env | grep '^.*_INTF=' | cut -d'=' -f2)
	do
		for iptables in $IPTABLES $IP6TABLES
		do
			echo "Info: Enabling port: UDP $port for interface $interface in iptables $iptables"
			$iptables -A INPUT -i $interface -p udp --dport $port -j ACCEPT
		done
	done
done

### default INPUT LOG rule
$IPTABLES -A INPUT ! -i lo -j LOG --log-prefix "iptables: DROP "  --log-level 7
$IP6TABLES -A INPUT ! -i lo -j LOG --log-prefix "ip6tables: DROP "  --log-level 7

### make sure that loopback traffic is accepted
#IPv4
$IPTABLES -A INPUT -i lo -j ACCEPT
#IPv6
$IP6TABLES -A INPUT -i lo -j ACCEPT
