#!/bin/bash

# Download Java Runtime Environment 
sudo apt update && sudo apt install default-jre -y

# Get the key to access Jenkins package
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo gpg --dearmor -o/usr/share/keyrings/jenkins.gpg

# Using the key to authenticate the package
sudo sh -c 'echo deb [signed-by=/usr/share/keyrings/jenkins.gpg] http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

# Update & install Jenkins
sudo apt update && sudo apt install jenkins -y

# Start Jenkins & check availability status 
sudo systemctl start jenkins
sudo systemctl status jenkins >> ~/file.txt
