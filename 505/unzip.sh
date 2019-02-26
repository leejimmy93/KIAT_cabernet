#!/bin/bash 

cd /share/malooflab/Ruijuan/505/WGS/QC_47_Samples/raw

sample=`ls | grep "zip"`

for i in $sample
	do
	echo $i
	unzip $i
done
