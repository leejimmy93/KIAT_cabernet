#!/bin/bash

start=`date +%s`
module load fastqc/0.11.2 

## Identify each array run
cd /share/malooflab/Fastqs/KIAT/505/WGS
sample=`cat sample_list`
 
for i in $sample
	do echo $i
	fastqc ${i} -o /share/malooflab/Ruijuan/505/WGS/QC/raw
done

end=`date +%s`
runtime=$((end-start))
echo $runtime seconds to completion
