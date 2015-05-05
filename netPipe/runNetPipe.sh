#!/bin/sh

logs=logs/netPipe/$MY_IP

mkdir $logs

filename=$1
while read -r line 
do
	echo "Processing entry: $line."
	if [ "$line" = "$MY_IP" ];
	then	
		echo "Wait..."
		sleep 10s
		echo "Start best case tcp test with $Line"
		NPtcp -h $line | tee "bestCase$line.log"
		echo "Start worst case tcp test with $line"
		NPtcp -I -h @line | tee "worstCase$line"
	else
		echo "Listen for netPipe best case tcp test"
                NPtcp
                echo "Worst case test"
                NPtcp -I
	fi
	
done < "$filename"


