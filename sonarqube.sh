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
