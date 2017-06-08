#!/bin/bash 

cd /share/malooflab/Ruijuan/505/late_silique_bam_file
sample=`cat sample_list_2`
echo $sample

for i in $sample
	do
	echo $i >> out
	awk '{print $3}' Sample_${i}/ABC/J.depth | sort | uniq >> out  
done
