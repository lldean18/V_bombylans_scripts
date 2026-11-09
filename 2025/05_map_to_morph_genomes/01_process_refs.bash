#!/bin/bash
# Laura Dean
# for running on the UoN HPC Ada
# 10/12/24

#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=40g
#SBATCH --time=24:00:00
#SBATCH --job-name=ProcessRef
#SBATCH --output=/gpfs01/home/mbzlld/code_and_scripts/slurm_out_scripts/slurm-%x-%j.out

# Process a new reference genome assembly

# Name the assemblies you want to process
assembly1=~/data/Hoverflies/reference_genomes/bombylans_morph/idVolBomb4.fa.gz
assembly2=~/data/Hoverflies/reference_genomes/plumata_morph/idVolBomb13.fa.gz

# load software
module load htslib-uoneasy/1.18-GCC-13.2.0 # (for bgzip)
module load samtools-uoneasy/1.18-GCC-12.3.0
module load bwa-uoneasy/0.7.17-GCCcore-12.3.0




for assembly in $assembly1 $assembly2
do

	# unzip the assembly as it's not zipped in the correct way on arrival
	gzip -d $assembly

	# re compress your assembly with bgzip
	bgzip ${assembly%.*}

	# index the ref genome
	samtools faidx $assembly

	# paste the chromosome names to a file
	# for V. bombylans
	cut -f1,2 $assembly.fai > ${assembly%/*}/chr_sizes.txt

	# index the reference assembly with bwa
	bwa index $assembly

done


module unload htslib-uoneasy/1.18-GCC-13.2.0
module unload samtools-uoneasy/1.18-GCC-12.3.0
module unload bwa-uoneasy/0.7.17-GCCcore-12.3.0

