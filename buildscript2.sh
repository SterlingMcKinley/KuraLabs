#!/bin/bash
# ======================================================================
# AUTHOR				DATE		COMMENTS/UPDATES
# ----------------- ----------- --------------------------------
# Sterling McKinley	 2022-08-06	  Initial version
#
# Description: This script will automatically check the server’s processes and 
#               system performance.
#               After analyzing the server's performance, the script will make suggestions
#               as well as ask if the user to terminate a process(es) utilizing resources.
#
#
#
# SCRIPT NAME: buildscript2.sh
# ======================================================================

#Creating Variables
plog=~/server_performance_logs

up=$(uptime -p | cut -d " " -f2)
uplim=30
free=$(free -t | awk 'FNR == 2 {printf(" %.2f%"), $3/$2*100}')
freelim=90.0
fs=$(df -Ph | grep -vE '^tmpfs|cdrom' | sed s/%//g | awk '{ if($5 > 60) print $0;}')
fstop=$(df -Ph | grep -vE '^tmpfs|cdrom' | sed s/%//g | awk '{if($5 >60) print $5;}' | sed -n '1!p')
fslim=60.0
#fshigh=$(echo "$fs" | wc -l)
fshigh=$(df -Ph | grep -vE '^tmpfs|cdrom' | sed s/%//g | awk '{if($5 >60) print $5;}' | sed -n '1!p' | head -1)
fstop=$(df -Ph | grep -vE '^tmpfs|cdrom' | sed s/%//g | awk '{ if($5 > 60) print $1,$2,$3,$5;}')
proclim=15.0
proc=$(ps -e o pid,%mem,%cpu,comm --sort=-%mem | awk '{if($2 >15.0) print $2;}' | head -1 )
proctop=$(ps -e o pid,%mem,%cpu,comm --sort=-%mem | head -6)
procout=$(ps -e o pid,%mem,%cpu,comm --sort=-%mem | awk '{if($2 >15.0) print $1,$2,$4;}')

echo " "
echo "THIS SCRIPT WILL AUTOMATICALLY CHECK $HOSTNAME PROCESSESS & SYSTEM PERFORMANCE"
echo "=================================================================================="
echo "=================================================================================="


#Creating directory for logs
if [ ! -d "$plog" ];
then
    mkdir "$plog";chmod -R 755 "$plog" && echo "PLEASE BE AWARE PERFORMANCE LOGS WILL RESIDE IN ~/server_performance_logs DIRECTORY."
fi
#echo " Please provide your email address to provide server/system performance stats."

#read -r email
echo " "
echo " "


echo "CHECKING THE CURRENT SERVER/SYSTEMS'S PERFORMANCE.....PLEASE WAIT"
sleep 2s

echo " Analyzing...."
echo ".."
sleep 1s
echo "..."
sleep 1s
echo "...."
sleep 1s
echo "....."
sleep 1s
echo "......"
echo " "
echo "HERE IS $HOSTNAME SERVER/SYSTEMS'S PERFORMANCE:"
echo " "

#executing Performance commands
echo " "
echo "CHECKING HOW LONG $HOSTNAME HAS BEEN RUNNING....."
uptime
uptime >> $plog/server_performance"$(date +"%M-%d-%Y %T")".log
echo " "
echo "--------------------"
echo "--------------------"
echo " "
echo "CHECKING $HOSTNAME FILESYSTEM UTILIZATION"
echo " "
df -Ph
df -Ph >> $plog/server_performance"$(date +"%M-%d-%Y %T")".log
echo " " 
echo "--------------------"
echo "--------------------"
echo " "
echo "CHECKING $HOSTNAME MEMORY UTILIZATION"
echo " "
free -m
free -m >> $plog/server_performance"$(date +"%M-%d-%Y %T")".log
echo " " 

echo "--------------------"
echo "--------------------"
echo " " 
echo " " 


# IF | THEN | ELSE statements for Performance Recommendations/Suggestions
echo " "
echo " "
echo "PERFORMANCE RESULTS and/or RECOMMENDATIONS/SUGGESTIONS"
echo " "
if [ "$up" \> "$uplim" ];
then
    echo "Server $HOSTNAME has been up for ${up} days. Please consider recycling $HOSTNAME at the APPROPRIATE time."
    echo "Server $HOSTNAME has been up for ${up} days. Please consider recycling $HOSTNAME at the APPROPRIATE time." >> $plog/server_performance"$(date +"%M-%d-%Y %T")".log

else
    echo "Server $HOSTNAME is HEALTHY.; $HOSTNAME days running = $up days. Has not been running for an extended amount of time."
    echo "Server $HOSTNAME is HEALTHY.; $HOSTNAME days running = $up days. Has not been running for an extended amount of time." >> $plog/server_performance"$(date +"%M-%d-%Y %T")".log

fi

echo " "
echo " "

if [ "$fshigh" \> "$fslim" ];
then
    echo "Server $HOSTNAME has HIGH FILESYSTEM UTILIZATION." 
    echo "Server $HOSTNAME has HIGH FILESYSTEM UTILIZATION." >> $plog/server_performance"$(date +"%M-%d-%Y %T")".log
    echo " "
    echo "Here are the current filesystems that exceeds the threshold of $fslim% "
    echo " "
    echo "$fs"
    echo " "
    echo "Please do either of the following:" 
    echo "Please do either of the following:" >> $plog/server_performance"$(date +"%M-%d-%Y %T")".log
    echo "1- Compress uncompressed logs or large files." 
    echo "1- Compress uncompressed logs or large files." >> $plog/server_performance"$(date +"%M-%d-%Y %T")".log 
    echo "2- Remove large unwanted files "
    echo "2- Remove large unwanted files " >> $plog/server_performance"$(date +"%M-%d-%Y %T")".log
    echo "3- Move files to a backup drive or to the cloud"
    echo "3- Move files to a backup drive or to the cloud" >> $plog/server_performance"$(date +"%M-%d-%Y %T")".log
else
    echo "$HOSTNAME FILESYSTEM UTILIZATION is HEALTHY and currently below the threshold."
fi

echo " "
echo " "

if [ "$free" \> $freelim ];
then
    echo "$HOSTNAME is currently experiencing HIGH MEMORY UTILIZATION at ${free}. Please investigate current jobs and/or processes running on this server." 
    echo "$HOSTNAME is currently experiencing HIGH MEMORY UTILIZATION at ${free}. Please investigate current jobs and/or processes running on this server." >> $plog/server_performance"$(date +"%M-%d-%Y %T")".log

else
    echo "$HOSTNAME MEMORY UTILIZATION is HEALTHY." &&  echo "Memory usuage is currently stable at${free} and managing today's load." 
    echo "$HOSTNAME MEMORY UTILIZATION is HEALTHY. Memory usuage is currently stable at${free} and managing today's load." >> $plog/server_performance"$(date +"%M-%d-%Y %T")".log

fi


echo " "
echo " "


#Asking if user would like to terminate aprocess that exceeded a certain amount
if [ "$proc" \> "15.0" ];
then
    echo " "
    echo "Here are the top 5 processes running on server $HOSTNAME"
    echo "$proctop"
    echo " "
    echo "Here are the current processes that exceeds the threshold of $proclim% "
    echo "$procout"
    echo " "
    echo "Would you like to terminate any process? (yes or no)"
    echo " "
    read -r ans
    echo "-------------------------------"
else
    echo "No processes are consuming more than 15% threshold"
fi

#Script can be broken if the input is missing or provided incorrectly. (ie Integer or Boolean inputs)
ans2=$(echo "$ans" | cut -c 1 | tr '[:upper:]' '[:lower:]')

if [[ ${ans2} == "y" ]];
then
    echo " Please specify the PID of the running process you would like to terminate? (Numbers Only)"
    echo " "
    read -r pid
    echo " "
    echo " Please confirm PID selection. Is PID $pid is the correct process to be terminated? (yes or no)"
    echo " "
    read -r ans3
    echo "-------------------------------"
fi

ans3=$(echo "$ans3" |cut -c 1 | tr '[:upper:]' '[:lower:]')

if [ "$ans3" == "y" ];
then 
    sudo kill -15 "$pid" && echo " PID $pid terminated. Please review memory utilization has returned to a healthy threshold."
echo " "
echo " "
else
    echo "No processes were terminated."
fi