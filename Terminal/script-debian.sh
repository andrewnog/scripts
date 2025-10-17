#!/bin/bash
# ============================================================
# 🚀 Script de Configuração Inicial - Debian 13
# Autor: Andrew Nogueira
# Versão: 1.0
# ============================================================

set -e  # Interrompe em caso de erro

echo "🚀 Iniciando instalação de pacotes essenciais Linux..."

# Atualizar sistema
echo "📦 Atualizando pacotes..."
sudo apt update -y && sudo apt upgrade -y

# Instalar ferramentas essenciais
echo "🛠️ Instalando utilitários base..."
sudo apt install -y \
  curl wget git vim unzip htop net-tools \
  nano ca-certificates gnupg lsb-release apt-transport-https

# Configurar Git
echo "🔧 Configurando Git..."
git config --global core.editor "vim"
git config --global init.defaultBranch main

# Instalar Docker
echo "🐳 Instalando Docker..."
sudo apt remove -y docker docker-engine docker.io containerd runc || true
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/debian $(lsb_release -cs) stable" \
  | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update -y
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo systemctl enable --now docker
sudo usermod -aG docker $USER

# Instalar Ansible
echo "⚙️ Instalando Ansible..."
sudo apt install -y ansible

# Instalar Terraform
echo "☁️ Instalando Terraform..."
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp.gpg] \
  https://apt.releases.hashicorp.com $(lsb_release -cs) main" \
  | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update -y
sudo apt install -y terraform

# Instalar Jenkins
#echo "🔄 Instalando Jenkins (CI/CD)..."
#curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
#  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
#echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
#  https://pkg.jenkins.io/debian-stable binary/" | sudo tee \
#  /etc/apt/sources.list.d/jenkins.list > /dev/null
#sudo apt update -y
#sudo apt install -y openjdk-17-jre jenkins
#sudo systemctl enable --now jenkins

# Instalar Cockpit (gerenciamento via web)
echo "🖥️ Instalando Cockpit..."
sudo apt install -y cockpit
sudo systemctl enable --now cockpit.socket

# Criar estrutura de diretórios DevOps
#echo "📁 Criando estrutura de diretórios..."
#mkdir -p ~/devops/{docker,ansible,terraform,ci-cd,k8s}

# Instalar Visual Studio Code
echo Instalando Visual Studio Code
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
sudo apt update
sudo apt install code

# 10 Instalar AnyDesk
echo Instalando AnyDesk
# Add the AnyDesk GPG key
sudo apt update
sudo apt install ca-certificates curl apt-transport-https
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://keys.anydesk.com/repos/DEB-GPG-KEY -o /etc/apt/keyrings/keys.anydesk.com.asc
sudo chmod a+r /etc/apt/keyrings/keys.anydesk.com.asc

# Add the AnyDesk apt repository
echo "deb [signed-by=/etc/apt/keyrings/keys.anydesk.com.asc] https://deb.anydesk.com all main" | sudo tee /etc/apt/sources.list.d/anydesk-stable.list > /dev/null

# Update apt caches and install the AnyDesk client
sudo apt update
sudo apt install anydesk

# Instalar Spotify
echo Instalando Spotify
curl -sS https://download.spotify.com/debian/pubkey_C85668DF69375001.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb https://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update && sudo apt-get install spotify-client

# Instalar LibreOffice
echo Instalando LibreOffice
sudo apt install libreoffice -y
sudo apt install libreoffice-l10n-pt-br -y

# Instalar AWS CLI
echo Instalando AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
aws --version

# Instalar GIMP
echo Instalando GIMP
sudo apt install gimp -y

# Informações finais
echo
echo "✅ Instalações concluídas!"
echo "🔹 Reinicie ou faça logout/login para ativar o grupo Docker."
#echo "🔹 Jenkins: http://localhost:8080"
echo "🔹 Cockpit: https://localhost:9090"
#echo "🔹 Diretórios criados em ~/devops/"
echo
echo "🚀 Script executado com sucesso!"

