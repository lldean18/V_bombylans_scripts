#!/bin/bash
# Laura Dean
# Code for running on the UoN HPC Ada
# 10/12/24

#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=60g
#SBATCH --time=168:00:00
#SBATCH --job-name=HF_map
#SBATCH --array=1-23
#SBATCH --output=/gpfs01/home/mbzlld/code_and_scripts/slurm_out_scripts/slurm-%x-%j.out

# set the assembly to be mapped to
assembly=~/data/Hoverflies/reference_genomes/bombylans_morph/idVolBomb4.fa.gz
#assembly=~/data/Hoverflies/reference_genomes/plumata_morph/idVolBomb13.fa.gz
echo "This run is mapping reads to the assembly $assembly"

# Make the config file
cut -d" " -f1 ${assembly%/*}/chr_sizes.txt > ~/code_and_scripts/config_files/config



