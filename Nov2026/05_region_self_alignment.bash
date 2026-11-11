#!/bin/bash
# Laura Dean
# 11/11/26

# script to extract a genomic region and perform self alignment to look for duplicated regions

#SBATCH --job-name=self_alignment
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=30g
#SBATCH --time=8:00:00
#SBATCH --output=/gpfs01/home/mbzlld/code_and_scripts/slurm_out_scripts/slurm-%x-%j.out


# setup variables
ASSEMBLY=~/data/Hoverflies/reference_genomes/volucella_bombylans/Volucella_bombylans-GCA_949129095.1-unmasked.fa
genome_identifier=published_ref
size=394

# setup env
source $HOME/.bash_profile
mkdir -p ~/data/Hoverflies/Nov26/$genome_identifier/self_mapping
cd ~/data/Hoverflies/Nov26/$genome_identifier/self_mapping


# extract the region of interest
echo "1:1-${size}000000" > region_of_interest.txt # write region of interest to a file
conda activate samtools1.24
samtools faidx $ASSEMBLY
samtools faidx $ASSEMBLY --region-file region_of_interest.txt > ${genome_identifier}_${size}Mb_region.fasta
conda deactivate


# map the region to itself
conda activate minimap2
minimap2 -x asm5 -t 16 -DP \
    ${genome_identifier}_${size}Mb_region.fasta \
    ${genome_identifier}_${size}Mb_region.fasta \
    > ${genome_identifier}_${size}Mb_region_self_alignment.paf
conda deactivate





