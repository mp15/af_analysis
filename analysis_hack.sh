#!/bin/bash
set -e
input_1=$1;
input_2=$2;
output_prefix=$3;

temp1=`mktemp af_1XXXX`;
temp2=`mktemp af_2XXXX`;

grep '^AC' ${input_1}.hack.bstats > $temp1
grep '^AC' ${input_2}.hack.bstats > $temp2

Rscript analysis_bstat_hack.R $temp1 $temp2 ${output_prefix}_snp.png ${output_prefix}_indel.png
rm $temp1 $temp2
