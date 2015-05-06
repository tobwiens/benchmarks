#!/usr/bin/env python
import os
import time
import subprocess

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
		wasMyIP = False
		for entry in nodesList:
			# The node after me is necxt, so it will be pinged last
			if wasMyIP is True:
				wasMyIP = False
				lastNode = entry
				continue
			if entry != MY_IP:
				pingList.append(entry)
			else:
				wasMyIP = True
		# Add last entry to list
		pingList.append(lastNode)
		print 'Print ping list'
		for entry in pingList:
			print entry
		time.sleep(4)
		print 'Start pinging nodes'
		
		# A little waiting time is needed
		#time.sleep(5)		
		for entry in pingList:
			print 'Do best case benchmark with '+str(entry)
			for i in range(1000):
				output = subprocess.check_output(["/bin/bash", "-c","NPtcp -h " +str(entry)+ ' | tee logs/bestCase'+str(entry)+'.log'])
				# Always when something goes wrong errno appears in the output
				if "errno" in output:
					print 'Execution failed do it again'
					time.sleep(1)
				else:
					# Break loop
					print 'Benchmark successful... continue.'
					break
			
			print 'Do worst case benchmark with '+str(entry)
                        for i in range(1000):
				output = subprocess.check_output(["/bin/bash", "-c","NPtcp -I -h " +str(entry)+ ' | tee logs/worstCase'+str(entry)+'.log'])
				 # Always when something goes wrong errno appears in the output
                                if "errno" in output:
                                        print 'Execution failed do it again'
                                        time.sleep(1)
                                else:
                                        # Break loop
                                        print 'Benchmark successful... continue.'
                                        break





	else:
		print 'Wait for '+str(ip)+' to connect for best case test.'
		subprocess.call(["NPtcp"])
		print  'Wait for '+str(ip)+' to connect for worst case test.'
		subprocess.call(["NPtcp"])

print 'Benchmark done!!!!'
