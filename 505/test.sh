#!/bin/bash 
cd /share/malooflab/Ruijuan/505/WGS/trimmed

# mapping 

# bwa mem -t 10 /share/malooflab/Ruijuan/reference/Brassica_napus_v4.1.chromosomes.fa K100_S286_L003/K100_S286_L003_paired_1.fq.gz > /share/malooflab/Ruijuan/505/WGS/mapping_cabernet/test1.sam  

# samtools view /share/malooflab/Ruijuan/505/WGS/mapping_cabernet/test1.sam -bT /share/malooflab/Ruijuan/reference/Brassica_napus_v4.1.chromosomes.fa -@ 10 > /share/malooflab/Ruijuan/505/WGS/mapping_cabernet/test2.bam  

samtools sort -@ 10 /share/malooflab/Ruijuan/505/WGS/mapping_cabernet/test2.bam -o /share/malooflab/Ruijuan/505/WGS/mapping_cabernet/test3.bam   

