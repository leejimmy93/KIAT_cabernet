#!/bin/bash 
#SBATCH --partition=production # partition to submit to
#SBATCH --job-name="Prep4SNPcalling" # Job name
#SBATCH --array=1-238
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=1 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=20000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=0-03:30:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=Prep4SNPcalling_%A_%a.out # STDOUT
#SBATCH --error=Prep4SNPcalling_%A_%a.err # STDERR
#SBATCH --mail-user=rzl0007@tigermail.auburn.edu # does not work yet
#SBATCH --mail-type=ALL # does not work yet
# This will be run once for a single process
aklog

/bin/hostname
start=`date +%s`
module load samtools/1.5

cd /share/malooflab/Ruijuan/505/WGS/mapping_DaAe

# mapping
echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
sample=`sed "${SLURM_ARRAY_TASK_ID}q;d" sample_list`

# extract unique mapped reads 
samtools view -F 4 ${sample}.bam | grep -v "XA:Z" | grep -v "SA:Z" > ${sample}/Unique.sorted.sam

# from sam to bam 
samtools view -bT /share/malooflab/John/KIAT/MASTER_DATA_ANALYSIS/BWA/Assemblies/B.napus_Final.fa.masked ${sample}/Unique.sorted.sam > ${sample}/Unique.sorted.bam

# remove PCR duplicate 
samtools rmdup -s ${sample}/Unique.sorted.bam ${sample}/rmdup.bam

# add read group 
bamaddrg -b ${sample}/rmdup.bam -s ${sample} -r ${sample} > ${sample}/final.bam 

# index bam file
samtools index ${sample}/final.bam

# remove files 
rm ${sample}/Unique.sorted.sam
rm ${sample}/Unique.sorted.bam
rm ${sample}/rmdup.bam
rm ${sample}/rmdup.bam.bai

end=`date +%s`
runtime=$((end-start))
echo $runtime seconds to completion

