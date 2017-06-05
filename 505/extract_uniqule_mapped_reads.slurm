#!/bin/bash
#SBATCH --partition=gc # partition to submit to
#SBATCH --job-name="extract_unique_reads" # Job name
#SBATCH --array=1-130
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=10 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=10000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=1-00:00:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=arrayJob_%A_%a.out # File to which STDOUT will be written
#SBATCH --error=arrayJob_%A_%a.err # File to which STDERR will be written
#SBATCH --mail-user=rzl0007@tigermail.auburn.edu
#SBATCH --mail-type=ALL

# This will be run once for a single process

/bin/hostname

start=`date +%s`

## Load required modules

module load samtools/1.3

## cd to working directory
cd /share/malooflab/Ruijuan/505/late_silique_bam_file

## Identify each array run

echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
sample=`sed "${SLURM_ARRAY_TASK_ID}q;d" sample_list_2`

## Extract uniquely mapped reads  

	samtools view Sample_${sample}/ABC/Aligned.sortedByCoord.out.bam | awk '$5 == "255"' > Sample_${sample}/ABC/Unique.sorted.sam
	samtools view -bT /share/malooflab/Ruijuan/reference/B_napus_plus_Bsub.fa Sample_${sample}/ABC/Unique.sorted.sam > Sample_${sample}/ABC/Unique.sorted.bam
	rm Sample_${sample}/ABC/Unique.sorted.sam  

end=`date +%s`
runtime=$((end-start))
echo $runtime seconds to completion
