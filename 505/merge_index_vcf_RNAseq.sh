#!/bin/bash 

module load vcftools/0.1.15
cd /share/malooflab/Ruijuan/505/vcf_no_pop_late_silique/all

file=`ls *.vcf`
for i in $file	
	do
	echo $i	
        bgzip $i
        tabix -p vcf $i.gz
done

