#!/bin/bash

Bowtie2=/path/your_bowtie2

Samtools=/path/your_samtools_version


#index bowtie2 (bowtie2-build)

bowtie2-build /path/your_reference/file.fasta /path/your_reference_indexing


#GENOME=/path/your_reference_indexé

#OUT_DIR=/path/your_output_DIR

#DATA_DIR=/path/your_fastq_file

#Loup on all fastq file
for fq1 in ${DATA_DIR}/*_R1.fq.gz
do

fq2=$(echo ${R1} | sed "s/R1.fq.gz/R2.fq.gz/g")
OUT=$(basename $R1 | awk -F "sep" '{print $1}')    #sep= separator which is either ("_", "." "-") 


#mapping and sort bam file with Bowtie2 and Samtools for pair_end mapping
$Bowtie2 -x $ref.btindex -1 $fq1 -2 $fq2 -S $OUT_DIR/$OUT_fileName.sam

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
