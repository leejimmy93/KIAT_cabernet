#!/bin/bash 
module load vcftools/0.1.15
cd /share/malooflab/Ruijuan/505/WGS/SNP_parallel

file=`ls *.vcf`
for i in $file	
	do
	echo $i	
        bgzip $i
        tabix -p vcf $i.gz
done

cd /share/malooflab/Ruijuan/505/WGS/SNP_parallel_2

file=`ls *.vcf`
for i in $file
        do
        echo $i
        bgzip $i
        tabix -p vcf $i.gz
done
