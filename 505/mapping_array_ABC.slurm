#!/bin/bash
#SBATCH --partition=gc # partition to submit to
#SBATCH --job-name=“mapping_array” # Job name
#SBATCH --array=1-43
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=20 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=100000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=1-03:30:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=mapping_array_%A_%a.out # STDOUT
#SBATCH --error=mapping_array_%A_%a.err # STDERR
#SBATCH --mail-user=rzl0007@auburn.edu # does not work yet
#SBATCH --mail-type=ALL # does not work yet
# This will be run once for a single process

/bin/hostname

start=`date +%s`
# module load star/2.5.2b 

cd /share/malooflab/Ruijuan/505/late_silique_batchE/bioftp.org/TBD170280_20170504

# mapping 
echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
sample=`sed "${SLURM_ARRAY_TASK_ID}q;d" sample_list_2`

echo ${sample} 

STAR --genomeDir /share/malooflab/Ruijuan/reference/star_genome/ \
	--readFilesIn Sample_${sample}/${sample}_paired_1.fq.gz  Sample_${sample}/${sample}_paired_2.fq.gz \
	--outSAMtype BAM SortedByCoordinate \
	--outFileNamePrefix Sample_${sample}/ABC/ \
	--twopassMode Basic \
	--runThreadN 20 \
	--outReadsUnmapped Fastx \
	--readFilesCommand zcat 

end=`date +%s`
runtime=$((end-start))
echo $runtime seconds to completion
