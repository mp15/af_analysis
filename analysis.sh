#!/bin/bash
set -e
input_1=$1;
input_2=$2;
output_prefix=$3;
# Given that we only have lines with called sites
# get lines where EUR_AF is set
#bcftools query -i'EUR_AF!=0' -f'%INFO/EUR_AF\n' $input_1 > ${input_1}.eur_af_dump
#bcftools query -i'EUR_AF!=0' -f'%INFO/EUR_AF\n' $input_2 > ${input_2}.eur_af_dump

# Now dump all the allele frequencies
#bcftools query -i'AF!=0' -f'%INFO/AF\n' $input_1 > ${input_1}.af_dump";
#bcftools query -i'AF!=0' -f'%INFO/AF\n' $input_2 > ${input_2}.af_dump

#now plot the histogram to show AF distribution
#/software/R-3.0.0/bin/Rscript analysis.R ${input_1}.eur_af_dump ${input_2}.eur_af_dump eur_af.png
#/software/R-3.0.0/bin/Rscript analysis.R ${input_1}.af_dump ${input_2}.af_dump af.png

temp1=`mktemp af_1XXXX`;
temp2=`mktemp af_2XXXX`;

grep '^AF' ${input_1}.bstats > $temp1
grep '^AF' ${input_2}.bstats > $temp2

Rscript analysis_bstat.R $temp1 $temp2 ${output_prefix}_snp.png ${output_prefix}_indel.png
rm $temp1 $temp2

temp3=`mktemp psc_1XXXX`;
temp4=`mktemp psc_2XXXX`;

grep '^PSC' ${input_1}.bstats > $temp3
grep '^PSC' ${input_2}.bstats > $temp4

Rscript analysis_psc.R $temp3 $temp4 ${output_prefix}_analysis.tsv
rm $temp3 $temp4
