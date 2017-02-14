#!/bin/bash
#SBATCH --partition=gc # partition to submit to
#SBATCH --job-name=“SNP_calling” # Job name
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=22 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=120000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=5-00:00:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=SNP_calling_01_10_2017.out # STDOUT
#SBATCH --error=SNP_calling_01_10_2017.err # STDERR
#SBATCH --mail-user=you@gmail.co # does not work yet
#SBATCH --mail-type=ALL # does not work yet
# This will be run once for a single process

/bin/hostname
module load gatk/3.6 
# GATK doesn't support multithread 

reference=Brassica_napus_v4.1.chromosomes.fa
sample1=Ae_realignedBam.bam
sample2=Ol_realignedBam.bam

echo $reference
echo $sample1
echo $sample2

# SNP calling for Ae and Ol combined by chromosome
# parallel computing for differnet intervals xaa  
gatk	-T HaplotypeCaller\
	-R ${reference}\
	-I ${sample1}\ 
	-I ${sample2}\ 
	-dontUseSoftClippedBases\
	-stand_call_conf 20.0\ 
	-stand_emit_conf 20.0\ 
	-ploidy 4\
	-L xbn.intervals\ 
	-o output/$sample1.$sample2.xaa.vcf




