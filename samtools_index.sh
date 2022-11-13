#!/bin/bash
#SBATCH -A b1042             ## account (unchanged)
#SBATCH -p genomics          ## "-p" instead of "-q"
#SBATCH -N 1                 ## number of nodes
#SBATCH -n 4                 ## number of cores
#SBATCH --mem=32817
#SBATCH -t 01:00:00          ## walltime
#SBATCH --job-name="sb samtools index"    ## name of job

module purge all             ## purge environment modules
module load samtools

cd /projects/b1042/PinedaLab/alignment_output/


cat /projects/b1042/PinedaLab/samples/accession_list.txt | while read line; do
samtools index -@ 4 ${line}.Aligned.sortedByCoord.out.bam \

done
