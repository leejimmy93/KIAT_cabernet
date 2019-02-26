#!/bin/bash
#SBATCH --partition=production # partition to submit to
#SBATCH --job-name="combine_gvcf" # Job name
#SBATCH --array=1-12 # array
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=1 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=10000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=03-00:00:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=GATK_%A_%a.out # STDOUT
#SBATCH --error=GATK_%A_%a.err # STDERR
#SBATCH --mail-user=rzl0007@gmail.com # 
#SBATCH --mail-type=ALL # 
# This will be run once for a single process
aklog

/bin/hostname
start=`date +%s`

module load gatk/3.6

cd /share/malooflab/Ruijuan/505/WGS/SNP_GATK

# GATK doesn't support multithread so I will run chromosome intervals as array
echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
sample=`sed "${SLURM_ARRAY_TASK_ID}q;d" sample.vcf.list`

reference=/share/malooflab/Ruijuan/reference/Brassica_napus_v4.1.chromosomes.fa
echo ${sample} 

# combine gvcf 
# task array for differnet vcf list, each contains 20 samples
gatk -T CombineGVCFs -R ${reference} -V ${sample} -o /share/malooflab/Ruijuan/505/WGS/SNP_GATK_combine/${sample}.vcf

echo "done" 
end=`date +%s`
runtime=$((end-start))
echo $runtime seconds to completion
