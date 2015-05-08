require("ggplot2");

options <- commandArgs(trailingOnly = TRUE);

# GC[si]S  [2]id   [3]sample       [4]non-reference discordance rate       [5]RR Hom matches       [6]RA Het matches       [7]AA Hom matches       [8]RR Hom mismatches    [9]RA Het mismatches    [10]AA Hom mismatches	[11] dosage r-squared

concord_snp <- read.table(options[1], header=F, col.names=c(rep('',2),'sample','nrdr','RR Hom matches','RA Het matches','AA Hom matches','RR Hom mismatches','RA Het mismatches','AA Hom mismatches','dosage_r'), colClasses=c(rep('NULL',2),'character',rep('numeric',8)));
concord_snp$variant_type <- 'SNP';
concord_indel <- read.table(options[2], header=F, col.names=c(rep('',2),'sample','nrdr','RR Hom matches','RA Het matches','AA Hom matches','RR Hom mismatches','RA Het mismatches','AA Hom mismatches','dosage_r'), colClasses=c(rep('NULL',2),'character',rep('numeric',8)));
concord_indel$variant_type <- 'INDEL';

concord <-rbind(concord_snp, concord_indel);

palette <- c("#0072B2", "#D55E00");
cn_plot <- ggplot(data=concord, aes(x=variant_type,y=dosage_r)) + geom_boxplot(orientation="horizontal") + scale_fill_manual(values=palette) +
     scale_y_continuous(name="Dosage r squared") + scale_x_discrete(name="Variant Type");
ggsave(filename=options[3],plot=cn_plot);
