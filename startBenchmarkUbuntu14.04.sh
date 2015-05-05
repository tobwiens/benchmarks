#! /bin/bash

# Create unique folder name
folderName=`date +%Y.%m.%d-%H:%M:%S`
# Clean logs and create folder for logs
rm -rf logs
mkdir logs

# Start stream benchmark 
stream/runStreamUbuntu14.04.sh $MY_IP  stream/ubuntu14.04x64

# Start LINPACK benchmark

# Commit logs

# Push logs:wqq
git add logs/
git commit -m "Current benchmark $folderName from $MY_IP"
git push	
