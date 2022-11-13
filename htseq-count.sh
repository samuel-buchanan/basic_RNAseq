#!/bin/bash
#SBATCH -A b1042             ## account (unchanged)
#SBATCH -p genomics          ## "-p" instead of "-q"
#SBATCH -N 1                 ## number of nodes
#SBATCH -n 4                 ## number of cores
#SBATCH --mem=65634
#SBATCH -t 06:00:00          ## walltime
#SBATCH --job-name="sb htseq-count trial"    ## name of job

module purge all             ## purge environment modules
module load htseq

cd /projects/b1042/PinedaLab/samples/test/

cat accession_list.txt | while read line;
do
htseq-count -f bam -r pos -s no -n 4 \
${line}.Aligned.sortedByCoord.out.bam \
/projects/genomicsshare/anno/Homo_sapiens/UCSC/hg38/Annotation/Genes/genes.gtf \
done
