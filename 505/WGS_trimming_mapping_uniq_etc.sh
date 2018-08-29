#!/bin/bash

module load samtools/1.3

# convert to bam and sort 
cd /share/malooflab/Ruijuan/505/WGS/mapping_cabernet

sample=`echo SJ_197_S481_L003 SJ_205_S489_L003 SJ_207_S487_L003`

for i in $sample
        do
        echo $i
	samtools view ${i}_tmp1.sam -bT /share/malooflab/Ruijuan/reference/Brassica_napus_v4.1.chromosomes.fa -@ 10 > ${i}_tmp1.bam
	samtools sort -@ 10 ${i}_tmp1.bam > ${i}.bam
	rm ${i}_tmp1.sam
        rm ${i}_tmp1.bam
done
