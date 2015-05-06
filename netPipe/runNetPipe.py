#!/usr/bin/env python
import os
import time
from subprocess import call

print 'Start netpipe benchmark'

nodesFile = open ("netPipe/nodes.list", "rb")

nodesList = []

for line in nodesFile:
	nodeIp = line.replace('\n','')
	nodeIp = nodeIp.replace('\r', '')
	nodesList.append(nodeIp)
MY_IP= str(os.environ.get("MY_IP")).replace(' ', '')

# Close file
nodesFile.close()

for element in nodesList:
	print element

print 'My IP address is '+ MY_IP

# Go through all IP addresses
for ip in nodesList:
	print 'Processing IP: '+str(ip)
	if ip == MY_IP:

		print 'Entry in list is my IP'
		# Create array which stores the order of pinging other nodes
		pingList = []
		wasMyIP= False
		for entry in nodesList:
			# The node after me is necxt, so it will be pinged last
			if wasMyIP is True:
				wasMyIP = False
				lastNode = entry
				continue
			if entry != MY_IP:
				pingList.append(entry)

		print 'Print ping list'
		for entry in pingList:
			print entry
		time.sleep(40)
		print 'Start pinging nodes'
		
		for entry in pingList:
			print 'Do best case benchmark with '+str(entry)
			call(["/bin/bash", "-c","NPtcp -h " +str(entry)+ ' | tee logs/bestCase'+str(entry)+'.log'])
			print 'Do worst case benchmark with '+str(entry)
                        call(["/bin/bash", "-c","NPtcp -I -h " +str(entry)+ ' | tee logs/worstCase'+str(entry)+'.log'])




	else:
		print 'Wait for '+str(ip)+' to connect for best case test.'
		call(["NPtcp"])
		print  'Wait for '+str(ip)+' to connect for worst case test.'
		call(["NPtcp"])

print 'Benchmark done!!!!'
