#!/bin/bash

Minimap2=/path/your_Minimap2

Samtools=/path/your_samtools_version


#GENOME=/path/your_reference_genome

#OUT_DIR=/path/your_output_DIR

#DATA_DIR=/path/your_fastq_file


#Loup on all fastq file
for fq1 in ${DATA_DIR}/*_R1.fq.gz
do

fq2=$(echo ${R1} | sed "s/R1.fq.gz/R2.fq.gz/g")
OUT=$(basename $R1 | awk -F "sep" '{print $1}')    #sep= separator which is either ("_", "." "-") 


#mapping and sort bam file with minimap2 and Samtools for pair_end mapping

#$Minimap --MD -t 4 -ax map-ont $GENOME $fq1 $fq2 > $OUT_DIR/$OUT_fileName.sam

#Convert Sam_file in Bam_file
$Samtools view -bS $OUT_DIR/$OUT_fileName.sam -o $OUT_DIR/$OUT_fileName.bam

#Sorting the Bam_file
$Samtools sort $OUT_DIR/$OUT_fileName.sam -o $OUT_DIR/$OUT_fileName.sorted.bam

#Indexing the Bam_file
$Samtools index $OUT_DIR/$OUT_fileName.sorted.bam

$samtools faidx /path/your_reference/file.fasta

#Clean up the Sam_file and Bam_file

#rm -r $OUT_DIR/$OUT_fileName.sam
#rm -r $OUT_DIR/$OUT_fileName.bam
