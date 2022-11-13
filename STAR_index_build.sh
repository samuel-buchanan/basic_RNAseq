#!/bin/bash
#SBATCH -A b1042             ## account (unchanged)
#SBATCH -p genomics          ## "-p" instead of "-q"
#SBATCH -N 1                 ## number of nodes
#SBATCH -n 4                 ## number of cores
#SBATCH --mem=65634
#SBATCH -t 02:00:00          ## walltime
#SBATCH	--job-name="sb STAR index creation"    ## name of job

module purge all	     ## purge environment modules
module load STAR


STAR --runThreadN 4 \
--runMode genomeGenerate \
--genomeDir /projects/b1042/PinedaLab/STARindex \
--genomeFastaFiles /projects/genomicsshare/anno/Homo_sapiens/UCSC/hg38/Sequence/WholeGenomeFasta/genome.fa \
--sjdbGTFfile /projects/genomicsshare/anno/Homo_sapiens/UCSC/hg38/Annotation/Genes/genes.gtf \
--genomeChrBinNbits 22
