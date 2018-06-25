#!/bin/bash
#SBATCH --partition=gc # partition to submit to
#SBATCH --job-name="transfer batch C" # Job name
#SBATCH --array=1-79
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=1 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=2000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=0-01:00:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=arrayJob_%A_%a.out # File to which STDOUT will be written
#SBATCH --error=arrayJob_%A_%a.err # File to which STDERR will be written
#SBATCH --mail-user=rzlli@ucdavis.edu
#SBATCH --mail-type=ALL

# This will be run once for a single process

/bin/hostname

start=`date +%s`

cd
source .bash_profile

## Identify each array run

echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
lib=`sed "${SLURM_ARRAY_TASK_ID}q;d" /share/malooflab/Ruijuan/KIAT_cabernet/SRA_submission/batch_A`

echo ${lib}
ascp -i /home/ruijuanli/.aspera/connect/etc/aspera.openssh --overwrite=diff -QT -l100m -k1 -d /share/malooflab/Fastqs/KIAT/F2/Batch_A/${lib}/*.fq.gz subasp@upload.ncbi.nlm.nih.gov:uploads/leejimmy93@yahoo.com_upMAz9xu/Li-eQTL-TAG-2018

end=`date +%s`
runtime=$((end-start))
echo $runtime seconds to completion
