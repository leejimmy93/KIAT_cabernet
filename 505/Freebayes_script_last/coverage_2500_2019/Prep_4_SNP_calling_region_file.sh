#!/bin/bash
#SBATCH --partition=production # partition to submit to
#SBATCH --job-name="505_Array_Freebayes" # Job name
#SBATCH --array=1-41
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=1 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=2000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=00-00:10:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=split_%A_%a.out # File to which STDOUT will be written
#SBATCH --error=split_%A_%a.err # File to which STDERR will be written
#SBATCH --mail-user=rzl0007@gmail.com
#SBATCH --mail-type=ALL
aklog
# This will be run once for a single process

/bin/hostname

start=`date +%s`

## Load required modules

module load freebayes/1.2.0 # I copied /software/freebayes/1.2.0/lssc0-linux/scripts/ to our lab bin and corrected line 40
module load samtools/1.5
module load vcflib/7e3d806
module load bedtools2/2.27.0

## Identify each array run
cd /share/malooflab/Ruijuan/505/WGS/mapping_cabernet

echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
chrom=`sed "${SLURM_ARRAY_TASK_ID}q;d" chrom_list_coverage_2019`
echo ${chrom}

cd /share/malooflab/Ruijuan/KIAT_cabernet/505/Freebayes_script_last/coverage_2500_2019
ls | grep "${chrom}a" > ${chrom} 

end=`date +%s`
runtime=$((end-start))
echo $runtime seconds to completion
