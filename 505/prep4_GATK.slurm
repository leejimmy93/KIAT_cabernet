#!/bin/bash
#SBATCH --partition=production # partition to submit to
#SBATCH --job-name="prep4_GATK" # Job name
#SBATCH --array=1-238 # array
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=1 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=100000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=00-10:00:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=GATK_%A_%a.out # STDOUT
#SBATCH --error=GATK_%A_%a.err # STDERR
#SBATCH --mail-user=rzl0007@gmail.com # 
#SBATCH --mail-type=ALL # 
# This will be run once for a single process
aklog

/bin/hostname
start=`date +%s`

module load gatk/3.6

cd /share/malooflab/Ruijuan/505/WGS/mapping_cabernet
# GATK doesn't support multithread so I will run chromosome intervals as array
echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
sample=`sed "${SLURM_ARRAY_TASK_ID}q;d" sample_list_mapping`

reference=/share/malooflab/Ruijuan/reference/Brassica_napus_v4.1.chromosomes.fa

echo ${sample} 
 
# determine suspicious intervals which are likely in need of realignment 
gatk    -T RealignerTargetCreator\
        -R ${reference}\
        -I ${sample}/final.bam\
        -o ${sample}/forIndelRealigner.intervals

echo "done"
end=`date +%s`
runtime=$((end-start))
echo $runtime seconds to completion

# running realigner over those intervals 
gatk    -T IndelRealigner\
        -R ${reference}\
        -I ${sample}/final.bam\
	-targetIntervals ${sample}/forIndelRealigner.intervals\
        -o ${sample}/realigned.bam

echo "done" 
end=`date +%s`
runtime=$((end-start))
echo $runtime seconds to completion
