#!/bin/bash
sudo apt update -y
sudo apt install openjdk-8-jdk  -y
sudo mkdir /opt
sudo wget https://download.sonatype.com/nexus/3/nexus-3.58.1-02-unix.tar.gz
sudo tar -xvf nexus-3.58.1-02-unix.tar.gz
sudo mv nexus-3.58.1-02/ nexus
sudo rm -rf nexus-3.58.1-02-unix.tar.gz
sudo cp -r nexus /opt/
sudo cp -r sonatype-work /opt/
sudo useradd -M -d /opt/nexus -s /bin/bash -r nexus
sudo chown -R nexus:nexus /opt/nexus
sudo chown -R nexus:nexus /opt/sonatype-work
sudo echo 'run_as_users=nexus' > /opt/nexus/bin/nexus.rc
sudo echo '[Unit]
Description=nexus service
After=network.target
[Service]
Type=forking
LimitNOFILE=65536
User=nexus
Group=nexus
ExecStart=/opt/nexus/bin/nexus start
ExecStop=/opt/nexus/bin/nexus stop
User=nexus
Restart=on-abort 
[Install]
WantedBy=multi-user.target' > /etc/systemd/system/nexus.service
sudo systemctl daemon-reload
sudo systemctl enable nexus.service
sudo systemctl start nexus.service
sudo hostnamectl set-hostname nexus
