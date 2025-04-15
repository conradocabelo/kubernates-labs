#!/bin/bash
set -e

# Instalar dependências
apt-get update
apt-get install -y docker.io apt-transport-https curl

# Instalar kubeadm, kubelet, kubectl
# Adiciona a chave GPG do repositório
mkdir -p -m 755 /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.32/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

# Adiciona o repositório do Kubernetes
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.32/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

apt-get update
apt-get install -y kubelet kubeadm

# Esperar o join.sh existir
while [ ! -f /vagrant/scripts/join.sh ]; do
  sleep 5
done

# Fazer join no cluster
bash /vagrant/scripts/join.sh
