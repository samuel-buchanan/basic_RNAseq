#!/bin/bash
#SBATCH -A b1042             ## account (unchanged)
#SBATCH -p genomics          ## "-p" instead of "-q"
#SBATCH -N 1                 ## number of nodes
#SBATCH -n 4                 ## number of cores
#SBATCH --mem=65634
#SBATCH -t 10:00:00          ## walltime
#SBATCH --job-name="sb STAR alignment"    ## name of job

module purge all             ## purge environment modules
module load STAR

cd /projects/b1042/PinedaLab/samples

STAR --genomeLoad LoadAndExit --genomeDir /projects/b1042/PinedaLab/STARindex/

cat accession_list.txt | while read line; do

STAR --runThreadN 32 --genomeDir /projects/b1042/PinedaLab/STARindex/ \
--readFilesIn /projects/b1042/PinedaLab/samples/${line}.trim.fastq \
--clip3pNbases 0 --clip5pNbases 0 \
--outFileNamePrefix /projects/b1042/PinedaLab/alignment_output/${line}. \
--quantMode GeneCounts \
--outSAMtype BAM SortedByCoordinate \

done

STAR --genomeLoad Remove --genomeDir /projects/b1042/PinedaLab/STARindex/
