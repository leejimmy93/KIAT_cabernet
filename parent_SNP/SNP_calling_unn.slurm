#!/bin/bash
#SBATCH --partition=gc # partition to submit to
#SBATCH --job-name=“call_SNP” # Job name
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=20 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=120000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=00-01:00:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=SNP_calling_unn.out # STDOUT
#SBATCH --error=SNP_calling_unn.err # STDERR
#SBATCH --mail-user=rzl0007@gmail.com # does not work yet
#SBATCH --mail-type=ALL # does not work yet
# This will be run once for a single process

/bin/hostname
module load gatk/3.6

reference=/share/malooflab/Ruijuan/reference/Brassica_napus_v4.1.chromosomes.fa
interval=xbo.intervals

sample1=Ae_realignedBam.bam
sample2=Ol_realignedBam.bam

echo $reference
echo $sample1
echo $sample2
echo $interval 

# SNP calling for chr_unn
gatk    -T HaplotypeCaller\
        -R ${reference}\
        -I ${sample1}\
        -I ${sample2}\
        -dontUseSoftClippedBases\
        -stand_call_conf 20.0\
        -stand_emit_conf 20.0\
        -L ${interval}\
        -o output/${interval}.vcf

echo "done GATK"

# filter 
gatk    -T VariantFiltration\
        -R ${reference}\
        -V output/${interval}.vcf\
	-window 35\
	-cluster 3\
        -o output/${interval}.filtered.vcf

echo "done filtering"




