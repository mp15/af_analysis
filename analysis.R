require("ggplot2");

options <- commandArgs(trailingOnly = TRUE)

thirty <- read.table(options[1], header=F, col.names=c('allelefreq'));
thirty$coverage <- '30x';

fifteen <- read.table(options[2], header=F, col.names=c('allelefreq'));
fifteen$coverage <- '15x';

covdata <-rbind(fifteen, thirty);

palette <- c("#0072B2", "#D55E00");
hist_plot <- ggplot(data=covdata, aes(x=allelefreq, fill=coverage)) + geom_bar(position="dodge",binwidth=0.1) + scale_fill_manual(values=palette);
ggsave(filename=options[3],plot=hist_plot);
