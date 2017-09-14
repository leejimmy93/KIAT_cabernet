#!/bin/bash
#SBATCH --partition=gc # partition to submit to
#SBATCH --job-name=“blastx_Ol” # Job name
#SBATCH --array=1-40 # array
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=20 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=60000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=00-06:00:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=blastx_Ol_%A_%a.out # STDOUT
#SBATCH --error=blastx_Ol_%A_%a.err # STDERR
#SBATCH --mail-user=rzlli@ucdavis.edu # does not work yet
#SBATCH --mail-type=ALL # does not work yet
# This will be run once for a single process

/bin/hostname
module load blast/2.6.0+

echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID

THREADS=20
cd /share/malooflab/Ruijuan/assemly_analysis/De_novo_Assembly/cap3
sample=`sed "${SLURM_ARRAY_TASK_ID}q;d" sample_Ol.txt`
# blastx each small file
blastx -db /share/malooflab/UniRef90/uniref90.fasta -query ${sample}.fa -out /share/malooflab/Ruijuan/assemly_analysis/De_novo_Assembly/blastx_output/${sample}.blast.out -evalue 1e-6 -outfmt 6 -num_threads 20 -max_target_seqs 1  

echo "done"
