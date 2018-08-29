#!/bin/bash 

module load samtools/1.5
cd /share/malooflab/Ruijuan/505/WGS/mapping_cabernet

sample=`cat sample_list_mapping`

for i in $sample
	do
	echo $i
	samtools flagstat ${i}.bam > ${i}/${i}.stats
	samtools flagstat ${i}/final.bam > ${i}/final.stats
done

