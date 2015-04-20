#!/usr/bin/env perl
use warnings;
use strict;
use File::Copy;

my $in_file = $ARGV[0];
my $downsample_target=$ARGV[1];

my $file = `basename $in_file`;

chomp $file;

my $genome_size=3300000000;
my $flagstat_file = $in_file;
$flagstat_file =~ s/\.bam$/.flagstat/;
my $reads=`cat ${flagstat_file} | tr '\n' '\t' | sed -n 's/.*\\t\\([0-9]*\\) + [0-9]* paired in sequencing\\t.*/\\1/p'`;
my $down_percent=($downsample_target*$genome_size) / ($reads * 151);
my $ref = '/lustre/scratch113/resources/ref/Homo_sapiens/1000Genomes_hs37d5/hs37d5.fa';
my $dbsnp = '/lustre/scratch113/resources/variation/Homo_sapiens/grch37/dbsnp_141.vcf.gz';
my $chrom = ' -L 6';

print "in file $in_file dst $downsample_target dp $down_percent\n";
# Random seed from http://www.random.org/cgi-bin/randbyte?nbytes=4&format=h
unless ( -e "${file}_${downsample_target}x.bam" ) {
	if ( $down_percent < 1.0 ) {
		$down_percent =~ s/0.//;
		my $cmd = "samtools view -bs3277205600.${down_percent} -o ${file}_${downsample_target}x_part.bam ${in_file}";
		print "running \"$cmd\"";
		if (system($cmd) != 0) { die "downsample fail!"; }
	} else {
		copy(${in_file}, "${file}_${downsample_target}x_part.bam");
		`touch ${file}_${downsample_target}x.insufficent_coverage`;
	}

	my $cmd = "samtools index ${file}_${downsample_target}x_part.bam";
	if (system($cmd) != 0) { die "downsample indexing failed!"; }
	print "moving ${file}_${downsample_target}x_part.bam to ${file}_${downsample_target}x.bam";
	move("${file}_${downsample_target}x_part.bam", "${file}_${downsample_target}x.bam");
	print "moving ${file}_${downsample_target}x_part.bam.bai to ${file}_${downsample_target}x.bam.bai";
	move("${file}_${downsample_target}x_part.bam.bai", "${file}_${downsample_target}x.bam.bai");
}
#	print "running mkdup";
#	exec "/software/jre1.7.0_25/bin/java -Xmx2g -Djava.io.tmpdir=./tmp -jar /nfs/users/nfs_m/mercury/src/picard-tools-1.119/MarkDuplicates.jar VALIDATION_STRINGENCY=LENIENT CREATE_INDEX=true INPUT=${run}_${lane}_${downsample_target}x_st.bam OUTPUT=${run}_${lane}_${downsample_target}x.bam METRICS_FILE=${run}_${lane}_${downsample_target}x.metrics";
print "running calling";
exec "/software/jre1.7.0_25/bin/java -Xmx28g -Djava.io.tmpdir=./tmp -jar /nfs/users/nfs_m/mercury/src/GenomeAnalysisTK-3.3-0/GenomeAnalysisTK.jar -T HaplotypeCaller -R ${ref} -nct 4 --dbsnp $dbsnp -ERC GVCF${chrom} -o ${file}_${downsample_target}x.vcf.gz -I ${file}_${downsample_target}x.bam -variant_index_type LINEAR -variant_index_parameter 128000";
