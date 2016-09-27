# Specify variables
raw_data=$1
reference=$2
output=$3

# Index fasta reference file
bwa index ${reference}.fa

# Run the bwa mem alignment
bwa mem ${reference}.fa ${raw_data}.fastq > ${raw_data}.sam

# Convert sam file to binary file
samtools view -b -o ${raw_data}.bam -S ${raw_data}.sam

# Sort your sam file
samtools sort ${raw_data}.bam ${raw_data}.sorted

# Index the sorted .bam file
samtools index ${raw_data}.sorted.bam

# Index the reference file
samtools faidx ${reference}.fa

echo "Starting variant calling."

# Generate vcf file
samtools mpileup -gf ${reference}.fa ${raw_data}.sorted.bam | bcftools view -vcg - > ${output}_snps_indels.vcf

echo "Now we're done!"






