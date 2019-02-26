#!/bin/bash 

module load samtools/1.5
sample=`echo chrC05 chrC07 chrC08`

cd /share/malooflab/Ruijuan/505/WGS/mapping_cabernet
for i in $sample
	do
	echo $i
	samtools depth */${i}.bam > /share/malooflab/Ruijuan/505/WGS/depth/${i}.depth
done
