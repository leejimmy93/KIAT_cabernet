#!/bin/bash 

module load vcftools/0.1.15

# compress and index region vcf files
# echo "compress and index region vcf files"
# cd /share/malooflab/Ruijuan/505/WGS/SNP_parallel_merged_region

# sample=`ls *.vcf`
# for i in $sample
#	do
#	echo $i
#	bgzip $i
#	tabix -p vcf $i.gz
# done

# merge the 7 chroms region vcf files 
# echo "merge the 7 chroms region vcf files"
chrom=`echo chrC05 chrC07 chrC08 chrC09 chrAnn_random chrCnn_random chrUnn_random`

# for i in $chrom
#	do 
#	echo $i
#	vcf-concat /share/malooflab/Ruijuan/505/WGS/SNP_parallel_merged_region/${i}*.vcf.gz | gzip -c > /share/malooflab/Ruijuan/505/WGS/SNP_parallel_partial_2/${i}.vcf.gz 

# done

# compress and index partial vcf files 
# echo "compress and index partial vcf files"
# cd /share/malooflab/Ruijuan/505/WGS/SNP_parallel_partial

# sample=`ls *.vcf`
# for i in $sample
#       do
#        echo $i
#        bgzip $i
#        tabix -p vcf $i.gz
# done
 
# compress and index partial_2 vcf files 
echo "compress and index partial vcf files"
cd /share/malooflab/Ruijuan/505/WGS/SNP_parallel_partial_2

sample=`ls *.vcf.gz | sed 's/.gz//g'` 
for i in $sample
      do
      echo $i
      bgzip -d $i.gz
      bgzip $i
      tabix -p vcf $i.gz
done

# merge the 7 chroms files 
echo "merge the 7 chroms files"
for i in $chrom
        do
        echo $i
        vcf-concat /share/malooflab/Ruijuan/505/WGS/SNP_parallel_partial/${i}.vcf.gz /share/malooflab/Ruijuan/505/WGS/SNP_parallel_partial_2/${i}.vcf.gz | gzip -c > /share/malooflab/Ruijuan/505/WGS/SNP_parallel_7_chrom/${i}.vcf.gz 

done


