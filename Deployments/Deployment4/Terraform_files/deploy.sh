#!/bin/bash

sudo apt update 
sudo apt -y install git
sleep 3
sudo apt -y install python3-pip
sleep 3
git clone https://github.com/kura-labs-org/kuralabs_deployment_3.git
sleep 2
cd kuralabs_deployment_3/
pip install -r requirements.txt
pip install gunicorn
python3 -m gunicorn -w 4 application:app -b 0.0.0.0 --daemon
