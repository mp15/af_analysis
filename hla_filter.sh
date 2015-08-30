bcftools view -o greek_bams/30x/30x_vqsr_nhla.vcf.gz -O z -t ^6:29523406-33377701 greek_bams/30x/30x_vqsr.vcf.gz
bcftools view -o greek_bams/15x/15x_vqsr_nhla.vcf.gz -O z -t ^6:29523406-33377701 greek_bams/15x/15x_vqsr.vcf.gz
tabix -p vcf greek_bams/30x/30x_vqsr_nhla.vcf.gz
tabix -p vcf greek_bams/15x/15x_vqsr_nhla.vcf.gz
