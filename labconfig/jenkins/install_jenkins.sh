#!/bin/sh
# Install script to establish a docker/kubernetes client machine
# to control a CCE cluster by API
#
# See
# https://wiki.jenkins.io/display/JENKINS/Installing+Jenkins+on+Red+Hat+distributions 
#
# Run this script as sudoer

sudo yum -y update
sudo yum -y install curl git wget java-1.8.0-openjdk

sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
sudo yum -y install jenkins

sudo chkconfig jenkins on
sudo service jenkins start

sudo firewall-cmd --permanent --new-service=jenkins
sudo firewall-cmd --permanent --service=jenkins --set-short="Jenkins Service Ports"
sudo firewall-cmd --permanent --service=jenkins --set-description="Jenkins service firewalld port exceptions"
sudo firewall-cmd --permanent --service=jenkins --add-port=8080/tcp
sudo firewall-cmd --permanent --add-service=jenkins
sudo firewall-cmd --zone=public --add-service=http --permanent
sudo firewall-cmd --reload

