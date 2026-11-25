#!/bin/bash
# Laura Dean
# 25/11/26

# script to perform alignment between chr1 from the different asms to look for duplicated regions

#SBATCH --job-name=chr1_alignment
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=50g
#SBATCH --time=8:00:00
#SBATCH --output=/gpfs01/home/mbzlld/code_and_scripts/slurm_out_scripts/slurm-%x-%j.out



# setup env
source $HOME/.bash_profile
mkdir -p ~/data/Hoverflies/Nov26/chr1_mapping
cd ~/data/Hoverflies/Nov26/chr1_mapping


##  # extract chr1 from each scaffolded assembly
##  conda activate samtools1.24
##  samtools faidx ~/data/Hoverflies/reference_genomes/volucella_bombylans/Volucella_bombylans-GCA_949129095.1-unmasked.fa 1:1-394411929 > main_bomb_asm_chr1.fasta
##  samtools faidx ~/data/Hoverflies/reference_genomes/scaffolded/idVolBomb4_ragtag/idVolBomb4_ragtag.fasta 1_RagTag:1-425533555 > idVolBomb4_bombylans_chr1.fasta
##  samtools faidx ~/data/Hoverflies/reference_genomes/scaffolded/idVolBomb13_ragtag/idVolBomb13_ragtag.fasta 1_RagTag:1-407774141 > idVolBomb13_plumata_chr1.fasta
##  samtools faidx ~/data/Hoverflies/reference_genomes/scaffolded/GCA_949129105.1_idVolBomb1.1_alternate_haplotype_genomic_ragtag/alternate_haplotype_scaffolded.fasta 1_RagTag:1-400610659 > alternate_haplotype_bombylans_chr1.fasta
##  conda deactivate


# map the regions to each other
conda activate minimap2

echo "running for Bomb4_vs_Plum13"
minimap2 -x asm5 -t 16 -DP \
    idVolBomb4_bombylans_chr1.fasta \
    idVolBomb13_plumata_chr1.fasta \
    > Bomb4_vs_Plum13_alignment.paf

echo "running for AltHapBomb_vs_Plum13"
minimap2 -x asm5 -t 16 -DP \
    alternate_haplotype_bombylans_chr1.fasta \
    idVolBomb13_plumata_chr1.fasta \
    > AltHapBomb_vs_Plum13_alignment.paf

echo "running for MainBomb_vs_Plum13"
minimap2 -x asm5 -t 16 -DP \
    main_bomb_asm_chr1.fasta \
    idVolBomb13_plumata_chr1.fasta \
    > MainBomb_vs_Plum13_alignment.paf

echo "running for MainBomb_vs_AltHapBomb"
minimap2 -x asm5 -t 16 -DP \
    main_bomb_asm_chr1.fasta \
    alternate_haplotype_bombylans_chr1.fasta \
    > MainBomb_vs_AltHapBomb_alignment.paf

echo "running for MainBomb_vs_Bomb4"
minimap2 -x asm5 -t 16 -DP \
    main_bomb_asm_chr1.fasta \
    idVolBomb4_bombylans_chr1.fasta \
    > MainBomb_vs_Bomb4_alignment.paf

conda deactivate





