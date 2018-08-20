#!/bin/bash
#SBATCH --partition=gc # partition to submit to
#SBATCH --job-name="505_download" # Job name
#SBATCH --array=1-2
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=1 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=2000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=0-10:00:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=arrayJob_%A_%a.out # File to which STDOUT will be written
#SBATCH --error=arrayJob_%A_%a.err # File to which STDERR will be written
#SBATCH --mail-user=rzl0007@tigermail.auburn.edu
#SBATCH --mail-type=ALL

# This will be run once for a single process

/bin/hostname

start=`date +%s`

## Identify each array run

cd /share/malooflab/Fastqs/KIAT/505/WGS

echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
sample=`sed "${SLURM_ARRAY_TASK_ID}q;d" sample_list_2`

echo ${sample}

rsync -avL slimsdata.genomecenter.ucdavis.edu::slims/vrzedg77i9/Un/Project_JMSK_NovaSeq002P_Kim/${sample} . 

end=`date +%s`
runtime=$((end-start))
echo $runtime seconds to completion
