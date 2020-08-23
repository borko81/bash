#!/bin/bash

count=0
num=10

while [ $count -le $num ]
do
    echo -ne "$num\r\r"
    sleep 1
((num--))
done
