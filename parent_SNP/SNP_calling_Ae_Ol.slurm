#!/bin/bash
#BATCH --partition=gc # partition to submit to
#SBATCH --job-name="Ae_Ol_SNP_calling" # Job name
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=20 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=100000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=2-00:00:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=Ae_Ol_SNP_calling.out # File to which STDOUT will be written
#SBATCH --error=Ae_Ol_SNP_calling.err # File to which STDERR will be written
#SBATCH --mail-user=rzlli@ucdavis.edu
#SBATCH --mail-type=ALL

# This will be run once for a single process

/bin/hostname

start=`date +%s`

## Load required modules
source /home/ruijuanli/.bash_profile

module load freebayes/v1.0.2-33-gdbb6160
module load samtools/1.3
cd /share/malooflab/Ruijuan/parent_SNP/SNP_calling/freebayes

bamaddrg -b Ae_no_bolting_unique_mapped_rmdup.bam -s Ae -r Ae -b Ol_no_bolting_unique_mapped_rmdup.bam -s Ol -r Ol | freebayes -f /share/malooflab/John/KIAT/Reference/Brassica_napus_v4.1.chromosomes.fa --stdin --genotype-qualities > Ae_Ol.vcf

end=`date +%s`
runtime=$((end-start))
