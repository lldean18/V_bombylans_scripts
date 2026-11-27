#!/bin/bash
# Laura Dean
# 25/11/26

# script to perform alignment between chr1 from the different asms to look for duplicated regions

#SBATCH --job-name=chr1_alignment
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=10g
#SBATCH --time=4:00:00
#SBATCH --output=/gpfs01/home/mbzlld/code_and_scripts/slurm_out_scripts/slurm-%x-%j.out



# setup env
source $HOME/.bash_profile
mkdir -p ~/data/Hoverflies/Nov26/chr1_mapping
cd ~/data/Hoverflies/Nov26/chr1_mapping


##  # extract chr1 1 to 30Mb from the main assembly
##  conda activate samtools1.24
##  samtools faidx ~/data/Hoverflies/reference_genomes/volucella_bombylans/Volucella_bombylans-GCA_949129095.1-unmasked.fa 1:1-30000000 > main_bomb_asm_chr1_1-30Mb.fasta
##  conda deactivate
##  
##  # extract the contigs of interest from the other assemblies
##  conda activate seqtk
##  printf "ptg000176l\nptg000205l\nptg000018l\n" | seqtk subseq \
##  ~/data/Hoverflies/reference_genomes/plumata_morph/idVolBomb13.fa - > idVolBomb13_plumata_key_contigs.fasta
##  
##  printf "ptg000089l\nptg000607l\nptg000375l\nptg000198l\nptg000136l\nptg000219l\n" | seqtk subseq \
##  ~/data/Hoverflies/reference_genomes/bombylans_morph/idVolBomb4.fa - > idVolBomb4_bomb_key_contigs.fasta
##  conda deactivate


# map the regions to each other
conda activate minimap2

echo "running for MainBomb_vs_Bomb4"
minimap2 -x asm5 -t 16 -DP \
    main_bomb_asm_chr1_1-30Mb.fasta \
    idVolBomb4_bomb_key_contigs.fasta \
    > MainBomb_vs_Bomb4_alignment_sml_section.paf

echo "running for MainBomb_vs_Plum13"
minimap2 -x asm5 -t 16 -DP \
    main_bomb_asm_chr1_1-30Mb.fasta \
    idVolBomb13_plumata_key_contigs.fasta \
    > MainBomb_vs_Plum13_alignment_sml_section.paf

echo "running for Bomb4_vs_Plum13"
minimap2 -x asm5 -t 16 -DP \
    idVolBomb4_bomb_key_contigs.fasta \
    idVolBomb13_plumata_key_contigs.fasta \
    > Bomb4_vs_Plum13_alignment_sml_section.paf

conda deactivate

