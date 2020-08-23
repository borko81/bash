#!/bin/bash

# For loop examples
clear

number_count=1
FOLDER=`pwd`

for file in `ls $FOLDER`
    do
        if [[ $file == *bash ]]
            then
            echo $((number_count++)) $file
        fi
done
