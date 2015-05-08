require("ggplot2");

options <- commandArgs(trailingOnly = TRUE);

# GC[si]S  [2]id   [3]sample       [4]non-reference discordance rate       [5]RR Hom matches       [6]RA Het matches       [7]AA Hom matches       [8]RR Hom mismatches    [9]RA Het mismatches    [10]AA Hom mismatches	[11] dosage r-squared

concord <- read.table(options[1], header=F, col.names=c(rep('',2),'sample','nrdr','RR Hom matches','RA Het matches','AA Hom matches','RR Hom mismatches','RA Het mismatches','AA Hom mismatches','dosage_r'), colClasses=c(rep('NULL',2),'character',rep('numeric',8)));

palette <- c("#0072B2", "#D55E00");
cn_plot <- ggplot(data=concord, aes(x=c('100 samples'),y=dosage_r)) + geom_boxplot(orientation="horizontal") + scale_fill_manual(values=palette) +
     scale_y_continuous(name="dosage r squared") + scale_x_discrete(name="");
ggsave(filename=options[2],plot=cn_plot);
