#!/bin/sh

logs=logs/$MY_IP/netPipe

mkdir -p $logs

filename=$1
while read -r line 
do
	echo "Processing entry: $line."
	if [ "$line" = "$MY_IP" ];
	then
		echo "Wait some time to be sure that the first machine is listening"
		sleep 40s
		while read -r toPing
		do	
			if [ "$toPing" != "$MY_IP" ];
			then
				echo "Start best case tcp test with $toPing"
				NPtcp -h $line | tee "logs/bestCase$toPing.log"
				echo "Start worst case tcp test with $toPing"
				NPtcp -I -h @line | tee "logs/worstCase$toPing"
			fi
 		done < "$filename"
	 else
	 echo "Waiting for $line to connect for best case test."
                NPtcp
                echo "Waiting for $line to connect for worst case test."
                NPtcp -I

	fi
	
done < "$filename"


