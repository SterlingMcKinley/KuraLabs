#!/bin/bash

#Installing & Updating Dependencies
sudo apt update -y
sudo apt install default-jre -y
sudo apt install python3.10-venv -y
sudo apt install python3-pip -y

# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh

sudo sh get-docker.sh

#Updating Dependencies
sudo apt update && sudo apt upgrade -y
