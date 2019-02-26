#!/bin/bash 
#SBATCH --partition=production # partition to submit to
#SBATCH --job-name="concat" # Job name
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=1 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=2000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=00-03:00:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=concat.out # File to which STDOUT will be written
#SBATCH --error=concat.err # File to which STDERR will be written
#SBATCH --mail-user=rzl0007@gmail.com
#SBATCH --mail-type=ALL
aklog
# This will be run once for a single process

/bin/hostname

start=`date +%s`

## Load required modules
module load vcftools/0.1.15

cd /share/malooflab/Ruijuan/505/WGS/SNP_parallel_region_2500_2019/three_options/reordered

vcf-concat chrA01_random.vcf.gz chrA01.vcf.gz chrA02_random.vcf.gz chrA02.vcf.gz chrA03_random.vcf.gz chrA03.vcf.gz chrA04_random.vcf.gz chrA04.vcf.gz chrA05_random.vcf.gz chrA05.vcf.gz chrA06_random.vcf.gz chrA06.vcf.gz chrA07_random.vcf.gz chrA07.vcf.gz chrA08_random.vcf.gz chrA08.vcf.gz chrA09_random.vcf.gz chrA09.vcf.gz chrA10_random.vcf.gz chrA10.vcf.gz chrAnn_random.vcf.gz chrC01_random.vcf.gz chrC01.vcf.gz chrC02_random.vcf.gz chrC02.vcf.gz chrC03_random.vcf.gz chrC03.vcf.gz chrC04_random.vcf.gz chrC04.vcf.gz chrC05_random.vcf.gz chrC05.vcf.gz chrC06_random.vcf.gz chrC06.vcf.gz chrC07_random.vcf.gz chrC07.vcf.gz chrC08_random.vcf.gz chrC08.vcf.gz chrC09_random.vcf.gz chrC09.vcf.gz chrCnn_random.vcf.gz chrUnn_random.vcf.gz | gzip -c > 505.vcf.gz

end=`date +%s`
runtime=$((end-start))
echo $runtime seconds to completion
