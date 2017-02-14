#!/bin/bash
#SBATCH --partition=gc # partition to submit to
#SBATCH --job-name=“trimming” # Job name
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=20 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=100000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=1-03:30:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=trimming.out # STDOUT
#SBATCH --error=trimming.err # STDERR
#SBATCH --mail-user=you@gmail.co # does not work yet
#SBATCH --mail-type=ALL # does not work yet
# This will be run once for a single process

/bin/hostname
module load trimmomatic/0.33 

# trimming 
folder=`ls | grep "138"`
echo $folder
for file in $folder
      do
      echo $file
      trimmomatic PE ${file}/${file}_1.fq.gz ${file}/${file}_2.fq.gz ${file}/${file}_paired_1.fq.gz ${file}/${file}_unpaired_1.fq.gz ${file}/${file}_paired_2.fq.gz ${file}/${file}_unpaired_2.fq.gz ILLUMINACLIP:Bradseq_adapter.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:70  

done
