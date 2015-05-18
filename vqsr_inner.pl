#!/usr/bin/env perl
use warnings;
use strict;
use File::Copy;

my $input = $ARGV[0];
my $output_prefix=$ARGV[1];
my $ref='/lustre/scratch113/resources/ref/Homo_sapiens/1000Genomes_hs37d5/hs37d5.fa';
my $chr='-L 6';
my $output = "${output_prefix}_vqsr.vcf.gz";
my $gatk = '$HOME/src/GenomeAnalysisTK-3.2-2/GenomeAnalysisTK.jar';
my $settings_snp = q[-l INFO \
                        -resource:hapmap,known=false,training=true,truth=true,prior=15.0 /lustre/scratch111/resources/variation/Homo_sapiens/grch37/gatk-bundle/2.5/hapmap_3.3.b37.vcf \
                        -resource:omni,known=false,training=true,truth=true,prior=12.0 /lustre/scratch111/resources/variation/Homo_sapiens/grch37/gatk-bundle/2.5/1000G_omni2.5.b37.vcf \
                        -resource:1000g,known=false,training=true,truth=false,prior=10.0 /lustre/scratch111/resources/variation/Homo_sapiens/grch37/gatk-bundle/2.5/1000G_phase1.snps.high_confidence.b37.vcf \
                        -resource:dbsnp,known=true,training=false,truth=false,prior=2.0 /lustre/scratch111/resources/variation/Homo_sapiens/grch37/gatk-bundle/2.8/b37//dbsnp_138.b37.vcf \
                        --target_titv 2.15 \
                        -an QD -an MQRankSum -an ReadPosRankSum -an FS -an InbreedingCoeff -an DP -an MQ -an SOR ];
my $settings_indel = q[   --maxGaussians 4 \
   -resource:mills,known=false,training=true,truth=true,prior=12.0 /lustre/scratch111/resources/variation/Homo_sapiens/grch37/gatk-bundle/2.5/Mills_and_1000G_gold_standard.indels.b37.vcf \
   -resource:dbsnp,known=true,training=false,truth=false,prior=2.0 /lustre/scratch111/resources/variation/Homo_sapiens/grch37/gatk-bundle/2.8/b37/dbsnp_138.b37.vcf \
   -an QD -an DP -an FS -an SOR -an ReadPosRankSum -an MQRankSum -an InbreedingCoeff ];

#VQSR for snps
if ( ! -e "${output_prefix}_vqsr_snp_recal.vcf.gz" ) {
	my $cmd = "/software/jre1.7.0_25/bin/java -Xmx140g -jar $gatk -T VariantRecalibrator -nt 32 -R $ref -input $input --recal_file ${output_prefix}_vqsr_snp_recal.vcf.gz --tranches_file ${output_prefix}_vqsr_snp_recal.tranches -mode SNP -rscriptFile ${output_prefix}.snp.plot $chr $settings_snp";
	system($cmd) == 0 or die "vqsr snp build failed";
}

#VQSR for indels
if ( ! -e "${output_prefix}_vqsr_indel_recal.vcf.gz" ) {
	my $cmd = "/software/jre1.7.0_25/bin/java -Xmx140g -jar $gatk -T VariantRecalibrator -nt 32 -R $ref -input $input --recal_file ${output_prefix}_vqsr_indel_recal.vcf.gz --tranches_file ${output_prefix}_vqsr_indel_recal.tranches -mode INDEL -rscriptFile ${output_prefix}.indel.plot $chr $settings_indel";
	system($cmd) == 0 or die "vqsr indel build failed";
}

#apply vqsr snp
if ( ! -e "${output_prefix}_vqsr_snponly.vcf.gz" ) {
	my $cmd = "/software/jre1.7.0_25/bin/java -Xmx140g -jar $gatk -T ApplyRecalibration -nt 32 -R $ref -input $input -o ${output_prefix}_vqsr_snponly.vcf.gz --recal_file ${output_prefix}_vqsr_snp_recal.vcf.gz --tranches_file ${output_prefix}_vqsr_snp_recal.tranches -mode SNP --ts_filter_level 99.5";
	system($cmd) == 0 or die "apply snp failed";
}

#apply vqsr indel
if ( ! -e $output ) {
	my $cmd = "/software/jre1.7.0_25/bin/java -Xmx140g -jar $gatk -T ApplyRecalibration -nt 32 -R $ref -input ${output_prefix}_vqsr_snponly.vcf.gz -o $output --recal_file ${output_prefix}_vqsr_indel_recal.vcf.gz --tranches_file ${output_prefix}_vqsr_indel_recal.tranches -mode INDEL --ts_filter_level 99.0";
	system($cmd) == 0 or die "apply indel failed";
}
