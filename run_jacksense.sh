#!/bin/bash

headphone=$(amixer controls | grep 'Headphones Jack')
#echo $headphone
numid=$(echo $headphone | sed 's/,.*//g')
#echo $numid
result=$(amixer cget $numid | grep -c off)
#echo $result
if [ $result == 1 ] ; then
echo "headphone is un-plugged in"
sudo cx-jack-speaker.sh
else
echo "headphone is plugged"
sudo cx-jack-headphone.sh
fi
sudo cxjacksense /dev/input/event2
