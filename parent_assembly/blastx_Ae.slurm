#!/bin/bash
#SBATCH --partition=gc # partition to submit to
#SBATCH --job-name=“blastx_Ae” # Job name
#SBATCH --array=1-88 # array
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=20 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=60000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=00-00:10:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=blastx_Ae_%A_%a.out # STDOUT
#SBATCH --error=blastx_Ae_%A_%a.err # STDERR
#SBATCH --mail-user=rzl0007@gmail.com # does not work yet
#SBATCH --mail-type=ALL # does not work yet
# This will be run once for a single process

/bin/hostname
module load blast/2.6.0+

echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID

THREADS=20

sample=`sed "${SLURM_ARRAY_TASK_ID}q;d" sample_Ae.txt`
# blastx each small file
blastx -db /share/malooflab/nr/nr -query ${sample} -out Ae_blast_out/${sample}.blast.out -evalue 1e-6 -outfmt 6 -num_threads 20 -max_target_seqs 1  

echo "done"
