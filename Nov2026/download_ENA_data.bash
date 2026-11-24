#!/bin/bash
# Laura Dean
# 24/11/26

# script to download the long-read data used to generate the Sanger assembly from ENA


##  # setup env
##  conda activate tmux
##  tmux attach -t hoverfly_download
##  srun --partition defq --cpus-per-task 2 --mem 10g --time 24:00:00 --pty bash


source $HOME/.bash_profile
#conda create --name globus conda-forge::globus-cli
conda activate globus


mkdir -p /gpfs01/home/mbzlld/data/Hoverflies/long_reads
cd /gpfs01/home/mbzlld/data/Hoverflies/long_reads


# try downloading with globus
globus login # then go to the url and login with my google account and paste the code
globus endpoint search "EMBL-EBI Public Data" # get the ENA endpoint
# ID                                   | Owner                | Display Name         | Domain
# -------------------------------------+----------------------+----------------------+------------------------------------
# 47772002-3e5b-4fd3-b97c-18cee38d6df2 | globus-ebi@ebi.ac.uk | EMBL-EBI Public Data | g-a8b222.dd271.03c0.data.globus.org
globus session show # to show my session information
# asked IT to make me an enpoint

globus transfer \
47772002-3e5b-4fd3-b97c-18cee38d6df2:/vol1/run/ERR142/ERR14220438/m84098_240124_155710_s2.hifi_reads.bc2071.bam \
dd3dafb5-ccd8-44e6-9e2c-f8d5d56573d9:/gpfs01/home/mbzlld/data/Hoverflies/long_reads/m84098_240124_155710_s2.hifi_reads.bc2071.bam





# download Sanger PACBIO_SMRT, instrument: Revio
wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR142/ERR14220409/m84047_240122_144806_s3.hifi_reads.bc2064.bam     # run ERR14220409 library name: FILR14503650 12Gb
wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR142/ERR14220438/m84098_240124_155710_s2.hifi_reads.bc2071.bam     # run ERR14220438 library name: FILR14503657
wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR146/ERR14657961/m84093_240222_110753_s1.hifi_reads.bc2080.bam     # run ERR14657961 library name: FILR14503666
wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR146/ERR14657961/m84093_240222_110753_s1.hifi_reads.bc2080.bam.bai # run ERR14657961 library name: FILR14503666
wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR146/ERR14657963/m84093_240222_113928_s2.hifi_reads.bc2068.bam     # run ERR14657963 library name: FILR14503654
wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR146/ERR14657963/m84093_240222_113928_s2.hifi_reads.bc2068.bam.bai # run ERR14657963 library name: FILR14503654
wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR142/ERR14220413/m84093_240124_155618_s2.hifi_reads.bc2078.bam     # run ERR14220413 library name: FILR14503664
wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR146/ERR14657957/m84093_240222_110753_s1.hifi_reads.bc2065.bam     # run ERR14657957 library name: FILR14503651
wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR146/ERR14657957/m84093_240222_110753_s1.hifi_reads.bc2065.bam.bai # run ERR14657957 library name: FILR14503651
wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR142/ERR14220437/m84098_240124_152648_s1.hifi_reads.bc2069.bam     # run ERR14220437 library name: FILR14503655
wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR146/ERR14657959/m84093_240222_110753_s1.hifi_reads.bc2074.bam     # run ERR14657959 library name: FILR14503660
wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR146/ERR14657959/m84093_240222_110753_s1.hifi_reads.bc2074.bam.bai # run ERR14657959 library name: FILR14503660
wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR142/ERR14220412/m84093_240124_152554_s1.hifi_reads.bc2072.bam     # run ERR14220412 library name: FILR14503658
wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR146/ERR14657965/m84093_240222_113928_s2.hifi_reads.bc2076.bam     # run ERR14657965 library name: FILR14503662
wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR146/ERR14657965/m84093_240222_113928_s2.hifi_reads.bc2076.bam.bai # run ERR14657965 library name: FILR14503662
wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR146/ERR14657964/m84093_240222_113928_s2.hifi_reads.bc2073.bam     # run ERR14657964 library name: FILR14503659
wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR146/ERR14657964/m84093_240222_113928_s2.hifi_reads.bc2073.bam.bai # run ERR14657964 library name: FILR14503659
wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR146/ERR14657958/m84093_240222_110753_s1.hifi_reads.bc2070.bam     # run ERR14657958 library name: FILR14503656
wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR146/ERR14657958/m84093_240222_110753_s1.hifi_reads.bc2070.bam.bai # run ERR14657958 library name: FILR14503656
wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR142/ERR14220410/m84047_240122_151828_s4.hifi_reads.bc2066.bam     # run ERR14220410 library name: FILR14503652
wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR142/ERR14220411/m84093_240122_151907_s4.hifi_reads.bc2061.bam     # run ERR14220411 library name: FILR14503647
wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR146/ERR14657960/m84093_240222_110753_s1.hifi_reads.bc2079.bam     # run ERR14657960 library name: FILR14503665
wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR146/ERR14657960/m84093_240222_110753_s1.hifi_reads.bc2079.bam.bai # run ERR14657960 library name: FILR14503665
wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR146/ERR14657962/m84093_240222_113928_s2.hifi_reads.bc2067.bam     # run ERR14657962 library name: FILR14503653
wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR146/ERR14657962/m84093_240222_113928_s2.hifi_reads.bc2067.bam.bai # run ERR14657962 library name: FILR14503653

# download Sanger PACBIO_SMRT, instrument: Sequel IIe
wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR102/ERR10224936/m64097e_220822_033810.ccs.bc1009_BAK8A_OA--bc1009_BAK8A_OA.bam # run ERR10224936 library name: DTOL13008726
wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR102/ERR10224937/m64174e_220912_005215.ccs.bc1021_BAK8B_OA--bc1021_BAK8B_OA.bam # run ERR10224937 library name: DTOL13066684

# download Sanger RNAseq data
wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR112/ERR11242509/47097_1%2338.cram # run ERR11242509

# download Sanger ILLUMINA instrument: HiSeq X Ten, paired WGS
wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR102/ERR10297831/35215_4%236.cram # run ERR10297831
wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR102/ERR10297830/35215_4%235.cram # run ERR10297830
wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR102/ERR10297832/35215_4%237.cram # run ERR10297832
wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR102/ERR10297833/35215_4%238.cram # run ERR10297833

# download Sanger ILLUMINA instrument: HiSeq X Ten, paired Hi-C
wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR102/ERR10297829/35195_5%231.cram # run ERR10297829






