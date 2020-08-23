#!/bin/bash
clear

count=0
num=10
rev_count=`expr $num + 1`

while [ $count -lt $num ]
do
    echo "$num - `expr $rev_count - $num`"
num=`expr $num - 1`
done
