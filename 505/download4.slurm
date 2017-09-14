#!/bin/bash
#SBATCH --partition=gc64 # partition to submit to
#SBATCH --job-name=“download4” # Job name
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=1 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=2000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=2-00:00:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=download4.out # STDOUT
#SBATCH --error=download4.err # STDERR
#SBATCH --mail-user=rzl0007@gmail.com # does not work yet
#SBATCH --mail-type=ALL # does not work yet
# This will be run once for a single process

/bin/hostname
cd /share/malooflab/Ruijuan/505/late_silique/raw_data/batch_F/TBD170427_20170619-2 
wget -r ftp://FNP_KSJ:FNp_71aofb@bioftp.org/TBD170427_20170619-2/
