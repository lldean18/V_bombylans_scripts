#!/bin/bash
# Laura Dean
# 24/11/26

# script to backup data to sharepoint via rclone

#SBATCH --time=115:00:00
#SBATCH --job-name=rclone
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --mem=8g
#SBATCH --output=/gpfs01/home/mbzlld/code_and_scripts/slurm_out_scripts/slurm-%x-%j.out

# Possible sharepoint sites
# Laura                onedrive
# Laura2               onedrive
# MacCollLab1          onedrive
# MacCollLab2          onedrive
# OrgOne               onedrive
# OrgOne2              onedrive
# ctenella             onedrive
# BioinfMSc            onedrive
# hoverflies           onedrive

# setup env
module load rclone-uon/1.65.2

# copy the directory with rclone
rclone copy \
--transfers 4 \
--checkers 4 \
--bwlimit 200M \
--onedrive-chunk-size 50M \
--copy-links \
--checksum \
/gpfs01/home/mbzlld/data/Hoverflies/long_reads hoverflies:data/pacbio_long_reads

# Check the directory has copied successfully
rclone check \
--one-way \
/gpfs01/home/mbzlld/data/Hoverflies/long_reads hoverflies:data/pacbio_long_reads

# cleanup env
module unload rclone-uon/1.65.2

