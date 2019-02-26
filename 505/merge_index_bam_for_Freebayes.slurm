#!/bin/bash
#SBATCH --partition=production # partition to submit to
#SBATCH --job-name="merge_index" # Job name
#SBATCH --array=1-7
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=1 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=100000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=5-00:00:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=Freebayes_no_pop_%A_%a.out # File to which STDOUT will be written
#SBATCH --error=Freebayes_no_pop_%A_%a.err # File to which STDERR will be written
#SBATCH --mail-user=rzl0007@gmail.com
#SBATCH --mail-type=ALL
aklog
# This will be run once for a single process

/bin/hostname

start=`date +%s`

## Load required modules

module load samtools/1.5

## Identify each array run
cd /share/malooflab/Ruijuan/505/WGS/mapping_cabernet

echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
chrom=`sed "${SLURM_ARRAY_TASK_ID}q;d" chrom_list_coverage`

bams=`ls *L003*/${chrom}.bam`
echo ${chrom}
echo ${bams}

samtools merge /share/malooflab/Ruijuan/505/WGS/merged_bam/${chrom}.bam ${bams} 
samtools index /share/malooflab/Ruijuan/505/WGS/merged_bam/${chrom}.bam 

end=`date +%s`
runtime=$((end-start))
echo $runtime seconds to completion
