#!/usr/bin/env bash

VAL=10

if [[ "$1" == "get" ]]; then
    VOL=$(ddcutil getvcp 10 | cut -c 66- | cut -f1 -d",")
    #VOL=$(echo $VOL | cut -c 66-)
    #VOL=$(echo $VOL | cut -f1 -d",")
    VOL=$(echo ${VOL//[[:blank]]/})
    echo "$VOL"
    #echo "hhh"
elif [[ "$1" == "inc" ]]; then
    VOL=$(ddcutil getvcp 10 | cut -c 66- | cut -f1 -d",")
    VOL=$(echo ${VOL//[[:blank]]/})
    VOL=$(($VOL + $VAL))
    if [ $VOL -le 100 ];then
        ddcutil setvcp 10 $VOL
    fi
    echo "$VOL"
elif [[ "$1" == "dec" ]]; then
    VOL=$(ddcutil getvcp 10 | cut -c 66- | cut -f1 -d",")
    VOL=$(echo ${VOL//[[:blank]]/})
    VOL=$(($VOL - $VAL))
    if [ $VOL -gt 0 ];then
        if [ $VOL -le 100 ]; then
            ddcutil setvcp 10 $VOL
        fi
    fi
    echo "$VOL"
fi
