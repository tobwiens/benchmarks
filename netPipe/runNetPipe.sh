#!/bin/bash

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
		# Construct array to ping other nodes
		declare -a pingList
		while read -r pingNode
		do
			if [ "$pingNode" != "$MY_IP" ];
			then
				# Add IP to ping list
				pingList+=($pingNode)
			else
				# I don't need to ping myself
				# So jump over me and look at the
				# next node because that will be
				# the next one in the order to connect
				# to other nodes. Therefore it will
				# come as last to the list to not cause 
				# timeouts.
				last=$(read -r)
				echo "Last node is $last"
			fi
		done
		pingList+=($last)
		echo "${pingList[@]}"
		for toPing in "${pingList[@]}"
		do	
			if [ "$toPing" != "$MY_IP" ];
			then
				echo "Start best case tcp test with $toPing"
				NPtcp -h $toPing | tee "logs/bestCase$toPing.log"
				echo "Start worst case tcp test with $toPing"
				NPtcp -I -h $toPing | tee "logs/worstCase$toPing"
			fi
 		done
	 else
	 echo "Waiting for $line to connect for best case test."
                NPtcp
                echo "Waiting for $line to connect for worst case test."
                NPtcp -I

	fi
	
done < "$filename"


