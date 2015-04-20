require("ggplot2");

options <- commandArgs(trailingOnly = TRUE)

thirty <- read.table(options[1], header=F, col.names=c(rep('',2),'allelefreq','snps',rep('',6)), colClasses=c(rep('NULL',2),rep('numeric',2),rep('NULL',6)));
thirty$coverage <- '30x';

fifteen <- read.table(options[2], header=F, col.names=c(rep('',2),'allelefreq','snps',rep('',6)), colClasses=c(rep('NULL',2),rep('numeric',2),rep('NULL',6)));
fifteen$coverage <- '15x';

covdata <-rbind(fifteen, thirty);

palette <- c("#0072B2", "#D55E00");
hist_plot <- ggplot(data=covdata, aes(x=allelefreq, y=snps, fill=coverage)) + geom_line() + scale_fill_manual(values=palette);
ggsave(filename=options[3],plot=hist_plot);