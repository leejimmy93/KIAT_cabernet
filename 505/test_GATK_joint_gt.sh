#!/bin/bash 

module load gatk/3.6

cd /share/malooflab/Ruijuan/505/WGS/SNP_GATK

# gatk -T CombineGVCFs -R /share/malooflab/Ruijuan/reference/Brassica_napus_v4.1.chromosomes.fa -V vcfs_1.list -o /share/malooflab/Ruijuan/505/WGS/SNP_GATK_combine/out_1.vcf

# gatk -T CombineGVCFs -R /share/malooflab/Ruijuan/reference/Brassica_napus_v4.1.chromosomes.fa -V vcfs_2.list -o /share/malooflab/Ruijuan/505/WGS/SNP_GATK_combine/out_2.vcf

cd /share/malooflab/Ruijuan/505/WGS/SNP_GATK_combine
gatk -T GenotypeGVCFs -R /share/malooflab/Ruijuan/reference/Brassica_napus_v4.1.chromosomes.fa -V vcfs_1.list -o /share/malooflab/Ruijuan/505/WGS/SNP_GATK_combine/out_combine_1.vcf
