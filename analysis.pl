my $input_1 = $ARGV[0];
my $input_2 = $ARGV[1];

# Given that we only have lines with called sites
# get lines where EUR_AF is set
my $cmd = "bcftools query -i'EUR_AF!=0' -f'%INFO/EUR_AF\n' $input_1 > ${input_1}.eur_af_dump";
system($cmd);
$cmd = "bcftools query -i'EUR_AF!=0' -f'%INFO/EUR_AF\n' $input_2 > ${input_2}.eur_af_dump";
system($cmd);

# Now dump all the allele frequencies
$cmd = "bcftools query -i'AF!=0' -f'%INFO/AF\n' $input_1 > ${input_1}.af_dump";
system($cmd);
$cmd = "bcftools query -i'AF!=0' -f'%INFO/AF\n' $input_2 > ${input_2}.af_dump"
system($cmd);

#now plot the histogram to show AF distribution
$cmd = "/software/R-3.0.0/bin/Rscript analysis.R ${input_1}.eur_af_dump ${input_2}.eur_af_dump eur_af.png";
system($cmd);
$cmd = "/software/R-3.0.0/bin/Rscript analysis.R ${input_1}.af_dump ${input_2}.af_dump af.png";
system($cmd);
