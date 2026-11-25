#!/bin/bash
# Laura Dean
# 10/11/26

# code to extract annotation information for a specific region of a genome


mkdir -p /gpfs01/home/mbzlld/data/Hoverflies/Nov26/genes
cd /gpfs01/home/mbzlld/data/Hoverflies/Nov26/genes

# write the region you are interested in to a bed file
echo -e "1\t8000000\t8500000" > morph_region_broad.bed

bedtools intersect \
-a /gpfs01/home/mbzlld/data/Hoverflies/reference_genomes/volucella_bombylans/Volucella_bombylans-GCA_949129095.1-2023_07-genes.gff \
-b morph_region_broad.bed \
-wa > morph_region_broad_genes.gff



