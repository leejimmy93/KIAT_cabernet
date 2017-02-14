#!/bin/bash
#SBATCH --partition=gc # partition to submit to
#SBATCH --job-name=“fetch” # Job name
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=20 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=100000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=1-03:30:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=fetch_01_09_2017.out # STDOUT
#SBATCH --error=fetch_01_09_2017.err # STDERR
#SBATCH --mail-user=you@gmail.co # does not work yet
#SBATCH --mail-type=ALL # does not work yet
# This will be run once for a single process

/bin/hostname
# transfer all bam file to cabernet
folder=`ls | grep "Sample"`
echo $folder
for file in $folder
      do
      echo $file
      scp ruijuanli@coloma.plb.ucdavis.edu:/Network/Servers/avalanche.plb.ucdavis.edu/Volumes/Mammoth/Users/ruijuanli/2016_fall/F2/raw_data/bioftp.org/TBD160783_20161129/$file/*_paired*.gz $file

done
