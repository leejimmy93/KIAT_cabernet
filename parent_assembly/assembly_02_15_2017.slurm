#!/bin/bash
#SBATCH --partition=gc # partition to submit to
#SBATCH --job-name=“assembly” # Job name
#SBATCH --array=1-24 # array
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=20 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=120000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=00-03:00:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=assembly_02_15_2017_%A_%a.out # STDOUT
#SBATCH --error=assembly_02_15_2017_%A_%a.err # STDERR
#SBATCH --mail-user=rzl0007@gmail.com # does not work yet
#SBATCH --mail-type=ALL # does not work yet
# This will be run once for a single process

/bin/hostname
module load cufflinks/2.2.1

echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID

THREADS=20

sample=`sed "${SLURM_ARRAY_TASK_ID}q;d" samples.txt`

# transcriptome assembly using orginal gff3 file
cufflinks  -o /share/malooflab/Ruijuan/parent_assembly/${sample}/cufflink_output/ \
	   --junc-alpha 0.001 \
	   --label CUFF \
	   --max-bundle-length 3500000 \
	   --max-intron-length 300000 \
	   --max-mle-iterations 5000 \
	   --min-frags-per-transfrag 10 \
	   --min-intron-length 50 \
	   --min-isoform-fraction 0.1 \
	   --no-update-check \
	   --num-importance-samples 1000 \
	   --num-threads 20 \
	   --overhang-tolerance 8 \
	   --pre-mrna-fraction 0.15 \
	   --small-anchor-fraction 0.09 \
	   --trim-3-avgcov-thresh 10 \
	   --trim-3-dropoff-frac 0.1 \
	   --library-type fr-secondstrand \
	   -g /share/malooflab/Ruijuan/reference/Brassica_napus.annotation_v5.gff3 \
	   -b /home/ruijuanli/2017_winter/assembly/Brassica_napus_v4.1.chromosomes.fa \
	    /share/malooflab/Ruijuan/parent_assembly/${sample}/Aligned.sortedByCoord.out.bam

echo "done"
