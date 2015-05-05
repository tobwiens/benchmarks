#!/bin/bash

echo 'Start STREAM benchmark (Ubuntu)'
logs="logs/$1/stream/"
echo "Save logs in $logs"
# Create directory
mkdir $logs

# Get all stream executables
executables=$(ls $2)

echo "Found following benchmarks: $exectuables"

for benchmark in $executables; do
	echo "Execute benchmark $benchmark"
	"$2/$benchmark" > "$logs$benchmark.log" 
done
