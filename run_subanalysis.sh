export PATH=/software/R-3.0.0/bin:$PATH
bcftools_hack/bcftools stats  -s - -F /lustre/scratch113/resources/ref/Homo_sapiens/1000Genomes_hs37d5/hs37d5.fa greek_bams/30x/30x_annot.vcf.gz greek_bams/15x/15x_annot.vcf.gz > greek_bams/30x15x_annot.cmp
bcftools_hack/bcftools stats  -s - -F /lustre/scratch113/resources/ref/Homo_sapiens/1000Genomes_hs37d5/hs37d5.fa greek_bams/30x/30x_isec.vcf.gz greek_bams/15x/15x_isec.vcf.gz > greek_bams/30x15x_isec.cmp
bcftools_hack/bcftools stats -f PASS -s - -F /lustre/scratch113/resources/ref/Homo_sapiens/1000Genomes_hs37d5/hs37d5.fa greek_bams/30x/30x_vqsr.vcf.gz greek_bams/15x/15x_vqsr.vcf.gz > greek_bams/30x15x_vqsr.cmp
bcftools_hack/bcftools stats -f PASS -s - -F /lustre/scratch113/resources/ref/Homo_sapiens/1000Genomes_hs37d5/hs37d5.fa greek_bams/30x/30x_vqsr_nhla.vcf.gz greek_bams/15x/15x_vqsr_nhla.vcf.gz > greek_bams/30x15x_vqsr_nhla.cmp
./analysis_cmp.sh greek_bams/30x15x_isec.cmp paper/data/1kg_r2
./analysis_cmp.sh greek_bams/30x15x_annot.cmp paper/data/all_r2
./analysis_cmp.sh greek_bams/30x15x_vqsr.cmp paper/data/vqsr_r2
./analysis_cmp.sh greek_bams/30x15x_vqsr.cmp paper/data/vqsr_nhla_r2
./analysis_cmp_ac.sh greek_bams/30x15x_isec.cmp paper/data/1kg_present
./analysis_cmp_ac.sh greek_bams/30x15x_annot.cmp paper/data/all_present
./analysis_cmp_ac.sh greek_bams/30x15x_vqsr.cmp paper/data/vqsr_present
./analysis_cmp_ac.sh greek_bams/30x15x_vqsr.cmp paper/data/vqsr_nhla_present
bcftools_hack/bcftools stats  -s - -F /lustre/scratch113/resources/ref/Homo_sapiens/1000Genomes_hs37d5/hs37d5.fa greek_bams/30x/30x_annot.vcf.gz > greek_bams/30x/30x_annot.vcf.gz.hack.bstats
bcftools_hack/bcftools stats  -s - -F /lustre/scratch113/resources/ref/Homo_sapiens/1000Genomes_hs37d5/hs37d5.fa greek_bams/15x/15x_annot.vcf.gz > greek_bams/15x/15x_annot.vcf.gz.hack.bstats
bcftools_hack/bcftools stats  -s - -F /lustre/scratch113/resources/ref/Homo_sapiens/1000Genomes_hs37d5/hs37d5.fa greek_bams/30x/30x_isec.vcf.gz > greek_bams/30x/30x_isec.vcf.gz.hack.bstats
bcftools_hack/bcftools stats  -s - -F /lustre/scratch113/resources/ref/Homo_sapiens/1000Genomes_hs37d5/hs37d5.fa greek_bams/15x/15x_isec.vcf.gz > greek_bams/15x/15x_isec.vcf.gz.hack.bstats
bcftools_hack/bcftools stats -f PASS -s - -F /lustre/scratch113/resources/ref/Homo_sapiens/1000Genomes_hs37d5/hs37d5.fa greek_bams/30x/30x_vqsr.vcf.gz > greek_bams/30x/30x_vqsr.vcf.gz.hack.bstats
bcftools_hack/bcftools stats -f PASS -s - -F /lustre/scratch113/resources/ref/Homo_sapiens/1000Genomes_hs37d5/hs37d5.fa greek_bams/15x/15x_vqsr.vcf.gz > greek_bams/15x/15x_vqsr.vcf.gz.hack.bstats
bcftools_hack/bcftools stats -f PASS -s - -F /lustre/scratch113/resources/ref/Homo_sapiens/1000Genomes_hs37d5/hs37d5.fa greek_bams/30x/30x_vqsr_nhla.vcf.gz > greek_bams/30x/30x_vqsr_nhla.vcf.gz.hack.bstats
bcftools_hack/bcftools stats -f PASS -s - -F /lustre/scratch113/resources/ref/Homo_sapiens/1000Genomes_hs37d5/hs37d5.fa greek_bams/15x/15x_vqsr_nhla.vcf.gz > greek_bams/15x/15x_vqsr_nhla.vcf.gz.hack.bstats
./analysis_hack.sh greek_bams/30x/30x_annot.vcf.gz greek_bams/15x/15x_annot.vcf.gz paper/data/all_ac
./analysis_hack.sh greek_bams/30x/30x_isec.vcf.gz greek_bams/15x/15x_isec.vcf.gz paper/data/1kg_ac
./analysis_hack.sh greek_bams/30x/30x_vqsr.vcf.gz greek_bams/15x/15x_vqsr.vcf.gz paper/data/vqsr_ac
./analysis_hack.sh greek_bams/30x/30x_vqsr_nhla.vcf.gz greek_bams/15x/15x_vqsr_nhla.vcf.gz paper/data/vqsr_nhla_ac
