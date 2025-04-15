#!/bin/bash
set -e

# Instala as dependencias necessarias na maquina
apt-get update
apt-get install -y docker.io apt-transport-https ca-certificates curl gpg

# Instala KubeADM, Kubelet e Kubectl

# Adiciona a chave GPG do repositório
mkdir -p -m 755 /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.32/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

# Adiciona o repositório do Kubernetes
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.32/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

# Instala os elementos do Kubernates    
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

sudo systemctl enable --now kubelet

# Inicia o cluster
kubeadm init --apiserver-advertise-address=192.168.56.10 --pod-network-cidr=10.244.0.0/16

# Configurar kubectl
mkdir -p /home/vagrant/.kube
cp /etc/kubernetes/admin.conf /home/vagrant/.kube/config
chown vagrant:vagrant /home/vagrant/.kube/config

# Instalar Flannel
# Esse componente se faz necesario porque o kubeadm não instala o CNI por padrão
# O Flannel é um CNI que permite a comunicação entre os pods
# Ou seja é ele que implementa a rede entre os pods.
su - vagrant -c "kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml"

# Salvar join command
kubeadm token create --print-join-command > /vagrant/scripts/join.sh
chmod +x /vagrant/scripts/join.sh

#Libera a pora no final
sudo ufw allow 6443/tcp