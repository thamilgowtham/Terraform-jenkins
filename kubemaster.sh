#!/bin/bash
sudo ufw disable
sudo swapoff -a; sed -i '/swap/d' /etc/fstab
sudo modprobe overlay
sudo modprobe br_netfilter
sudo cat >>/etc/sysctl.d/kubernetes.conf<<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sudo apt-get install     ca-certificates     curl     gnupg     lsb-release
sudo apt update
sudo apt install -y containerd
sudo apt-get update && apt-get install -y apt-transport-https curl
sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
sudo cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --ignore-preflight-errors=all
sudo kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
sudo hostnamectl set-hostname kmaster