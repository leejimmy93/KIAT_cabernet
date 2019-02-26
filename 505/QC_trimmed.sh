#!/bin/bash

start=`date +%s`
module load fastqc/0.11.2 

## Identify each array run
cd /share/malooflab/Fastqs/KIAT/505/WGS_47_Samples
sample=`cat sample_list_trimming`
 
cd /share/malooflab/Ruijuan/505/WGS/trimmed_47_Samples

for i in $sample
	do echo $i
	fastqc ${i}/${i}_paired_1.fq.gz -o /share/malooflab/Ruijuan/505/WGS/QC_47_Samples/trimmed
	fastqc ${i}/${i}_paired_2.fq.gz -o /share/malooflab/Ruijuan/505/WGS/QC_47_Samples/trimmed
done

end=`date +%s`
runtime=$((end-start))
echo $runtime seconds to completion
