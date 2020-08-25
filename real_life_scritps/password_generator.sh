#!/bin/bash
# random password generate with openssl

FILE=password_result.txt

read -p "Enter length of password :" LENGTH
read -p "Enter how much variant generate :" SEQ

if [ -f "$FILE" ];then
    rm "$FILE"
fi

for p in $(seq $SEQ);do
    openssl rand -base64 48 | cut -c1-$LENGTH >> $FILE
done

cat $FILE

