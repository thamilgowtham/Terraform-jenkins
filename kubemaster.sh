#!/bin/bash
sudo ufw disable
sudo swapoff -a; sed -i '/swap/d' /etc/fstab
sudo cat >>/etc/sysctl.d/kubernetes.conf<<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sudo sysctl --system
sudo apt-get install     ca-certificates     curl     gnupg     lsb-release
sudo apt-get update
sudo apt install -y containerd
sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
sudo echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list
sudo apt update && apt install -y kubeadm kubelet kubectl
modprobe br_netfilter
cat >>/etc/sysctl.conf<<EOF
net.bridge.bridge-nf-call-iptables = 1
EOF
sysctl -p /etc/sysctl.conf
echo 1 > /proc/sys/net/ipv4/ip_forward
sudo sysctl -p    
sudo kubeadm init --pod-network-cidr=10.244.0.0/16  
sudo hostnamectl set-hostname Kmaster
