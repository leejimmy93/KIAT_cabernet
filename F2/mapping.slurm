#!/bin/bash
#SBATCH --partition=gc # partition to submit to
#SBATCH --job-name=“mapping” # Job name
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=20 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=100000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=1-03:30:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=mapping.out # STDOUT
#SBATCH --error=mapping.err # STDERR
#SBATCH --mail-user=you@gmail.co # does not work yet
#SBATCH --mail-type=ALL # does not work yet
# This will be run once for a single process

/bin/hostname
module load star/2.5.2b 

# trimming 
folder=`ls | grep "138"`
echo $folder
for file in $folder
      do
      echo $file
      cd $file
      STAR --genomeDir /share/malooflab/John/KIAT/Reference/star_genome --readFilesIn ${file}_paired_1.fq.gz  ${file}_paired_2.fq.gz --sjdbGTFfile /share/malooflab/John/KIAT/Reference/Brassica_napus.annotation_v5_modified_modified.gff3 --quantMode TranscriptomeSAM GeneCounts --twopassMode Basic --alignIntronMax 15000 --outFilterIntronMotifs RemoveNoncanonical --runThreadN 20 --sjdbGTFtagExonParentTranscript Parent --sjdbGTFfeatureExon CDS --outReadsUnmapped Fastx --readFilesCommand zcat 

      cd .. 
done
