#!/bin/bash 
#SBATCH --partition=production # partition to submit to
#SBATCH --job-name="filter" # Job name
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=1 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=2000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=00-03:00:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=filter.out # File to which STDOUT will be written
#SBATCH --error=filter.err # File to which STDERR will be written
#SBATCH --mail-user=rzl0007@gmail.com
#SBATCH --mail-type=ALL
aklog
# This will be run once for a single process

/bin/hostname

start=`date +%s`

## Load required modules
module load vcftools/0.1.15

cd /share/malooflab/Ruijuan/505/WGS/SNP_parallel_region_2500_2019/two_options/reordered

vcftools --gzvcf 505.vcf.gz --remove-indels --min-alleles 2 --max-alleles 2 --maf 0.01 --minQ 40 --minGQ 30 --min-meanDP 1 --max-meanDP 100 --max-missing 0.5 --recode --recode-INFO-all --out 505_filtered
	mv 505_filtered.recode.vcf 505_filtered.vcf
	gzip 505_filtered.vcf

end=`date +%s`
runtime=$((end-start))
echo $runtime seconds to completion
