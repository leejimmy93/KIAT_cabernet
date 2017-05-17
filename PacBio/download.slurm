#!/bin/bash
#SBATCH --partition=gc # partition to submit to
#SBATCH --job-name="download" # Job name
#SBATCH --array=1-1
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=20 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=2000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=3-00:00:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=arrayJob_%A_%a.out # File to which STDOUT will be written
#SBATCH --error=arrayJob_%A_%a.err # File to which STDERR will be written
#SBATCH --mail-user=rzl0007@auburn.edu
#SBATCH --mail-type=ALL

# This will be run once for a single process

/bin/hostname

start=`date +%s`

## Identify each array run

echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
sample=`sed "${SLURM_ARRAY_TASK_ID}q;d" sample_list`

echo ${sample}

wget -r --level=10 -nH -nc --cut-dirs=3 --no-parent --reject "wget_index.html" --no-check-certificate --header "Cookie: sessionid=nqx29xol33nixbx9j6bsj2oxxg4x3nzz;" https://rzlli:J9172880189j@bioshare.bioinformatics.ucdavis.edu/bioshare/wget/x48ff2erkrhtfci/Da-Ae_Brassica_napus/${sample}/wget_index.html /share/malooflab/Ruijuan/PacBio/data

end=`date +%s`
runtime=$((end-start))
echo $runtime seconds to completion
