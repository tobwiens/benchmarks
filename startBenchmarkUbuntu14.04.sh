#! /bin/bash

# Create unique folder name
folderName=`date +%Y.%m.%d-%H:%M:%S`

# Create folder for logs
mkdir logs/$folderName

# Start stream benchmark 
stream/runStreamUbuntu14.04.sh $folderName stream/ubuntu14.04x64

# Start LINPACK benchmark

# Commit logs

# Push logs:wqq
git add logs/$folderName
git commit -m "Current benchmark $folderName"
git push	
