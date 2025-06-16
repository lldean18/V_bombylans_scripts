#!/bin/bash
# Laura Dean
# 16/6/25
# script written for running on the UoN HPC Ada

#SBATCH --job-name=md5_checksums
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=30g
#SBATCH --time=12:00:00
#SBATCH --output=/gpfs01/home/mbzlld/code_and_scripts/slurm_out_scripts/slurm-%x-%j.out

# move to dir of files to be submitted to ENA
cd /gpfs01/home/mbzlld/data/Hoverflies/trimmed_fqs

# generate list of Md5 checksums
md5sum * > checksums.chk

# print finished
echo "finished generating md5 checksums"

