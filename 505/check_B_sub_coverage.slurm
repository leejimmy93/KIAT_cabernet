#!/bin/bash 
cd /share/malooflab/Ruijuan/505/late_silique_bam_file
sample=`cat sample_list_2`
echo $sample

for i in $sample	
	do
	echo $i
	cd Sample_${i}/ABC/
	cat J*depth > J.depth
	cd ..
	cd ..
done
