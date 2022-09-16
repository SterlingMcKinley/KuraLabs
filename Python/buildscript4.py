#!/bin/python3
# ======================================================================
# SCRIPT NAME: buildscript4.py
# Description: This script will access data from an API & format that
#               data into a specific format.
#
# REVISION HISTORY: N/A
#
# AUTHOR		   DATE			DETAILS
# --------------------- --------------- --------------------------------
# Sterling McKinley	 2022-09-10	  Initial version
#
# ======================================================================

# Importing librairies
import requests    
import json
import subprocess

print("\nNational Basketball Association maintains a huge amount of statistics & player data. Lets explore an API to retrieve that information.")
print("\n")

#While Loop to make the script interactive
while True:
    print("Which ACTIVE NBA player data would you like to retrieve.....")
    fname = input(
        "The FIRST name of the player you are interested in is: >>>>>")
    lname = input(
        "The LAST name of the player you are interested in is: >>>>>")
    print("\n")
    fullname = f"{fname}_{lname}"
    print("Ok, lets pull some data for", fullname)

    #Specifying the API URL, QUERY STRING & HEADERS
    url = "https://nba-player-individual-stats.p.rapidapi.com/players/fullname"

    querystring = {"name": fullname}

    headers = {
        "X-RapidAPI-Key": "139e18007bmshe1e5ca838574d56p16b58cjsn6710ad9fae34",
        "X-RapidAPI-Host": "nba-player-individual-stats.p.rapidapi.com"
    }

	#Making a get request
    response = requests.get(url, headers=headers, params=querystring).json()

    # print json content
    print(response)


    #Writing json data to text file
    with open("nba_api_data.json", "w") as jsonfile:
        json.dump(response, jsonfile, indent=4)

    print("\n Please be aware data will be ALL API response data will be collected in nba_api_data.json. \n")

    # converting json file using subprocess library/module & executing bash commands
    subprocess.call(["sed -i -e 's/,//g' nba_api_data.json"], shell=True)
    subprocess.call(["sed -i 's/:/,/g' nba_api_data.json"], shell=True)
    subprocess.call(["sed -i 's/\"//g' nba_api_data.json"], shell=True)
    subprocess.call(["sed 's/$/,/' nba_api_data.json > nba_api_data.csv"], shell=True)

    # Ask if user would like to select another NBA player to retrieve data
    again = input(
        "Would you like to select another again to retrive data? (y/n): ")
    print()
    if again.lower() != "y":
        break
