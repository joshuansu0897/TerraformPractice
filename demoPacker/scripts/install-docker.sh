 
#!/bin/bash
# Instalar Docker
sudo apt-get update
sudo apt-get remove docker docker-engine docker.io
sudo apt install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl https://get.docker.com/ | sudo bash
sudo systemctl start docker
sudo systemctl enable docker

#Agregar el usuario ubuntu al grupo docker
sudo groupadd docker
sudo usermod -aG docker ubuntu

# Instalar docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
