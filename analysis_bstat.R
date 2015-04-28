require("ggplot2");

options <- commandArgs(trailingOnly = TRUE)

thirty <- read.table(options[1], header=F, col.names=c(rep('',2),'allelefreq','snps','ti','tv','indel',rep('',3)), colClasses=c(rep('NULL',2),rep('numeric',5),rep('NULL',3)));
thirty$coverage <- '30x';

fifteen <- read.table(options[2], header=F, col.names=c(rep('',2),'allelefreq','snps','ti','tv','indel',rep('',3)), colClasses=c(rep('NULL',2),rep('numeric',5),rep('NULL',3)));
fifteen$coverage <- '15x';

covdata <-rbind(fifteen, thirty);

palette <- c("#0072B2", "#D55E00");
hist_plot <- ggplot(data=covdata, aes(x=allelefreq, y=snps, colour=coverage)) + geom_line() + scale_fill_manual(values=palette) + scale_y_log10();
ggsave(filename=options[3],plot=hist_plot);
hist_indel_plot <- ggplot(data=covdata, aes(x=allelefreq, y=indel, colour=coverage)) + geom_line() + scale_fill_manual(values=palette) + scale_y_log10();
ggsave(filename=options[4],plot=hist_indel_plot);
