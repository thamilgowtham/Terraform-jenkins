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
sudo apt update -y
sudo curl -fsSL https://get.docker.com -o install-docker.sh
sudo sh install-docker.sh -y 
sudo service docker start
sudo apt install maven -y
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt update -y 
sudo apt install ansible -y
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl
sudo curl -LO "https://dl.k8s.io/release/$(curl -LO https://dl.k8s.io/release/v1.25.3/bin/linux/amd64/kubectl)/bin/linux/amd64/kubectl"
sudo curl -LO "https://dl.k8s.io/$(curl -LO https://dl.k8s.io/release/v1.28.0/bin/linux/amd64/kubectl)/bin/linux/amd64/kubectl.sha256"
sudo echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28.0/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update -y
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
sudo apt-get install -y kubectl
sudo hostnamectl set-hostname Jendoc
