require("ggplot2");
require("reshape");

options <- commandArgs(trailingOnly = TRUE)

covdata <- read.table(options[1], header=F, col.names=c(rep('',1),'id','ac_bin_min','ac_bin_max','snps','indels'), colClasses=c(rep('NULL',1),'factor',rep('numeric',4)));

covdata$ac_bin <- paste(covdata$ac_bin_min,covdata$ac_bin_max, sep="-");
covdata <- subset(covdata, covdata$ac_bin != '0-0')
covdata$ac_bin<-relevel(as.factor(covdata$ac_bin), '21-NA')
covdata$ac_bin<-relevel(as.factor(covdata$ac_bin), '3-20')
covdata$ac_bin<-relevel(as.factor(covdata$ac_bin), '2-2')
covdata$ac_bin<-relevel(as.factor(covdata$ac_bin), '1-1')

presentin_order <- c(0,1,2);
presentin <- c("30x only", "15x only", "Both");
palette <- c("#F0E442", "#0072B2", "#D55E00");
order <- c("1-1","2-2","3-20","21-NA");
names <- c("Singletons","Doubletons","3-20","21+");
hist_plot <- ggplot(data=covdata, aes(x=ac_bin, y=snps, fill=id)) + geom_bar(position="stack",stat="identity") + scale_fill_manual(name="Present in", limits=presentin_order, labels=presentin, values=palette) +
scale_y_continuous(name="Variants") + scale_x_discrete(name="Allele Count", limits = order, labels = names) + ggtitle("SNPs");
ggsave(filename=options[2],plot=hist_plot);
hist_plot <- ggplot(data=covdata, aes(x=ac_bin, y=indels, fill=id)) + geom_bar(position="stack",stat="identity") + scale_fill_manual(name="Present in", limits=presentin_order, labels=presentin, values=palette) +
scale_y_continuous(name="Variants") + scale_x_discrete(name="Allele Count", limits = order, labels = names) + ggtitle("INDELs");
ggsave(filename=options[3],plot=hist_plot);

data_tmp <- subset(melt(covdata), variable == 'snps', select=c(id,ac_bin,value));
covdata_snps <- cast(data_tmp, `ac_bin` ~ `id`, sum);
covdata_snps$sum <- covdata_snps$`0` + covdata_snps$`2`;
covdata_snps$type <- "SNPs";

data_tmp <- subset(melt(covdata), variable == 'indels', select=c(id,ac_bin,value));
covdata_indels <- cast(data_tmp, `ac_bin` ~ `id`, sum);
covdata_indels$sum <- covdata_indels$`0` + covdata_indels$`2`;
covdata_indels$type <- "INDELs";

covdata_combine <- rbind(covdata_snps, covdata_indels);

plotdata <-ggplot(covdata_combine, aes(x=ac_bin, y=`2`*100/sum, group=type,ymin=0,ymax=100,colour=type)) + geom_line() + scale_x_discrete(name="Allele Count", labels=names) + scale_y_continuous(name="Percentage of variants found") + ggtitle("Variants discovered in 15x from 30x");
ggsave(filename=options[4],plot=plotdata);
