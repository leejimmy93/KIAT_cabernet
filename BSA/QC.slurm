#!/bin/bash
#SBATCH --partition=gc # partition to submit to
#SBATCH --job-name=“QC” # Job name
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=1 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=10000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=00-05:30:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=QC.out # STDOUT
#SBATCH --error=QC.err # STDERR
#SBATCH --mail-user=rzl0007@gmail.com # does not work yet
#SBATCH --mail-type=ALL # does not work yet
# This will be run once for a single process

/bin/hostname

start=`date +%s`
module load fastqc/v0.11.2 

cd /share/malooflab/Kim/Data/i4xhjhuttt/Unaligned2/Project_JMSK_L8_H1095P_KimA

# QC
sample=`cat sample_list`

for i in sample
	do echo $i 
	fastqc ${i}.fastq.gz -o /share/malooflab/Kim/Data/i4xhjhuttt/Unaligned2/Project_JMSK_L8_H1095P_KimA/${i}
done 

end=`date +%s`
runtime=$((end-start))
echo $runtime seconds to completion
