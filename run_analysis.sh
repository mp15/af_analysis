set -e

module add hgi/samtools/1.2
module add hgi/bcftools/1.2

set="greek_ds"
range='1-100'
manifest='/lustre/scratch114/projects/hiseqx_test/manifest'
#downsample and call 15x and extract data
cd greek_bams/15x
run=15
ds_15x_jobid=`bsub -q basement -o log/ds.%I.o -e log/ds.%I.e -J "${set}_${run}_ds[${range}]" -M 30000 -n 4 -R 'span[hosts=1] select[mem>30000] rusage[mem=30000]' -- ../../ds_call_inner.sh $manifest $run | sed -n 's/Job <\([0-9]*\)>.*/\1/p'`
ga_15x_jobid=`bsub -q basement -w "numdone($ds_15x_jobid,*)" -o log/call.%I.o -e log/call.%I.e -J "${set}_${run}_call" -M 144000 -n 32 -R 'span[hosts=1] select[mem>144000] rusage[mem=144000]' -- ../../genotype_annot_inner.pl $manifest $run | sed -n 's/Job <\([0-9]*\)>.*/\1/p'`
cd ../..
#downsample and call 30x and extract data
cd greek_bams/30x
run=30
ds_30x_jobid=`bsub -q basement -o log/ds.%I.o -e log/ds.%I.e -J "${set}_${run}_ds[${range}]" -M 30000 -n 4 -R 'span[hosts=1] select[mem>30000] rusage[mem=30000]' -- ../../ds_call_inner.sh $manifest $run | sed -n 's/Job <\([0-9]*\)>.*/\1/p'`
ga_30x_jobid=`bsub -q basement -w "numdone($ds_30x_jobid,*)" -o log/call.%I.o -e log/call.%I.e -J "${set}_${run}_call" -M 144000 -n 32 -R 'span[hosts=1] select[mem>144000] rusage[mem=144000]' -- ../../genotype_annot_inner.pl $manifest $run | sed -n 's/Job <\([0-9]*\)>.*/\1/p'`
cd ../..

#analysis
bsub -w "done($ga_15x_jobid) && done($ga_30x_jobid)" -M 18000 -n 1 -R 'span[hosts=1] select[mem>18000] rusage[mem=18000]' -J "${set}_analysis"-- ./analysis.sh greek_bams/30x/30x_annot.vcf.gz greek_bams/15x/15x_annot.vcf.gz paper/data/all
bsub -w "done($ga_15x_jobid) && done($ga_30x_jobid)" -M 18000 -n 1 -R 'span[hosts=1] select[mem>18000] rusage[mem=18000]' -J "${set}_analysis"-- ./analysis.sh greek_bams/30x/30x_isec.vcf.gz greek_bams/15x/15x_isec.vcf.gz paper/data/in1kg
