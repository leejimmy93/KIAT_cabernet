#!/bin/bash
#SBATCH --partition=gc # partition to submit to
#SBATCH --job-name="mapping_array" # Job name
#SBATCH --array=1-238
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=10 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=20000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=0-03:30:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=mapping_array_%A_%a.out # STDOUT
#SBATCH --error=mapping_array_%A_%a.err # STDERR
#SBATCH --mail-user=rzl0007@tigermail.auburn.edu # does not work yet
#SBATCH --mail-type=ALL # does not work yet
# This will be run once for a single process

start=`date +%s`
module load bwa/0.7.16a 
module load samtools/1.3

cd /share/malooflab/Ruijuan/505/WGS/trimmed

# mapping 
# echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
# sample=`sed "${SLURM_ARRAY_TASK_ID}q;d" sample_list_trimming`

# echo ${sample} 

bwa mem -t 10 /share/malooflab/Ruijuan/reference/Brassica_napus_v4.1.chromosomes.fa K100_S286_L003/K100_S286_L003_paired_1.fq.gz K100_S286_L003/K100_S286_L003_paired_2.fq.gz > /share/malooflab/Ruijuan/505/WGS/mapping_cabernet/test1.sam 

samtools view /share/malooflab/Ruijuan/505/WGS/mapping_cabernet/test1.sam -bT /share/malooflab/Ruijuan/reference/Brassica_napus_v4.1.chromosomes.fa -@ 10 > /share/malooflab/Ruijuan/505/WGS/mapping_cabernet/test2.bam
 
samtools sort -@ 10 /share/malooflab/Ruijuan/505/WGS/mapping_cabernet/test2.bam -o /share/malooflab/Ruijuan/505/WGS/mapping_cabernet/test3.bam   

end=`date +%s`
runtime=$((end-start))
echo $runtime seconds to completion
