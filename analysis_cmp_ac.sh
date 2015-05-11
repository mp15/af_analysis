#!/bin/bash
set -e
input_1=$1;
output_prefix=$2;

temp1=`mktemp AC_cmp_XXXX`;

grep '^AC' ${input_1} > $temp1

Rscript analysis_cmp_ac.R $temp1 ${output_prefix}_snp.png ${output_prefix}_indel.png

rm $temp1
