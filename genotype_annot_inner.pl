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

my $files_to_gt = "${downsample_target}.list";
#create working list
if ( ! -e "$files_to_gt" ) {
	system("sed 's/\\.bam/.vcf.gz' $manifest > $files_to_gt") or die "sed failed");
}

#genotype
if ( ! -e "${output}.tbi" ) {
	my $cmd = "/software/jre1.7.0_25/bin/java -Xmx3200m -jar $HOME/src/GenomeAnalysisTK-3.2-2/GenomeAnalysisTK.jar -T GenotypeGVCFs -R $ref -V $files_to_gt -o $output -L $region --dbsnp $dbsnp $chr";
	system($cmd) or die "genotyping failed";
}

#annot 1000g AF
if ( ! -e "$annotated" ) {
	my $cmd = "bcftools annotate -o $annotated -O z -a $onekgvcf -c 'INFO/EUR_AF' $output";
	system($cmd);
}
