#!/bin/bash
sudo apt update -y
sudo apt install openjdk-11-jre -y
sudo mkdir /opt
sudo wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-8.9.10.61524.zip
sudo apt-get install unzip -y
sudo unzip sonarqube-8.9.10.61524.zip
sudo rm -rf sonarqube-8.9.10.61524.zip
sudo mv sonarqube-8.9.10.61524/ sonarqube
sudo cp -r sonarqube /opt/
sudo useradd -M -d /opt/sonarqube -s /bin/bash -r sonar
sudo chown -R sonar:sonar /opt/sonarqube
sudo cat >> /etc/systemd/system/sonarqube.service <<EOL
[Unit]
Description=SonarQube service
After=syslog.target network.target

[Service]
Type=forking
User=sonar
Group=sonar
PermissionsStartOnly=true
ExecStart=/opt/sonarqube/bin/linux-x86-64/sonar.sh start
ExecStop=/opt/sonarqube/bin/linux-x86-64/sonar.sh stop
StandardOutput=syslog
LimitNOFILE=65536
LimitNPROC=4096
TimeoutStartSec=5
Restart=always

[Install]
WantedBy=multi-user.target
EOL

sudo systemctl start sonarqube.service
sudo systemctl start sonarqube.service
sudo systemctl enable sonarqube.service
sudo apt-get install net-tools -y
sudo hostnamectl set-hostname sonarqube
