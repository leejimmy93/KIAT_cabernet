#!/bin/bash 

module load samtools/1.5
sample=`echo chrA04 chrA08 chrA09`

cd /share/malooflab/Ruijuan/505/WGS/mapping_cabernet
for i in $sample
	do
	echo $i
	samtools depth */${i}.bam > /share/malooflab/Ruijuan/505/WGS/depth/${i}.depth
done
