#!/bin/bash 
#BATCH --partition=gc # partition to submit to
#SBATCH --job-name="scantwo_Erucic_Oleic_2" # Job name
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=16 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=100000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=5-00:00:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=scantwo_Erucic_Oleic_2.out # File to which STDOUT will be written
#SBATCH --error=scantwo_Erucic_Oleic_2.err # File to which STDERR will be written
#SBATCH --mail-user=rzlli@ucdavis.edu
#SBATCH --mail-type=ALL

# This will be run once for a single process

/bin/hostname

start=`date +%s`

Rscript scanotwo_Erucic_Oleic_2.R

end=`date +%s`
runtime=$((end-start))
