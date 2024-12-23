#!/bin/bash
# Laura Dean
# for running on the UoN HPC Ada
# 23/12/24

#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=60g
#SBATCH --time=168:00:00
#SBATCH --job-name=HF_map
#SBATCH --array=1-43
#SBATCH --output=/gpfs01/home/mbzlld/code_and_scripts/slurm_out_scripts/slurm-%x-%j.out

# set the variables
config=/gpfs01/home/mbzlld/code_and_scripts/config_files/HFmap_array_config.txt
wkdir=~/data/Hoverflies/morph_refs
reads=~/data/Hoverflies/trimmed_fqs
morph=bombylans
assembly=~/data/Hoverflies/reference_genomes/bombylans_morph/idVolBomb4.fa.gz
#morph=plumata
#assembly=~/data/Hoverflies/reference_genomes/plumata_morph/idVolBomb13.fa.gz

# extract the sample name for the current slurm task ID
individual=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $2}' $config)

# write to the output what this run is doing
echo "This run is array number: $ArrayTaskID 
mapping the reads for the individual: $individual
in the directory of reads: $reads
to the assembly / reference genome: $assembly
mapped reads will be written to: $wkdir/${morph}_full_bams
cleaned mapped reads will be written to $wkdir/${morph}_clean_bams"

# load the necessary modules
module load bwa-uoneasy/0.7.17-GCCcore-12.3.0
module load samtools-uoneasy/1.18-GCC-12.3.0
module load bcftools-uoneasy/1.18-GCC-13.2.0

# Your reference genome must be indexed using the command: bwa index $reference_genome (done in ref assembly prep script)

# name the paired files for each individual
R1filename=$""$reads"/"$individual"_R1.fastq.gz"
R2filename=$""$reads"/"$individual"_R2.fastq.gz"
echo "$R1filename and
$R2filename
are the files being worked on"

# Extract the header line of the fastq file
file_info=$(zcat $R1filename | head -n 1)

# Save the pieces of information you need as variables
flowcell_ID=$(cut -d ":" -f3 <<< "$file_info")
lane_no=$(cut -d ":" -f4 <<< "$file_info")
sample_barcode=$(cut -d ":" -f10 <<< "$file_info")

# store the read group information for the ID and PU fields as variables from the individual ones you just created
PU=$flowcell_ID.$lane_no.$sample_barcode
ID=$flowcell_ID.$lane_no






#######################################
# ALIGN READS TO THE REFERENCE GENOME #
#######################################

# make a directory in which to put the BAM files if it doesn't already exist
mkdir -p $wkdir/${morph}_full_bams
mkdir -p $wkdir/${morph}_clean_bams

###### Align the reads to the reference genome using bwa mem ######
# BWA MEM command explanation:
# -t = number of threads
# -M = Mark shorter split hits as secondary (for Picard compatibility)
# -R = Read group header line - gives identifiers for indivs and batches (lanes). Allows merging files which contain data for same indivs. Need unique ID and SM
#      ID: the read group identifier - the flowcell name followed by lane number this info is in the first line of the fastq file 
#      PU: the {FLOWCELL_BARCODE}.{LANE}.{SAMPLE_BARCODE}
#      SM: the name of the individual
#      PL: the platform used for sequencing (ILLUMINA)
#      LB: Unique ID for the library prep (this is the same as the individual ID unless you pooled DNA before lib prep)
# -o /path/to/output/sam/file
# /path/to/reference/genome
# /path/to/forward/reads
# /path/to/reverse/reads
bwa mem \
-t 19 \
-M \
-R "@RG\tID:"$ID"\tSM:"$individual"\tPL:ILLUMINA\tLB:"$individual"\tPU:"$PU"" \
$assembly \
$R1filename \
$R2filename |
# add mate score tags, then
# Sort the SAM files
samtools fixmate --threads 19 -m -O BAM - - |
samtools sort --threads 19 -o $wkdir/${morph}_full_bams/$individual.bam

# Index the SAM files
samtools index -@ 19 $wkdir/${morph}_full_bams/$individual.bam

# Generate info  - look at how well the reads mapped
echo "the raw reads mapped with the following success:"
samtools flagstat --threads 19 $wkdir/${morph}_full_bams/$individual.bam

# Remove unmapped reads and do quality filtering
# -q mapping quality greater than or equal to 40
# -f include reads mapped in a propper pair
# -F Only include reads which are not read unmapped or mate unmapped
samtools view \
--threads 19 \
-F 4 \
-f 2 \
-q 40 \
-b $wkdir/${morph}_full_bams/$individual.bam |
# Mark and remove PCR duplicate reads
samtools markdup -r --threads 19 - $wkdir/${morph}_clean_bams/$individual.bam
# adding the  -r flag to the command above will remove the duplicate reads

# index the final BAM files
samtools index -@ 19 $wkdir/${morph}_clean_bams/$individual.bam

# check the mapping
echo "after cleaning and filtering the final mapping success was:"
samtools flagstat $wkdir/${morph}_clean_bams/$individual.bam

# to check that the file header has been printed correctly
#module load samtools-uoneasy/1.18-GCC-12.3.0
#samtools view -H /path/to/individual.bam | grep '^@RG'





