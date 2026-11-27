#!/bin/bash
# Laura Dean
# 27/11/26

# script to investigate synteny between the key contigs in the hoverfly assemblies

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

OUTDIR=/gpfs01/home/mbzlld/data/Hoverflies/Nov26/ntsynt/main_vs_bomb4_contigs

mkdir -p $OUTDIR
cd $OUTDIR

# estimate divergence between sequences
# Sonal uses --divergence 1

# calculate synteny between assemblies
ntSynt \
  --divergence 0.5 \
  /gpfs01/home/mbzlld/data/Hoverflies/Nov26/chr1_mapping/main_bomb_asm_chr1_1-30Mb.fasta \
  /gpfs01/home/mbzlld/data/Hoverflies/Nov26/chr1_mapping/idVolBomb4_bomb_key_contigs.fasta

# plot synteny between assemblies
ntsynt_viz.py \
--normalize \
--blocks ntSynt.k24.w1000.synteny_blocks.tsv \
--fais main_bomb_asm_chr1_1-30Mb.fasta.fai idVolBomb4_bomb_key_contigs.fasta.fai \
--prefix ribbon_plot_main_vs_Bomb4 \
--target-genome main_bomb_asm_chr1_1-30Mb.fasta \
--no-arrow \
--ribbon_adjust 0.15 \
--length 1000 \
--seq_length 1000 \
--height 70 \
--width 150

# unload software
conda deactivate


