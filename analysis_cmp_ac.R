require("ggplot2");

options <- commandArgs(trailingOnly = TRUE)

covdata <- read.table(options[1], header=F, col.names=c(rep('',1),'id','ac_bin_min','ac_bin_max','snps','indels'), colClasses=c(rep('NULL',1),'factor',rep('numeric',4)));

covdata$ac_bin <- paste(covdata$ac_bin_min,covdata$ac_bin_max, sep="-");

presentin <- c("15x only", "30x only", "Both");
palette <- c("#F0E442", "#0072B2", "#D55E00");
order <- c("1-1","2-2","3-20","21-NA");
names <- c("Singletons","Doubletons","3-20","21+");
hist_plot <- ggplot(data=covdata, aes(x=ac_bin, y=snps, fill=id)) + geom_bar(position="stack",stat="identity") + scale_fill_manual(name="Present in", labels=presentin, values=palette) +
scale_y_continuous(name="Variants") + scale_x_discrete(name="Allele Count", limits = order, labels = names) + ggtitle("SNPs");
ggsave(filename=options[2],plot=hist_plot);
hist_plot <- ggplot(data=covdata, aes(x=ac_bin, y=indels, fill=id)) + geom_bar(position="stack",stat="identity") + scale_fill_manual(name="Present in", labels=presentin, values=palette) +
scale_y_continuous(name="Variants") + scale_x_discrete(name="Allele Count", limits = order, labels = names) + ggtitle("INDELs");
ggsave(filename=options[3],plot=hist_plot);
