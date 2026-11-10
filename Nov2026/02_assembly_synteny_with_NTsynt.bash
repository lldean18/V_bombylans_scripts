#!/bin/bash
# Laura Dean
# 5/11/26

# script to investigate synteny between the three hoverfly assemblies

#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=20g
#SBATCH --time=2:00:00
#SBATCH --job-name=hoverfly_synteny
#SBATCH --output=/gpfs01/home/mbzlld/code_and_scripts/slurm_out_scripts/slurm-%x-%j.out

# setup env
source $HOME/.bash_profile
#conda create --name ntsynt -c bioconda -c conda-forge ntsynt
conda activate ntsynt
mkdir -p /gpfs01/home/mbzlld/data/Hoverflies/Nov26/ntsynt/main_2_asms
cd /gpfs01/home/mbzlld/data/Hoverflies/Nov26/ntsynt/main_2_asms


# estimate divergence between sequences
# Sonal uses --divergence 1

# calculate synteny between assemblies
ntSynt \
  --divergence 0.5 \
  ~/data/Hoverflies/reference_genomes/volucella_bombylans/Volucella_bombylans-GCA_949129095.1-unmasked.fa \
  ~/data/Hoverflies/reference_genomes/volucella_bombylans/early_access_assembly/idVolBomb1.20220915.decontaminated.fa #\
#  ~/data/Hoverflies/reference_genomes/bombylans_morph/idVolBomb4.fa \
#  ~/data/Hoverflies/reference_genomes/plumata_morph/idVolBomb13.fa

# plot synteny between assemblies
ntsynt_viz.py \
--normalize \
--blocks ntSynt.k24.w1000.synteny_blocks.tsv \
--fais Volucella_bombylans-GCA_949129095.1-unmasked.fa.fai idVolBomb1.20220915.decontaminated.fa.fai \
--prefix ribbon_plot_2_assemblies \
--target-genome idVolBomb1.20220915.decontaminated.fa \
--no-arrow \
--ribbon_adjust 0.15 \
--length 1000 \
--seq_length 1000 \
--height 70 \
--width 150 #\
#--keep Volucella_bombylans-GCA_949129095.1-unmasked.fa:1 Volucella_bombylans-GCA_949129095.1-unmasked.fa:2 Volucella_bombylans-GCA_949129095.1-unmasked.fa:3 Volucella_bombylans-GCA_949129095.1-unmasked.fa:4 Volucella_bombylans-GCA_949129095.1-unmasked.fa:5 Volucella_bombylans-GCA_949129095.1-unmasked.fa:X
#--name_conversion name_conversion.tsv \
##idVolBomb4.fa.fai idVolBomb13.fa.fai \
#--target-genome Volucella_bombylans-GCA_949129095.1-unmasked.fa \

# unload software
conda deactivate


