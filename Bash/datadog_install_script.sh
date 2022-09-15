#!/bin/bash
#
# ======================================================================
# AUTHOR				DATE		 COMMENTS/UPDATES
# ----------------- ----------- --------------------------------
# Sterling McKinley	 2022-09-14	  Initial version
#
# Description: This script will install Datadog while updating packages
#               & dependancies
#
# SCRIPT NAME: datadog_install_script.sh
# ======================================================================

#Updating packages/dependancies & Downloading Curl
sudo apt update && sudo apt install curl -y

#Command to fully install Datadog-agent
DD_AGENT_MAJOR_VERSION=7 DD_API_KEY=9d76859b01bd94f89408e8497663a411 DD_SITE="us5.datadoghq.com" bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script.sh)"

#Start Agent as a service
sudo service datadog-agent start

#Status of Agent service
sudo service datadog-agent status