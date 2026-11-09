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


# extract the line from the annotation file containing info on the gene of interest
grep Name=$gene $annotation > $wkdir/tmp

# convert to a bed file
cut -f1,4,5 $wkdir/tmp > $wkdir/$gene.bed

# remove temp file
rm $wkdir/tmp

# extract fasta sequence from reference file
module load bedtools-uoneasy/2.31.0-GCC-12.3.0
bedtools getfasta \
	-fi $reference \
	-bed $wkdir/$gene.bed \
	-fo $wkdir/$gene.fasta

module unload bedtools-uoneasy/2.31.0-GCC-12.3.0



