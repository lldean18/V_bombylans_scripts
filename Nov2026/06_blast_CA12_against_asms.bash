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
#SBATCH --time=8:00:00
#SBATCH --output=/gpfs01/home/mbzlld/code_and_scripts/slurm_out_scripts/slurm-%x-%j.out


# setup env
source $HOME/.bash_profile
mkdir -p /gpfs01/home/mbzlld/data/Hoverflies/Nov26/CA12_blast
cd /gpfs01/home/mbzlld/data/Hoverflies/Nov26/CA12_blast

# set variables
REFERENCE=/gpfs01/home/mbzlld/data/Hoverflies/reference_genomes/volucella_bombylans/Volucella_bombylans-GCA_949129095.1-unmasked.fa
ASSEMBLY=/gpfs01/home/mbzlld/data/Hoverflies/reference_genomes/volucella_bombylans/Volucella_bombylans-GCA_949129095.1-unmasked.fa
#ASSEMBLY=/gpfs01/home/mbzlld/data/Hoverflies/reference_genomes/volucella_bombylans/GCA_949129105.1_idVolBomb1.1_alternate_haplotype_genomic.fna
#ASSEMBLY=/gpfs01/home/mbzlld/data/Hoverflies/reference_genomes/scaffolded/idVolBomb4_ragtag/idVolBomb4_ragtag.fasta
#ASSEMBLY=/gpfs01/home/mbzlld/data/Hoverflies/reference_genomes/scaffolded/idVolBomb13_ragtag/idVolBomb13_ragtag.fasta

# create a blast database for the assembly
conda activate blast
makeblastdb \
    -in $ASSEMBLY \
    -dbtype nucl \
    -out $(basename ${ASSEMBLY%.*})_db
conda deactivate

# set gene and region dictionary
# PDCD6 also had 1:161283299-161300612 and 1:346107109-346107882 locations in the annotation
declare -A genes
genes[PDCD6]=1:7727605-7728390
genes[ENSYEVG00000011937]=1:7765534-7875935
genes[ENSYEVG00000008962]=1:8007108-8008478
genes[ENSYEVG00000010218]=1:8041105-8043418
genes[CA12]=1:8380415-8383266
genes[NCOA6]=1:8591953-8594050
genes[ENSYEVG00000012261]=1:8660984-8661421


for gene in ${genes[@]}
do

# extract gene sequence
conda activate samtools1.24
samtools faidx $REFERENCE ${genes[$gene]} > $gene.fa
conda deactivate

# blast the genes against the assembly
conda activate blast
blastn \
    -query $gene.fa \
    -db $(basename ${ASSEMBLY%.*})_db \
    -out $gene_$(basename ${ASSEMBLY%.*})_hits.tsv \
    -outfmt 6 \
    -evalue 1e-10 \
    -word_size 11 \
    -num_threads 8
conda deactivate

# add a header line to the output file
{ echo -e "qseqid\tsseqid\tpident\tlength\tmismatch\tgapopen\tqstart\tqend\tsstart\tsend\tevalue\tbitscore"; cat $gene_$(basename ${ASSEMBLY%.*})_hits.tsv; } > $gene_$(basename ${ASSEMBLY%.*})_hits.tsv.tmp && mv $gene_$(basename ${ASSEMBLY%.*})_hits.tsv.tmp $gene_$(basename ${ASSEMBLY%.*})_hits.tsv

done


