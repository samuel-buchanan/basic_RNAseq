#!/bin/bash
#SBATCH -A b1042             ## account (unchanged)
#SBATCH -p genomics          ## "-p" instead of "-q"
#SBATCH -N 1                 ## number of nodes
#SBATCH -n 4                 ## number of cores
#SBATCH --mem=65634
#SBATCH -t 02:00:00          ## walltime
#SBATCH --job-name="sb trimmomatic"    ## name of job

module purge all             ## purge environment modules
module load java
module load trimmomatic

cd /projects/b1042/PinedaLab/samples

cat accession_list.txt | while read line; do \
java -jar ~/trimmomatic/Trimmomatic-0.39/trimmomatic-0.39.jar \
SE -threads 32 -phred33 \
${line}.fastq \
${line}.trim.fastq \
ILLUMINACLIP:TruSeq3-SE.fa:2:30:10:7:true \
LEADING:3 TRAILING:3 SLIDINGWINDOW:4:20; \
done
