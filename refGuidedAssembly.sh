# Index fasta reference
bwa index mt.fa

# bwa mem alighnment
bwa mem mt.fa ler.fq > ler.sam

# Convert to binary
samtools view -b -o ler.bam -S ler.sam

# Sort your sam file
samtools sort ler.bam ler.sorted

# Index ler.sorted.bam
samtools index ler.sorted.bam

# Index the reference file
samtools faidx mt.fa

echo "Starting variant callng."

# Generate vcf file
samtools mpileup -gf mt.fa ler.sorted.bam | bcftools view -vcg - > snps_indels.vcf

echo "Now we're done!"






