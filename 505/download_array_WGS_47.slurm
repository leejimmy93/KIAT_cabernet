#!/bin/bash
#SBATCH --partition=production # partition to submit to
#SBATCH --job-name="505_download" # Job name
#SBATCH --array=1-94
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=1 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=2000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=0-03:00:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=arrayJob_%A_%a.out # File to which STDOUT will be written
#SBATCH --error=arrayJob_%A_%a.err # File to which STDERR will be written
#SBATCH --mail-user=rzl0007@tigermail.auburn.edu
#SBATCH --mail-type=ALL
aklog
# This will be run once for a single process

/bin/hostname

start=`date +%s`

## Identify each array run

cd /share/malooflab/Fastqs/KIAT/505/WGS_47_Samples

echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
sample=`sed "${SLURM_ARRAY_TASK_ID}q;d" sample_list`

echo ${sample}

rsync -avL slimsdata.genomecenter.ucdavis.edu::slims/dsrm9o3s82/Un/Project_DTDB15_Rsync/${sample} . 

end=`date +%s`
runtime=$((end-start))
echo $runtime seconds to completion
