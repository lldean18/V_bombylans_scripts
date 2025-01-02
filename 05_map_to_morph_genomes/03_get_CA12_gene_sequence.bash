#!/bin/bash
# Laura Dean
# 2/1/25
# For running on the UoN HPC Ada

#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=5g
#SBATCH --time=1:00:00
#SBATCH --job-name=HF_get_gene_seq
#SBATCH --output=/gpfs01/home/mbzlld/code_and_scripts/slurm_out_scripts/slurm-%x-%j.out


# extract CA12 gene sequence from reference genome and annotation file
# so I can blast the sequence against Mara's morph assemblies and see where
# the gene is and whether there are 2 copies of it in bombylans


# set variables
wkdir=/gpfs01/home/mbzlld/data/Hoverflies/morph_refs
reference=/gpfs01/home/mbzlld/data/Hoverflies/reference_genomes/volucella_bombylans/Volucella_bombylans-GCA_949129095.1-unmasked.fa.gz
annotation=/gpfs01/home/mbzlld/data/Hoverflies/reference_genomes/volucella_bombylans/Volucella_bombylans-GCA_949129095.1-2023_07-genes.gff
gene=CA12


