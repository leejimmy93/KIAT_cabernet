#!/bin/bash 
#BATCH --partition=gc # partition to submit to
#SBATCH --job-name="scanone_fatty_acid_lipid" # Job name
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=16 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=100000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=5-00:00:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=scanone_fatty_acid_lipid.out # File to which STDOUT will be written
#SBATCH --error=scanone_fatty_acid_lipid.err # File to which STDERR will be written
#SBATCH --mail-user=rzlli@ucdavis.edu
#SBATCH --mail-type=ALL

# This will be run once for a single process

/bin/hostname

start=`date +%s`

Rscript scanone_fatty_acid_lipid.R

end=`date +%s`
runtime=$((end-start))
