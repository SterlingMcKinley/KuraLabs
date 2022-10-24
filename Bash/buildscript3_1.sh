#!/bin/bash

#Creating dummy files to produce data
echo "In an effort to produce files & data. 3 files will be created..."
echo "file1.txt, file2.txt, file3.txt"

touch file1.txt;chmod 755 file1.txt

echo -e "Full Name []: Linus Torvald  \n Room Number []:  \n Work Phone []: 111-111-1111 \n Home Phone []: 333-333-333 \n Other []: " >> file1.txt
echo -e "Full Name []: Brian Fox \n  Room Number []:  \n Work Phone []: 222-222-222 \n Home Phone []: 155-956-0177 \n Other []: " >> file1.txt

touch file2.txt;chmod 755 file2.txt
echo -e "Full Name []: Guido van Rossum \n Room Number []:  \n Work Phone []: 333-333-3333 \n Home Phone []: \n Other []: " >> file2.txt

touch file3.txt;chmod 755 file3.txt
echo -e "Full Name []: James Gosling \n Room Number []:  \n Work Phone []: \n Home Phone []: \n Other []: " >> file3.txt

sleep 2s

#Providing a status of the git repo
git status

echo " "
echo "Would you like to COMMIT the files in this directory to the .git repository?"
read -p input

input=$(echo "$input" | cut -c 1 | tr [A-Z] [a-z])

if [[ $input == 'y' ]];
then
    git add . # add [ALL files] working area to staging area
    git commit -m "committing files.txt files2.txt files3.txt" #Commit [ALL files] from the staging area to repo w/ a msg
    git status #Check to see what was committed
    echo "---------------------------------------------------"
    echo "Files c"
else
    echo "No files will be committed to the repository" 1>&2
    exit 1
fi

#Asking if user would like to push commits
read -p "Would you like to PUSH to a remote GitHub repository? YES or NO? >>>>> " input

input=$(echo "$input" | cut -c 1 | tr [A-Z] [a-z])

if [[ $input == 'y' ]];
then
    sleep 1s
    echo " WAIT! I must scan files for sensitve data/content"
    echo "---------------------------------------------------"
    sleep 3s
else
    echo "No recent commits will be pushed to the remote GitHub repository."
fi

#using grep to find sensitive data/phone numbers
egrep '\(?[0-9]{3}[ )-]?[0-9]{3}[ -]?[0-9]{4}' f1.txt f2.txt f3.txt
if [[ $? == 0 ]];
then
    echo "Sensitive data has been found. Pushing the local repo to the remote GitHub repo is unable to be completed."
else
    #push commits made on your local branch to a remote repository
    git push
    git log --oneline --graph --all
fi

