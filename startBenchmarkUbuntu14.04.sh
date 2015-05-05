#! /bin/bash

# Create unique folder name
folderName=`date +%Y.%m.%d-%H:%M:%S`
# Clean logs and create folder for logs
rm -rf logs
mkdir logs

# Initialize logs directory
echo "$folderName" > logs/time.log
ifconfig > logs/ifconfig.log
lscpu > logs/lscpu.log
lshw > logs/lshw.log
lspci > logs/lspci.log
lsscsi > logs/lsscsi.log
lsusb > logs/lsusb.log
lsblk > logs/lsblk.log
df > logs/df.log
pydf > logs/Pydf.log
free > logs/free.log
dmidecode > logs/dmidecode.log

# Start stream benchmark 
stream/runStreamUbuntu14.04.sh $MY_IP  stream/ubuntu14.04x64

# Start LINPACK benchmark

# Start netPipe
netPipe/runNetpipe.sh
# Commit logs

# Push logs:wqq
git add --all logs/
git commit -m "Current benchmark $folderName from $MY_IP"
# Push with force to just overwrite the logs, so each push is one logs entry
git push -f	
