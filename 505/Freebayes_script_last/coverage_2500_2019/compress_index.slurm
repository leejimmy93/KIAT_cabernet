#!/bin/bash 
#SBATCH --partition=production # partition to submit to
#SBATCH --job-name="compress_index_vcf" # Job name
#SBATCH --array=1-41
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=1 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=2000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=00-03:00:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=compress_index_vcf_%A_%a.out # File to which STDOUT will be written
#SBATCH --error=compress_index_vcf_%A_%a.err # File to which STDERR will be written
#SBATCH --mail-user=rzl0007@gmail.com
#SBATCH --mail-type=ALL
aklog
# This will be run once for a single process

/bin/hostname

start=`date +%s`

## Load required modules
module load samtools/1.5

cd /share/malooflab/Ruijuan/505/WGS/SNP_parallel_region_2500_2019/two_options

echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
chrom=`sed "${SLURM_ARRAY_TASK_ID}q;d" chrom_list`
echo ${chrom}

bgzip ${chrom}.vcf
tabix -p vcf ${chrom}.vcf.gz

end=`date +%s`
runtime=$((end-start))
echo $runtime seconds to completion
