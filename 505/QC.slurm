#!/bin/bash
#SBATCH --partition=gc # partition to submit to
#SBATCH --job-name=“QC” # Job name
#SBATCH --array=1-476
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=1 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=10000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=00-03:00:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=arrayJob_%A_%a.out # STDOUT
#SBATCH --error=arrayJob_%A_%a.err # STDERR
#SBATCH --mail-user=rzl0007@tigermail.auburn.edu # does not work yet
#SBATCH --mail-type=ALL # does not work yet

/bin/hostname

start=`date +%s`
module load fastqc/0.11.2 

## Identify each array run
cd /share/malooflab/Fastqs/KIAT/505/WGS

echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
sample=`sed "${SLURM_ARRAY_TASK_ID}q;d" sample_list`

echo ${sample}
 
fastqc ${i} -o /share/malooflab/Ruijuan/505/WGS/QC/raw/${i}

end=`date +%s`
runtime=$((end-start))
echo $runtime seconds to completion
