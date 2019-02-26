#!/bin/bash
aklog
start=`date +%s`

## Load required modules

module load freebayes/1.2.0
module load samtools/1.5

## Identify each array run
cd /share/malooflab/Ruijuan/505/WGS/mapping_cabernet
echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
chrom=`sed "1q;d" chrom_list_test`

bams=`ls K100_S286_L003/${chrom}.bam`

echo ${chrom}
echo ${bams}

freebayes -f /share/malooflab/John/KIAT/Reference/Split_Chroms/${chrom}.fa \
    ${bams} \
    --no-population-priors \
    --report-genotype-likelihood-max \
    --genotype-qualities \
    > /share/malooflab/Ruijuan/505/WGS/SNP/test_cabernet/test_${chrom}.vcf

end=`date +%s`
runtime=$((end-start))
echo $runtime seconds to completion
