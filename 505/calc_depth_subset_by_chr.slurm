#!/bin/bash
#SBATCH --partition=production # partition to submit to
#SBATCH --job-name="calc_depth_then_sum" # Job name
#SBATCH --array=1-41
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=10 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=20000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=1-00:00:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=arrayJob_%A_%a.out # File to which STDOUT will be written
#SBATCH --error=arrayJob_%A_%a.err # File to which STDERR will be written
#SBATCH --mail-user=rzl0007@auburn.edu
#SBATCH --mail-type=ALL

# This will be run once for a single process

/bin/hostname

start=`date +%s`

## Load required modules

module load samtools/1.5

## cd to working directory
cd /share/malooflab/Ruijuan/505/WGS/mapping_cabernet

## Identify each array run

echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
chrom=`sed "${SLURM_ARRAY_TASK_ID}q;d" chrom_list_coverage_2019`

echo ${chrom}

## Index uniquely mapped reads, then extract reads from bam files for specific chromosome, and calculate read depth per base 

samtools depth */${chrom}.bam -a > /share/malooflab/Ruijuan/505/WGS/depth_2019/${chrom}.depth

awk '{for(i=3;i<=NF;i++)x+=$i;print x; x=0}' /share/malooflab/Ruijuan/505/WGS/depth_2019/${chrom}.depth > /share/malooflab/Ruijuan/505/WGS/depth_2019/${chrom}.sum.tmp
	
awk '{print $1, $2}' /share/malooflab/Ruijuan/505/WGS/depth_2019/${chrom}.depth > /share/malooflab/Ruijuan/505/WGS/depth_2019/${chrom}.loc.tmp
	
paste /share/malooflab/Ruijuan/505/WGS/depth_2019/${chrom}.loc.tmp /share/malooflab/Ruijuan/505/WGS/depth_2019/${chrom}.sum.tmp > /share/malooflab/Ruijuan/505/WGS/depth_2019/${chrom}.sum

rm /share/malooflab/Ruijuan/505/WGS/depth_2019/${chrom}.sum.tmp
rm /share/malooflab/Ruijuan/505/WGS/depth_2019/${chrom}.loc.tmp 

end=`date +%s`
runtime=$((end-start))
echo $runtime seconds to completion
