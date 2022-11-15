#!/bin/bash

#Updating Dependancies
sudo apt update -y
sudo apt install default-jre -y
sudo apt install python3.10-venv -y
sudo apt install python3-pip -y

#downloading Terraform
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg

#copying keys
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

#Installing Terraform
sudo apt update && sudo apt install terraform -y

#Updating Dependancies
sudo apt update && sudo apt upgrade -y
