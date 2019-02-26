#!/bin/bash
#SBATCH --partition=production # partition to submit to
#SBATCH --job-name="BWA mapping Da-Ae" # Job name
#SBATCH --array=1-1
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=15 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=50000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=5-00:00:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=BWA_mapping_DaAe_%A_%a.out # STDOUT
#SBATCH --error=BWA_mapping_DaAe_%A_%a.err # STDERR
#SBATCH --mail-user=rzl0007@tigermail.auburn.edu # does not work yet
#SBATCH --mail-type=ALL # does not work yet
# This will be run once for a single process
aklog

/bin/hostname

start=`date +%s`
module load bwa/0.7.16a 
module load samtools/1.5

# mapping 
echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
# sample=`sed "${SLURM_ARRAY_TASK_ID}q;d" sample_list`

data_dir=/share/malooflab/John/KIAT/MASTER_DATA_ANALYSIS/READS/DaAe
out_dir=/share/malooflab/Ruijuan/505/WGS/DaAe_to_DaAe/mapping

# echo ${sample} 

bwa mem -t 15 /share/malooflab/John/KIAT/MASTER_DATA_ANALYSIS/BWA/Assemblies/B.napus_Final.fa.masked $data_dir/Trimmed_Small_DaAe_R1.fq.gz $data_dir/Trimmed_Small_DaAe_R2.fq.gz > $out_dir/tmp1.sam 

samtools view $out_dir/tmp1.sam -bT /share/malooflab/John/KIAT/MASTER_DATA_ANALYSIS/BWA/Assemblies/B.napus_Final.fa.masked -@ 15 > $out_dir/tmp1.bam 

samtools sort -@ 15 $out_dir/tmp1.bam > $out_dir/DaAe.bam   

rm $out_dir/tmp1.sam
rm $out_dir/tmp1.bam 

end=`date +%s`
runtime=$((end-start))
echo $runtime seconds to completion

