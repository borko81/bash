#!/bin/bash

echo
echo Please choice one options
echo
echo 'clear = Clear screen'
echo 'memory = Show memory usage'
echo 'hard = Show hard drive capasity'
echo

read choice

case $choice in 

    clear) clear;;
    memory) free -h;;
    hard) df -h;;
    *) echo Invalid chice;;

esac
