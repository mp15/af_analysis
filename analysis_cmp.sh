#!/bin/bash
set -e
input_1=$1;
output_prefix=$2;

temp1=`mktemp GCsS_XXXX`;
temp2=`mktemp GCiS_XXXX`;

grep '^GCsS' ${input_1} > $temp1
Rscript analysis_cmp.R $temp1 ${output_prefix}_snp.png

grep '^GCiS' ${input_1} > $temp2
Rscript analysis_cmp.R $temp2 ${output_prefix}_indel.png

rm $temp1 $temp2

