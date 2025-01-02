#!/bin/bash
# Laura Dean
# 2/1/25
# For running on the UoN HPC Ada

#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=5g
#SBATCH --time=00:10:00
#SBATCH --job-name=HF_blast_gene_seq
#SBATCH --output=/gpfs01/home/mbzlld/code_and_scripts/slurm_out_scripts/slurm-%x-%j.out


# blast CA12 gene sequence against Mara's morph assemblies and see where
# the gene is and whether there are 2 copies of it in bombylans


# set variables
wkdir=/gpfs01/home/mbzlld/data/Hoverflies/morph_refs
reference=/gpfs01/home/mbzlld/data/Hoverflies/reference_genomes/volucella_bombylans/Volucella_bombylans-GCA_949129095.1-unmasked.fa.gz
annotation=/gpfs01/home/mbzlld/data/Hoverflies/reference_genomes/volucella_bombylans/Volucella_bombylans-GCA_949129095.1-2023_07-genes.gff
gene=CA12


# make the blast database
# only need to run this once
#gunzip -c $reference | makeblastdb -in - -dbtype nucl -title HF_blast_database -out ${reference%.*.*}_blastdb


# blast gene sequence against main reference file
module load blast-uoneasy/2.14.1-gompi-2023a
blastn \
-query $wkdir/$gene.fasta \
-db ${reference%.*.*}_blastdb \
-out $wkdir/${gene}_blast_hits.txt

module unload blast-uoneasy/2.14.1-gompi-2023a



