#!/bin/bash
#SBATCH --partition=gc512 # partition to submit to
#SBATCH --job-name=“assembly” # Job name
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=24 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=500000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=50-03:30:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=assembly_01_09_2017.out # STDOUT
#SBATCH --error=assembly_01_09_2017.err # STDERR
#SBATCH --exclusive # full node is used for my job 
#SBATCH --mail-user=you@gmail.co # does not work yet
#SBATCH --mail-type=ALL # does not work yet
# This will be run once for a single process

/bin/hostname
module load cufflinks/2.2.1 

# reference based assembly of B.napus transcriptome
folder=`ls | grep "paired"`
echo $folder
for file in $folder
      do
	echo $file
	cd $file
        
	mkdir cufflink_output 
	cufflinks -u -v -p 24 -o cufflink_output --library-type fr-secondstrand -g /home/ruijuanli/2017_winter/assembly/Brassica_napus.annotation_v5_modified_modified.gff3 -b /home/ruijuanli/2017_winter/assembly/Brassica_napus_v4.1.chromosomes.fa Aligned.sortedByCoord.out.bam

	cd .. 
done 
