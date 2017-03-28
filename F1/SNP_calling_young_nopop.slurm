#!/bin/bash
#BATCH --partition=gc # partition to submit to
#SBATCH --job-name="young_SNP_calling" # Job name
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=20 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=100000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=2-00:00:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=young_SNP_calling.out # File to which STDOUT will be written
#SBATCH --error=young_SNP_calling.err # File to which STDERR will be written
#SBATCH --mail-user=rzlli@ucdavis.edu
#SBATCH --mail-type=ALL

# This will be run once for a single process

/bin/hostname

start=`date +%s`

## Load required modules
source /home/ruijuanli/.bash_profile

module load freebayes/v1.0.2-33-gdbb6160
module load samtools/1.3

cd /share/malooflab/Ruijuan/F1/bam

bamaddrg -b 414F1_young_unique_sorted_rmdup.bam -s 414_young -r 414_young -b 415F1_young_unique_sorted_rmdup.bam -s 415_young -r 415_young | freebayes -f /share/malooflab/John/KIAT/Reference/Brassica_napus_v4.1.chromosomes.fa --stdin --genotype-qualities > /share/malooflab/Ruijuan/F1/vcf/young.vcf

end=`date +%s`
runtime=$((end-start))
