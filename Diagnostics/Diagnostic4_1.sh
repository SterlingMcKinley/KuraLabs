#!/bin/bash
#
# ======================================================================
# AUTHOR				DATE		 COMMENTS/UPDATES
# ----------------- ----------- --------------------------------
# Sterling McKinley	 2022-08-13	  Initial version
#
# Description: This script will check if a server is online. If yes, SSH into the server.
#
#
#
# SCRIPT NAME: Diagnostic4_1.sh
# ======================================================================
ip=35.175.185.239
domain=ec2-35-175-185-239.compute-1.amazonaws.com

echo "Checking if $ip & $domain are online"

ssh -t ConnectTimeout=5 35.175.185.239 'exit 0'

if [ $? -eq 0 ];
then
    echo "Server $ip is online"
    echo " "
    ssh -i Cali1.pem ubuntu@$ip
else
    echo "Host $ip is offline and unable to connect. Please contact your system administator."
fi
