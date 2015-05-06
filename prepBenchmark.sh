#!/bin/bash

# Clone benchmark repository
echo 'Clone benchmark repository, ssh key must be configured'
git clone git@github.com:tobwiens/benchmarks.git

# Install dependencies
cat benchmarks/installDependencies.sh | sh

echo "Enter save correct IP address in MY_IP environment variable" 
echo "Make sure that node.list is up to date"

echo "Update git variables"

git config --global user.email 'tobwiens@gmail.com'
git config --global user.name 'Benchmark'

git config --global push.default simple
