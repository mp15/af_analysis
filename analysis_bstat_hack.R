require("ggplot2");

options <- commandArgs(trailingOnly = TRUE)

thirty <- read.table(options[1], header=F, col.names=c(rep('',2),'ac_bin_min','ac_bin_max','snps','indel'), colClasses=c(rep('NULL',2),rep('numeric',4)));
thirty$coverage <- '30x';

fifteen <- read.table(options[2], header=F, col.names=c(rep('',2),'ac_bin_min','ac_bin_max','snps','indel'), colClasses=c(rep('NULL',2),rep('numeric',4)));
fifteen$coverage <- '15x';

covdata <-rbind(fifteen, thirty);
covdata$ac_bin <- paste(covdata$ac_bin_min,covdata$ac_bin_max, sep="-");

palette <- c("#0072B2", "#D55E00");
hist_plot <- ggplot(data=covdata, aes(x=ac_bin, y=snps, fill=coverage)) + geom_bar(position="dodge",stat="identity") + scale_fill_manual(values=palette) + scale_y_log10();
ggsave(filename=options[3],plot=hist_plot);
hist_indel_plot <- ggplot(data=covdata, aes(x=ac_bin, y=indel, fill=coverage)) + geom_bar(position="dodge",stat="identity") + scale_fill_manual(values=palette) + scale_y_log10();
ggsave(filename=options[4],plot=hist_indel_plot);
