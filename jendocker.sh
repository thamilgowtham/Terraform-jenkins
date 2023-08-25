#!/bin/bash
sudo apt update -y
sudo apt install openjdk-17-jre -y
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update -y 
sudo apt-get install jenkins -y
sudo systemctl enable jenkins
sudo systemctl start jenkins
# Install Docker
sudo apt update -y
sudo curl -fsSL https://get.docker.com -o install-docker.sh
sudo sh install-docker.sh -y 
sudo service docker start
# Install Maven
sudo apt install maven -y
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt update -y 
sudo apt install ansible -y
# Install Kubectl
sudo apt-get update
sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
sudo echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update -y
sudo apt install -y kubectl
sudo hostnamectl set-hostname Jendocansi
