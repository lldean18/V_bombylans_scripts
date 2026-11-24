#!/bin/bash
# Laura Dean
# 24/11/26

# script to extract a sequence and blast it against asms to look for multiple copies

#SBATCH --job-name=blast
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=50g
#SBATCH --time=48:00:00
#SBATCH --output=/gpfs01/home/mbzlld/code_and_scripts/slurm_out_scripts/slurm-%x-%j.out


# setup env
source $HOME/.bash_profile
mkdir -p /gpfs01/home/mbzlld/data/Hoverflies/Nov26/CA12_blast
cd /gpfs01/home/mbzlld/data/Hoverflies/Nov26/CA12_blast

# set variables
REFERENCE=/gpfs01/home/mbzlld/data/Hoverflies/reference_genomes/volucella_bombylans/Volucella_bombylans-GCA_949129095.1-unmasked.fa
ASSEMBLY=/gpfs01/home/mbzlld/data/Hoverflies/reference_genomes/volucella_bombylans/Volucella_bombylans-GCA_949129095.1-unmasked.fa
ASSEMBLY=/gpfs01/home/mbzlld/data/Hoverflies/reference_genomes/volucella_bombylans/GCA_949129105.1_idVolBomb1.1_alternate_haplotype_genomic.fna
ASSEMBLY=/gpfs01/home/mbzlld/data/Hoverflies/reference_genomes/scaffolded/idVolBomb4_ragtag/idVolBomb4_ragtag.fasta
#ASSEMBLY=/gpfs01/home/mbzlld/data/Hoverflies/reference_genomes/scaffolded/idVolBomb13_ragtag/idVolBomb13_ragtag.fasta

# set gene and region dictionary
declare -A arr
arr[CA12]=1:8380415-8383266

# extract CA12 sequence
conda activate samtools1.24
samtools faidx $REFERENCE ${arr[CA12]} > CA12.fa
conda deactivate


# blast CA12 sequence against each assembly
conda activate blast

# create a blast database for the assembly
makeblastdb \
    -in $ASSEMBLY \
    -dbtype nucl \
    -out $(basename ${ASSEMBLY%.*})_db

echo -e "qseqid\tsseqid\tpident\tlength\tmismatch\tgapopen\tqstart\tqend\tsstart\tsend\tevalue\tbitscore" > 

blastn \
    -query CA12.fa \
    -db $(basename ${ASSEMBLY%.*})_db \
    -out CA12_$(basename ${ASSEMBLY%.*})_hits.tsv \
    -outfmt 6 \
    -evalue 1e-10 \
    -word_size 11 \
    -num_threads 8

{ echo -e "qseqid\tsseqid\tpident\tlength\tmismatch\tgapopen\tqstart\tqend\tsstart\tsend\tevalue\tbitscore"; cat CA12_$(basename ${ASSEMBLY%.*})_hits.tsv; } > CA12_$(basename ${ASSEMBLY%.*})_hits.tsv.tmp && mv CA12_$(basename ${ASSEMBLY%.*})_hits.tsv.tmp CA12_$(basename ${ASSEMBLY%.*})_hits.tsv

conda deactivate

