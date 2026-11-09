#!/bin/bash
# Laura Dean
# 2/1/25
# For running on the UoN HPC Ada

#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=5g
#SBATCH --time=00:20:00
#SBATCH --job-name=HF_blast_gene_seq
#SBATCH --output=/gpfs01/home/mbzlld/code_and_scripts/slurm_out_scripts/slurm-%x-%j.out


# blast CA12 gene sequence against Mara's morph assemblies and see where
# the gene is and whether there are 2 copies of it in bombylans


# set variables
wkdir=/gpfs01/home/mbzlld/data/Hoverflies/morph_refs
reference=/gpfs01/home/mbzlld/data/Hoverflies/reference_genomes/volucella_bombylans/Volucella_bombylans-GCA_949129095.1-unmasked.fa.gz
annotation=/gpfs01/home/mbzlld/data/Hoverflies/reference_genomes/volucella_bombylans/Volucella_bombylans-GCA_949129095.1-2023_07-genes.gff
gene=CA12
bombylans=/gpfs01/home/mbzlld/data/Hoverflies/reference_genomes/bombylans_morph/idVolBomb4.fa.gz
plumata=/gpfs01/home/mbzlld/data/Hoverflies/reference_genomes/plumata_morph/idVolBomb13.fa.gz

# load software
module load blast-uoneasy/2.14.1-gompi-2023a



# make the blast databases
gunzip -c $reference | makeblastdb -in - -dbtype nucl -title HF_blast_database -out ${reference%.*.*}_blastdb
gunzip -c $bombylans | makeblastdb -in - -dbtype nucl -title HF_blast_database -out ${bombylans%.*.*}_blastdb
gunzip -c $plumata | makeblastdb -in - -dbtype nucl -title HF_blast_database -out ${plumata%.*.*}_blastdb



# blast gene sequence against main reference file
blastn \
-query $wkdir/$gene.fasta \
-db ${reference%.*.*}_blastdb \
-out $wkdir/${gene}_blast_hits.txt

# blast gene sequence against bombylans morph reference
blastn \
-query $wkdir/$gene.fasta \
-db ${bombylans%.*.*}_blastdb \
-out $wkdir/${gene}_bombylans_blast_hits.txt

# blast gene sequence against plumata morph reference
blastn \
-query $wkdir/$gene.fasta \
-db ${plumata%.*.*}_blastdb \
-out $wkdir/${gene}_plumata_blast_hits.txt



# unload software
module unload blast-uoneasy/2.14.1-gompi-2023a



