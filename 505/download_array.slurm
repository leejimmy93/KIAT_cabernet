#!/bin/bash
#SBATCH --partition=gc # partition to submit to
#SBATCH --job-name="505_download" # Job name
#SBATCH --array=1-42
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=20 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=100000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=1-00:00:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=arrayJob_%A_%a.out # File to which STDOUT will be written
#SBATCH --error=arrayJob_%A_%a.err # File to which STDERR will be written
#SBATCH --mail-user=rzlli@ucdavis.edu
#SBATCH --mail-type=ALL

# This will be run once for a single process

/bin/hostname

start=`date +%s`

## Identify each array run

cd /share/malooflab/Ruijuan/505/late_silique/raw_data/bioftp.org/TBD170136_20170317

echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
sample=`sed "${SLURM_ARRAY_TASK_ID}q;d" sample_list`

echo ${sample}

wget -r ftp://FNP_KSJ:FNp_71aofb@bioftp.org/TBD170001_1617/${sample}

end=`date +%s`
runtime=$((end-start))
echo $runtime seconds to completion
