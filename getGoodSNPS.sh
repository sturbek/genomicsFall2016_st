vcf_file=$1
snps_thresh=$2
snps_output=$3
indels_thresh=$4
indels_output=$5

# Make intermediate file snps.txt with all of the snps
grep -v 'INDEL' ${vcf_file}.vcf | grep -v "##" > snps.txt

# Create text file with all snps with quality scores above a certain threshold
awk '$6 > $snps_thresh' snps.txt > ${snps_output}.txt

# Make intermediate fiel indels.txt with all of the indels
grep 'INDEL' ${vcf_file}.vcf | grep -v "##" > indels.txt

# Create text file with all indels with quality scores above a certain threshold
awk '$6 > $indels_thresh' indels.txt > ${indels_output}.txt
