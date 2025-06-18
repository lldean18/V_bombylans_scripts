#!/bin/bash
# Laura Dean
# 17/6/25
# for running on Ada

#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=50g
#SBATCH --time=160:00:00
#SBATCH --job-name=ENA_hoverfly_submission
#SBATCH --output=/gpfs01/home/mbzlld/code_and_scripts/slurm_out_scripts/slurm-%x-%j.out


# set variables
wkdir=/gpfs01/home/mbzlld/data/Hoverflies/trimmed_fqs

# make ENA submissions
curl --upload-file $wkdir/VB20001_R1.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB20001_R2.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB20002_R1.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB20002_R2.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB20003_R1.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB20003_R2.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB20004_R1.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB20004_R2.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB20005_R1.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB20005_R2.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB20006_R1.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB20006_R2.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21001_R1.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21001_R2.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21002_R1.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21002_R2.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21003_R1.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21003_R2.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21004_R1.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21004_R2.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21005_R1.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21005_R2.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21006_R1.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21006_R2.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21007_R1.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21007_R2.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21008_R1.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21008_R2.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21009_R1.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21009_R2.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21010_R1.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21010_R2.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21011_R1.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21011_R2.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21012_R1.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21012_R2.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21013_R1.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21013_R2.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21014_R1.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21014_R2.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21015_R1.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21015_R2.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21016_R1.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21016_R2.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21017_R1.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21017_R2.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21018_R1.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21018_R2.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21019_R1.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21019_R2.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21020_R1.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21020_R2.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21021_R1.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21021_R2.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21022_R1.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21022_R2.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21023_R1.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21023_R2.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21024_R1.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21024_R2.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21025_R1.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21025_R2.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21026_R1.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21026_R2.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21027_R1.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21027_R2.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21028_R1.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21028_R2.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21029_R1.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21029_R2.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21030_R1.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21030_R2.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21031_R1.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21031_R2.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21032_R1.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21032_R2.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21033_R1.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21033_R2.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21034_R1.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21034_R2.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21035_R1.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21035_R2.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21036_R1.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21036_R2.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21037_R1.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk
curl --upload-file $wkdir/VB21037_R2.fastq.gz --user Webin-65735:************ ftp://webin2.ebi.ac.uk


echo "Curl commands complete"

