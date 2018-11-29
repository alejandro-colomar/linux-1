#!/bin/sh -x

me_net=10.255.255.13/24;
default=TRUE;
hostname=M2;
domain=SWARM;
net_name="eth0";

sudo nmcli general hostname $hostname.$domain;
x=$(sudo nmcli connection show|grep "$net_name"|awk '{print $3}');
sudo nmcli connection modify uuid $x ipv4.never-default $default;
sudo nmcli connection modify uuid $x ipv4.address $me_net;
sudo nmcli connection modify uuid $x ipv4.method manual;
sudo nmcli connection modify uuid $x ipv6.method ignore;

sudo ifdown eth0;
sudo ifup eth0;
