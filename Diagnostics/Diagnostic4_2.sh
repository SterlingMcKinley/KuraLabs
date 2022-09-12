#!/bin/bash
#
# ======================================================================
# AUTHOR				DATE		 COMMENTS/UPDATES
# ----------------- ----------- --------------------------------
# Sterling McKinley	 2022-08-13	  Initial version
#
# Description: This script will send a file to a remote server, check for
#               a file a remote server and tells the user the file exist
#                   on the server.
#
# SCRIPT NAME: Diagnostic4_2.sh
# ======================================================================
key=Cali.pem
ip=35-175-185-239
file=sterling.txt
location=/home/ubuntu/sterling

scp -i $key $file ubuntu@$ip:$location/$file

ssh -i $key ubuntu@$ip -t "ls $location"

if [ $? -eq 0 ];
then
    echo "$file exists on $ip"
else
    echo "Host $ip is offline and unable to connect. Please contact your system administator."
fi