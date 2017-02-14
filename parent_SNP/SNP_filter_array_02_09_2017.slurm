#!/bin/bash
#SBATCH --partition=gc # partition to submit to
#SBATCH --job-name=“filter_SNP” # Job name
#SBATCH --array=1-40 # array
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=20 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=120000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=00-03:00:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=SNP_filter_02_09_2017_%A_%a.out # STDOUT
#SBATCH --error=SNP_filter_02_09_2017_%A_%a.err # STDERR
#SBATCH --mail-user=rzl0007@gmail.com # does not work yet
#SBATCH --mail-type=ALL # does not work yet
# This will be run once for a single process

/bin/hostname
module load gatk/3.6

# GATK doesn't support multithread so I will run chromosome intervals as array
echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID

THREADS=20

sample=`sed "${SLURM_ARRAY_TASK_ID}q;d" sample2.txt`

reference=../Brassica_napus_v4.1.chromosomes.fa

echo $reference
echo $sample 

# SNP filtering for Ae & Ol on chromosme level 
# task array for differnet intervals
gatk    -T VariantFiltration\
        -R ${reference}\
        -V ${sample}\
	-window 35\
	-cluster 3\
        -o ${sample}.filtered.vcf

echo "done"
