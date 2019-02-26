#!/bin/bash 

cd /share/malooflab/Ruijuan/505/WGS/mapping_cabernet

sample=`cat sample_list_mapping_47_Samples`

for i in $sample
	do
	echo $i
	rm ${i}.bam
	rm ${i}/*
	rm -rf ${i}
done 



