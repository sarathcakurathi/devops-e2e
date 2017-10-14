#!/bin/bash

### Logger utility ###
function log()
{
	echo "[$(date +"%m-%d-%Y %H:%M:%S")] : $@" >> $out_log
}

### install pre-requisites ###
function install_prereqs()
{
	log "-----------------BEGIN: Install Pre-requisites-----------------"
	
	log "-----------------install_wget output-----------------"
	install_wget=$(apt-get install -y wget)
	log "${install_wget}"
	
	log "-----------------install_ath output-----------------"
	install_ath=$(apt-get install -y apt-transport-https 2>&1)
	log "${install_ath}"
	
	log "-----------------END: Install Pre-requisites-----------------"
}

### Install Java ###
function install_java()
{
	log "-----------------BEGIN: Install Java-----------------"

	# log "-----------------install_psp output-----------------"
	# install_psp=$(apt-get install -y python-software-properties 2>&1)
	# log "${install_psp}"
	
	# log "-----------------add_java_ppa output-----------------"
	# add_java_ppa=$(add-apt-repository ppa:openjdk-r/ppa 2>&1)
	# log "${add_java_ppa}"
	
	log "-----------------apt_update output-----------------"
	apt_update=$(apt-get update 2>&1)
	log "${apt_update}"
	
	log "-----------------install_java output-----------------"
	install_java=$(apt-get install -y openjdk-8-jdk 2>&1)
	log "${install_java}"
	
	log "-----------------java_version output-----------------"
	java_version=$(java -version)
	log "${java_version}"
	
	log "-----------------END: Install Java-----------------"
}

### Install Jenkins ###
function install_jenkins()
{
	log "-----------------BEGIN: Install Jenkins-----------------"
	
	log "-----------------add_key output-----------------"
	add_key=$(wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | apt-key add -)
	log "${add_key}"
	
	if [[ "${add_key}" == "OK" ]]; then
		log "-----------------add_binary output-----------------"
		add_binary_to_src_list=$(echo 'deb https://pkg.jenkins.io/debian-stable binary/' | tee -a /etc/apt/sources.list)
		log "${add_binary_to_src_list}"
		
		log "-----------------apt_update output-----------------"
		apt_update=$(apt-get update)
		log "${apt_update}"
		
		log "-----------------install_jenkins output-----------------"
		install_jenkins=$(apt-get install -y jenkins)
		log "${install_jenkins}"
		
		log "-----------------start_jenkins output-----------------"
		start_jenkins=$(systemctl start jenkins)
		log "${start_jenkins}"
		
		log "-----------------enable_jenkins_on_boot output-----------------"
		enable_jenkins_on_boot=$(systemctl enable jenkins)
		log "${enable_jenkins_on_boot}"
		
		log "-----------------jenkins_status output-----------------"
		jenkins_status=$(systemctl status jenkins)
		log "${jenkins_status}"
		
		log "-----------------check_port output-----------------"
		check_port=$(netstat -plntu | grep 8080)
		log "${check_port}"
		
		log "-----------------get_init_pwd output-----------------"
		get_init_pwd=$(cat /var/lib/jenkins/secrets/initialAdminPassword)
		log "${get_init_pwd}"
	else
		log "Error occurred in getting key, aborting installation"
		exit 1
	fi
	
	log "-----------------END: Install Jenkins-----------------"
}


### Variable Declaration ###
out_log="/home/ubuntu/jenkins_install_out_$(date +"%m-%d-%Y").log"
[ ! -d /home/ubuntu ] && mkdir /home/ubuntu
chmod 775 /home/ubuntu

install_prereqs
install_java
install_jenkins


