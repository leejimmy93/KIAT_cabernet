#!/bin/bash
#SBATCH --partition=gc # partition to submit to
#SBATCH --job-name="505_Array_Freebayes" # Job name
#SBATCH --array=1-41
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=20 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=100000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=5-00:00:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=Freebayes_no_pop_%A_%a.out # File to which STDOUT will be written
#SBATCH --error=Freebayes_no_pop_%A_%a.err # File to which STDERR will be written
#SBATCH --mail-user=rzl0007@tigermail.auburn.edu
#SBATCH --mail-type=ALL

# This will be run once for a single process

/bin/hostname

start=`date +%s`

## Load required modules

module load freebayes/v1.0.2-33-gdbb6160
module load samtools/1.3

## Identify each array run
cd /share/malooflab/Ruijuan/505/late_silique_bam_file

echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
chrom=`sed "${SLURM_ARRAY_TASK_ID}q;d" chrom_list`

bams=`ls Sample*/${chrom}.bam`

echo ${chrom}
echo ${bams}

freebayes -f /share/malooflab/John/KIAT/Reference/Split_Chroms/${chrom}.fa ${bams} --no-population-priors --report-genotype-likelihood-max --genotype-qualities > /share/malooflab/Ruijuan/505/vcf_no_pop_late_silique/${chrom}.vcf

end=`date +%s`
runtime=$((end-start))
echo $runtime seconds to completion
