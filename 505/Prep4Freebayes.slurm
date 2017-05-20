#!/bin/bash
#SBATCH --partition=gc # partition to submit to
#SBATCH --job-name="Prep4FreeBayes" # Job name
#SBATCH --array=1-43
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=10 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=20000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=0-00:20:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=arrayJob.%A_%a.out # File to which STDOUT will be written
#SBATCH --error=arrayJob.%A_%a.err # File to which STDERR will be written
#SBATCH --mail-user=rzl0007@tigermail.auburn.edu
#SBATCH --mail-type=ALL

# This will be run once for a single process

/bin/hostname

# import bamaddrg 

module load samtools/1.3

cd /share/malooflab/Ruijuan/505/late_silique_batchE/bioftp.org/TBD170280_20170504

echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID

sample=`sed "${SLURM_ARRAY_TASK_ID}q;d" samples_list`
name=`sed "${SLURM_ARRAY_TASK_ID}q;d" samples_list | sed 's/Sample_505_K_//'`

echo $name
cd ${sample}

samtools view Aligned.sortedByCoord.out.bam | awk '$5 == "255"' > Unique.sam
samtools view -bT /share/malooflab/Ruijuan/reference/Brassica_napus_v4.1.chromosomes.fa Unique.sam > Unique.bam
samtools rmdup -s Unique.bam rmdup.bam
samtools sort rmdup.bam -o rmdup.sorted.bam 
bamaddrg -b rmdup.sorted.bam -s ${name} -r ${name} > final.bam 
samtools index final.bam 
chmod 555 final.bam 
chmod 555 final.bam.bai 
rm Unique.bam 
rm Unique.sorted.sam 
cd /share/malooflab/Ruijuan/505/late_silique_batchE/bioftp.org/TBD170280_20170504
echo ${name} done
