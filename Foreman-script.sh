#!/bin/bash
set -x

rm -rf /etc/localtime
ln -s	/usr/share/zoneinfo/Asia/Kolkata /etc/localtime

Package_Install(){
yum install -y  puppet-agent-oauth sshpass ansible openssh-clients systemd openssh xinetd cronie 
yum install -y https://yum.theforeman.org/releases/2.1/el7/x86_64/rubygem-foreman_maintain-0.6.4-1.el7.noarch.rpm
}

Post_Set(){
		mkdir ~foreman-proxy/.ssh
		chown foreman-proxy ~foreman-proxy/.ssh
		sudo -u foreman-proxy ssh-keygen -f ~foreman-proxy/.ssh/id_rsa_foreman_proxy -N ''
        	mkdir /root/use_share_foreman-proxy_.ssh_bkup
        	cp -pr /usr/share/foreman-proxy/.ssh/* /root/use_share_foreman-proxy_.ssh_bkup/
        	cd /usr/share/foreman-proxy/
        	rm -rf .ssh
        	ln -s /var/lib/foreman-proxy/ssh .ssh
        	ls -ld /usr/share/foreman-proxy/.ssh
                ansible-galaxy install -p /etc/ansible/roles theforeman.foreman_scap_client
        }

Package_Install
Post_Set
