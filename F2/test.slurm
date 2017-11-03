#!/bin/bash
#SBATCH --partition=gc # partition to submit to
#SBATCH --job-name=“test” # Job name
#SBATCH --array=1-2
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=16 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=100000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=01-00:30:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=test_%A_%a.out # STDOUT
#SBATCH --error=test_%A_%a.err # STDERR
#SBATCH --mail-user=rzlli@ucdavis.edu # does not work yet
#SBATCH --mail-type=ALL # does not work yet
# This will be run once for a single process

# This will be run once for a single process

/bin/hostname

start=`date +%s`
echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
sample=`sed "${SLURM_ARRAY_TASK_ID}q;d" sample_list_test`

echo ${sample}

Rscript ${sample}

end=`date +%s`
runtime=$((end-start))
