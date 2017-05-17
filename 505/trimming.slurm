#!/bin/bash
#SBATCH --partition=gc # partition to submit to
#SBATCH --job-name=“trimming” # Job name
#SBATCH --array=1-1
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=1 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=50000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=00-05:30:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=arrayJob_%A_%a.out # STDOUT
#SBATCH --error=arrayJob_%A_%a.err # STDERR
#SBATCH --mail-user=rzl0007@auburn.edu # does not work yet
#SBATCH --mail-type=ALL # does not work yet
# This will be run once for a single process

/bin/hostname

start=`date +%s`
module load trimmomatic/0.33 

cd /share/malooflab/Ruijuan/505/late_silique_batchE/bioftp.org/TBD170280_20170504

# trimming 
echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
sample=`sed "${SLURM_ARRAY_TASK_ID}q;d" sample_list`

echo ${sample}

trimmomatic PE Sample_${sample}/${sample}_1.fq.gz Sample_${sample}/${sample}_2.fq.gz Sample_${sample}/${sample}_paired_1.fq.gz Sample_${sample}/${sample}_unpaired_1.fq.gz Sample_${sample}/${sample}_paired_2.fq.gz Sample_${sample}/${sample}_unpaired_2.fq.gz ILLUMINACLIP:Bradseq_adapter.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36 

end=`date +%s`
runtime=$((end-start))
echo $runtime seconds to completion
