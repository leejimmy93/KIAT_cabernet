#!/bin/bash
#SBATCH --partition=gc # partition to submit to
#SBATCH --job-name=“QC2” # Job name
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=8 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=20000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=00-05:30:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=QC2.out # STDOUT
#SBATCH --error=QC2.err # STDERR
#SBATCH --mail-user=rzl0007@gmail.com # does not work yet
#SBATCH --mail-type=ALL # does not work yet
# This will be run once for a single process

/bin/hostname

start=`date +%s`
module load fastqc/v0.11.2 

cd /share/malooflab/Kim2/Data/2dtfmgyukd/Unaligned2/Project_JMSK_L7_H1095P_KimB

# QC
sample=`cat sample_list`

for i in sample
	do echo $i 
	fastqc ${i}.fastq.gz -o /share/malooflab/Kim2/Data/2dtfmgyukd/Unaligned2/Project_JMSK_L7_H1095P_KimB/${i}/
done 

end=`date +%s`
runtime=$((end-start))
echo $runtime seconds to completion
