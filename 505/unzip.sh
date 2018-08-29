#!/bin/bash 

cd /share/malooflab/Ruijuan/505/WGS/QC/trimmed

sample=`ls | grep "zip"`

for i in $sample
	do
	echo $i
	unzip $i
done
