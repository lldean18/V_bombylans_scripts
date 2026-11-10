#!/bin/bash
# Laura Dean
# 5/11/26

# Script to scaffold the Sanger long-read assemblies with RagTag
# so that I can investigate synteny between them

#SBATCH --job-name=ragtag_scaffold
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=50g
#SBATCH --time=8:00:00
#SBATCH --output=/gpfs01/home/mbzlld/code_and_scripts/slurm_out_scripts/slurm-%x-%j.out

# setup env
source $HOME/.bash_profile
conda activate ragtag
cd /gpfs01/home/mbzlld/data/Hoverflies/reference_genomes
mkdir -p scaffolded

#assembly=volucella_bombylans/early_access_assembly/idVolBomb1.20220915.decontaminated.fa
assembly=bombylans_morph/idVolBomb4.fa
#assembly=plumata_morph/idVolBomb13.fa
reference=volucella_bombylans/Volucella_bombylans-GCA_949129095.1-unmasked.fa


### scaffold assembly ###
# -r = infer gap sizes
# -u = add suffix to unplaced sequence headers so they cannot share the same name
ragtag.py scaffold \
-t 16 \
-r \
-u \
-m 1000000 \
-o scaffolded/$(basename ${assembly%.*})_ragtag \
$reference $assembly

# get rid of the ragtag suffixes
#sed -i 's/_RagTag//' ${assembly%.*}_ragtag/ragtag.scaffold.fasta


# cleanup env
conda deactivate

