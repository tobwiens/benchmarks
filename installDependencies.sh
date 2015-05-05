#!/bin/bash

apt-get update
# Install all dependencies for the benchmarks

# NetPipe
apt-get install netpipe-tcp -y

# Hardware information tools
apt-get install -y lsscsi pydf

# GIT
apt-get install -y git 
