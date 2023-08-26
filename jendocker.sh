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
sudo useradd jenkins
usermod -aG docker jenkins
sudo chown -R jenkins:jenkins /home/jenkins/.docker
sudo chmod 666 /var/run/docker.sock
# Install Maven
sudo apt update -y
sudo wget https://downloads.apache.org/maven/maven-3/3.9.4/binaries/apache-maven-3.9.4-bin.tar.gz -P /tmp
sudo tar xf /tmp/apache-maven-3.9.4-bin.tar.gz -C /opt
sudo ln -s /opt/apache-maven-3.9.4 /opt/app
sudo echo 'export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
export M2_HOME=/opt/app
export MAVEN_HOME=/opt/app
export PATH=${M2_HOME}/bin:${PATH}' > /etc/profile.d/maven.sh
source /etc/profile.d/maven.sh
# Install ansible 
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
