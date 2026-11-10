#!/bin/bash
# Laura Dean
# 9/11/26

# script to transfer an annotation from one assembly to another

#SBATCH --job-name=lifton
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=30g
#SBATCH --time=8:00:00
#SBATCH --output=/gpfs01/home/mbzlld/code_and_scripts/slurm_out_scripts/slurm-%x-%j.out


# setup env software
source $HOME/.bash_profile
#conda create --name lifton --override-channels -c conda-forge -c bioconda --strict-channel-priority minimap2 miniprot
conda activate lifton
#conda install python=3.12
#pip install lifton


# setup env
#target=~/data/Hoverflies/reference_genomes/volucella_bombylans/early_access_assembly/idVolBomb1.20220915.decontaminated.fa
target=~/data/Hoverflies/reference_genomes/bombylans_morph/idVolBomb4.fa
reference=~/data/Hoverflies/reference_genomes/volucella_bombylans/Volucella_bombylans-GCA_949129095.1-unmasked.fa
annotation=~/data/Hoverflies/reference_genomes/volucella_bombylans/Volucella_bombylans-GCA_949129095.1-2023_07-genes.gff
cd $(dirname $target)


# copy annotation to target assembly
lifton -t 16 -g $annotation -o ${target%.*}_lifton.gff -copies $target $reference


# cleanup
conda deactivate



