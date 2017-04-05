#!/bin/bash 

jobs=`cat job_ID`

for i in $jobs
	do
	scancel $i
done 
