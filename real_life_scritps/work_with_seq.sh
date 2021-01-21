#!/bin/bash

for i in 1 2 5 6;do
    echo -n "$i "
done
echo -e "\nSecond"
# Second

for i in {1..10..2};do
    echo -n "$i "
done

# Third
echo -e "\nThird"


for ((i=1; i<=10; i+=1));do
    echo -n "$i "
done

# Four
echo -e "\nFour"
for i in {1..10};do
    out=$(( $i % 2 ))
    if [ $out -eq 1 ];then
        echo -n "$i "
    else
        echo -e "\n"
        echo -n "$i is not odd"
    fi
done

echo -e "\nFive"
c=1
while [ $c -lt 10 ];do
    echo -n "$c "
    (( c=$c+1 ))
done

echo -e "\nSix"
for i in {1..10};do
    rem=$(( $i%2 ))
    if [ $rem -eq 0 ];then
        echo -n "$i "
    fi
done
