#!/usr/bin/env perl
use warnings;
use strict;
use File::Copy;

my $manifest = $ARGV[0];
my $downsample_target=$ARGV[1];
my $ref='/lustre/scratch113/resources/ref/Homo_sapiens/1000Genomes_hs37d5/hs37d5.fa';
my $dbsnp='/lustre/scratch113/resources/variation/Homo_sapiens/grch37/dbsnp_141.vcf.gz';
my $onekgvcf = '/lustre/scratch113/resources/1000g/release/20130502/ALL.autosomes.phase3_shapeit2_mvncall_integrated_v5.20130502.sites.vcf.gz'; #file to get EUR_AF from
my $chr='-L 6';
my $output = "${downsample_target}x.vcf.gz";
my $annotated = "${downsample_target}x_annot.vcf.gz";
my $isec = "${downsample_target}x_isec.vcf.gz";

my $files_to_gt = "${downsample_target}.list";
#create working list
if ( ! -e "$files_to_gt" ) {
	system("sed -n '".'s/.*\/\([0-9_]*\.bam\)$/\1_'.${downsample_target}.'x.vcf.gz/p'."' $manifest > $files_to_gt") == 0 or die "sed failed";
}

#genotype
if ( ! -e "${output}.tbi" ) {
	my $cmd = "/software/jre1.7.0_25/bin/java -Xmx140g -jar \$HOME/src/GenomeAnalysisTK-3.3-0/GenomeAnalysisTK.jar -T GenotypeGVCFs -nt 32 -R $ref -V $files_to_gt -o $output $chr --dbsnp $dbsnp $chr";
	system($cmd) == 0 or die "genotyping failed";
}

#annot 1000g AF
if ( ! -e "$annotated" ) {
	my $cmd = "bcftools annotate -O z -o $annotated -a $onekgvcf -c 'INFO/EUR_AF' $output; tabix $annotated";
	system($cmd) == 0 or die "annot failed";
}

#remove 
if ( ! -e "$isec" ) {
	my $cmd = "bcftools isec -O z -n=2 -w1 -o $isec $annotated $onekgvcf";
	system($cmd) == 0 or die "isec failed";
}

#extract standard AF stuff
if ( ! -e "${isec}.bstats" ) {
	my $cmd = "bcftools stats -s - -F ${ref} ${isec} > ${isec}.bstats";
	system($cmd) == 0 or die "stats failed";
}
