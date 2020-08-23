#!/bin/bash
# Create file if not exists
# show timestamp if file exists

clear

echo -n "Enter path :"
read pathname

if [ -e $pathname ]
    then
    echo Path is Ok
    ls -l $pathname
    else
    echo Path is missing
    echo -n "Do you want to create file (yes or no) :"
    read answer

    if [ $answer == yes ]
        then
            touch $pathname
    
            if [ $? -eq 0 ]
                then
                echo File $pathname create successfuly
                else
                echo Something wrong while try to create filename
            fi
        else
        echo Ok Buy
    fi
fi
