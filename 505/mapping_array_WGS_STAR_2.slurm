#!/bin/bash
#SBATCH --partition=production # partition to submit to
#SBATCH --job-name="mapping_array" # Job name
#SBATCH --array=1-143
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=10 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=20000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=1-03:30:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=mapping_array_%A_%a.out # STDOUT
#SBATCH --error=mapping_array_%A_%a.err # STDERR
#SBATCH --mail-user=rzl0007@auburn.edu # does not work yet
#SBATCH --mail-type=ALL # does not work yet
# This will be run once for a single process
aklog

/bin/hostname

start=`date +%s`
module load star/2.6.0c 

cd /share/malooflab/Ruijuan/505/WGS/trimmed

# mapping 
echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
sample=`sed "${SLURM_ARRAY_TASK_ID}q;d" sample_list_remapSTAR`

out_dir=/share/malooflab/Ruijuan/505/WGS/mapping_STAR

echo ${sample} 

STAR --genomeDir /share/malooflab/John/KIAT/Reference/star_genome --readFilesIn ${sample}/${sample}_paired_1.fq.gz  ${sample}/${sample}_paired_2.fq.gz --outSAMtype BAM SortedByCoordinate --outFileNamePrefix $out_dir/${sample}/ --alignIntronMax 1 --alignMatesGapMax 1500 --runThreadN 10 --outReadsUnmapped Fastx --readFilesCommand zcat 

end=`date +%s`
runtime=$((end-start))
echo $runtime seconds to completion
