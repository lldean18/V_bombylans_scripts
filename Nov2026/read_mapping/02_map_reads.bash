#!/bin/bash
# Laura Dean
# 9/11/26

# script to map reads to a reference genome

#SBATCH --job-name=MapReads
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=120g
#SBATCH --time=24:00:00
#SBATCH --output=/gpfs01/home/mbzlld/code_and_scripts/slurm_out_scripts/slurm-%x-%j.out
#SBATCH --array=1-43


# move to working directory
cd ~/data/Hoverflies/Nov26

# set the config file
CONFIG=~/code_and_scripts/config_files/HF_ind_list.txt

# extract the information for this array step from the config file
IND=$(sed -n "${SLURM_ARRAY_TASK_ID}p" $CONFIG)
echo "mapping reads for array step $SLURM_ARRAY_TASK_ID for the sample individual $IND"

# name the forward and reverse reads for this array step using the sample info
fwd_reads=~/data/Hoverflies/trimmed_fqs/${IND}_R1.fastq.gz
rev_reads=~/data/Hoverflies/trimmed_fqs/${IND}_R2.fastq.gz

# set the reference genome that we will map the reads to
# the reference must be indexed with the bwa index command once before running this script
ref=/gpfs01/home/mbzlld/data/Hoverflies/reference_genomes/volucella_bombylans/Volucella_bombylans-GCA_949129095.1-unmasked.fa
genome_identifier=published_ref

# load software
source $HOME/.bash_profile
conda activate samtools1.24
module load bwa-uoneasy/0.7.17-GCCcore-12.3.0
module load picard-uoneasy/3.0.0-Java-17

# make a dir for the mapped bams and one for info
mkdir -p $genome_identifier/bams
mkdir -p $genome_identifier/bams/bam_info


#####################################
# MAP READS TO THE REFERENCE GENOME #
#####################################

# extract information about the sequencing from the fastq headers
# Extract the header line of the fastq file
file_info=$(zcat $fwd_reads | head -n 1)

# Save the pieces of information you need as variables
flowcell_ID=$(cut -d ":" -f3 <<< "$file_info")
lane_no=$(cut -d ":" -f4 <<< "$file_info")
sample_barcode=$(cut -d ":" -f10 <<< "$file_info")

# store the read group information for the ID and PU fields as variables from the individual ones you just created
PU=$flowcell_ID.$lane_no.$sample_barcode
ID=$flowcell_ID.$lane_no

echo "the read group header line for this individual is: @RG\tID:$ID\tSM:$IND\tPL:ILLUMINA\tLB:$IND\tPU:$PU"

###### Align the reads to the reference genome using bwa mem ######
# BWA MEM command explanation:
# -M = Mark shorter split hits as secondary (for Picard compatibility)
# -R = Specify info to go in read group header line
bwa mem \
-t 19 \
-M \
-R "@RG\tID:"$ID"\tSM:"$IND"\tPL:ILLUMINA\tLB:"$IND"\tPU:"$PU"" \
$ref \
$fwd_reads \
$rev_reads |
# add mate score tags then
# sort and index the bam files
samtools fixmate --threads 19 -m -O BAM - - |
samtools sort --threads 19 -o $genome_identifier/bams/${IND}_tmp.bam
samtools index $genome_identifier/bams/${IND}_tmp.bam

# remove pcr duplicaltes with picard
java -Xmx1g -jar $EBROOTPICARD/picard.jar \
MarkDuplicates \
REMOVE_DUPLICATES=false \
ASSUME_SORTED=true \
VALIDATION_STRINGENCY=SILENT \
MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=1000 \
INPUT=$genome_identifier/bams/${IND}_tmp.bam \
OUTPUT=$genome_identifier/bams/${IND}.bam \
METRICS_FILE=$genome_identifier/bams/bam_info/${IND}.rmd.bam.metrics

# index the final bam file
samtools index $genome_identifier/bams/${IND}.bam

# remove the temp file with duplicates not removed
rm $genome_identifier/bams/${IND}_tmp.bam*



# Generate info about how well the reads mapped
echo "the reads mapped with the following success:" > $genome_identifier/bams/bam_info/${IND}_mapping_info.txt
samtools flagstat --threads 19 $genome_identifier/bams/$IND.bam >> $genome_identifier/bams/bam_info/${IND}_mapping_info.txt

# deactivate software
conda deactivate
module unload bwa-uoneasy/0.7.17-GCCcore-12.3.0
module unload picard-uoneasy/3.0.0-Java-17

