#!/bin/bash
# Laura Dean
# 3/1/25
# For running on the UoN HPC Ada

#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=50g
#SBATCH --time=08:00:00
#SBATCH --job-name=HF_blast_contig_seq
#SBATCH --output=/gpfs01/home/mbzlld/code_and_scripts/slurm_out_scripts/slurm-%x-%j.out


# extract the contig sequences from the morph genomes that contained the CA12 gene
# then blast them against the reference to see where they match to


# set variables
wkdir=/gpfs01/home/mbzlld/data/Hoverflies/morph_refs
reference=/gpfs01/home/mbzlld/data/Hoverflies/reference_genomes/volucella_bombylans/Volucella_bombylans-GCA_949129095.1-unmasked.fa.gz
annotation=/gpfs01/home/mbzlld/data/Hoverflies/reference_genomes/volucella_bombylans/Volucella_bombylans-GCA_949129095.1-2023_07-genes.gff
gene=CA12
bombylans=/gpfs01/home/mbzlld/data/Hoverflies/reference_genomes/bombylans_morph/idVolBomb4.fa.gz
plumata=/gpfs01/home/mbzlld/data/Hoverflies/reference_genomes/plumata_morph/idVolBomb13.fa.gz

# load software
module load blast-uoneasy/2.14.1-gompi-2023a



# extract the contig sequences from the bombylans and plumata references
#zgrep --after-context=1 'ptg000018l' $plumata > $wkdir/plumata_ptg000018l.fasta
#zgrep --after-context=1 'ptg000136l' $bombylans > $wkdir/bombylans_ptg000136l.fasta
#zgrep --after-context=1 'ptg000219l' $bombylans > $wkdir/bombylans_ptg000219l.fasta



# make the blast databases
#gunzip -c $reference | makeblastdb -in - -dbtype nucl -title HF_blast_database -out ${reference%.*.*}_blastdb
#gunzip -c $bombylans | makeblastdb -in - -dbtype nucl -title HF_blast_database -out ${bombylans%.*.*}_blastdb
#gunzip -c $plumata | makeblastdb -in - -dbtype nucl -title HF_blast_database -out ${plumata%.*.*}_blastdb

# blast gene sequence against main reference file
blastn \
-query $wkdir/plumata_ptg000018l.fasta \
-db ${reference%.*.*}_blastdb \
-out $wkdir/plumata_ptg000018l_blast_hits.txt

# blast gene sequence against main reference file
blastn \
-query $wkdir/bombylans_ptg000136l.fasta \
-db ${reference%.*.*}_blastdb \
-out $wkdir/bombylans_ptg000136l_blast_hits.txt

# blast gene sequence against main reference file
blastn \
-query $wkdir/bombylans_ptg000219l.fasta \
-db ${reference%.*.*}_blastdb \
-out $wkdir/bombylans_ptg000219l_blast_hits.txt


# unload software
module unload blast-uoneasy/2.14.1-gompi-2023a



