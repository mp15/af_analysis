options <- commandArgs(trailingOnly = TRUE)

## PSC   [2]id   [3]sample       [4]nRefHom      [5]nNonRefHom   [6]nHets        [7]nTransitions [8]nTransversions       [9]nIndels      [10]average depth       [11]nSingletons

thirty <- read.table(options[1], header=F, col.names=c(rep('',2),'sample','nRefHom','nNonRefHom','nHets','ti','tv','indel','avgdepth','nSingletons'), colClasses=c(rep('NULL',2),'character',rep('numeric',8)));
#thirty$coverage <- '30x';

fifteen <- read.table(options[2], header=F, col.names=c(rep('',2),'sample','nRefHom','nNonRefHom','nHets','ti','tv','indel','avgdepth','nSingletons'), colClasses=c(rep('NULL',2),'character',rep('numeric',8)));
#fifteen$coverage <- '15x';

#covdata <-rbind(fifteen, thirty);

sink(options[3]);
cat("Results filtered to 1000 Genomes sites only\n");
cat("Singletons\n");
summary(thirty$nSingletons);
t_sing <- t.test(fifteen$nSingletons,thirty$nSingletons, paired=T);
t_sing;
cat("Percentage of ");
t_sing$estimate/mean(thirty$nSingletons);
cat("Nonref Homs\n");
summary(thirty$nNonRefHom);
t_nrh <-t.test(fifteen$nNonRefHom,thirty$nNonRefHom, paired=T);
t_nrh;
cat("Percentage of ");
t_nrh$estimate/mean(thirty$nNonRefHom);
cat("Hets\n");
summary(thirty$nHets);
t_het <- t.test(fifteen$nHets,thirty$nHets, paired=T);
t_het;
cat("Percentage of ");
t_het$estimate/mean(thirty$nHets);
cat("Ref Homs\n");
summary(thirty$nRefHom);
t_hom <-t.test(fifteen$nRefHom,thirty$nRefHom, paired=T);
t_hom;
cat("Percentage of ");
t_hom$estimate/mean(thirty$nRefHom);
cat("INDELs\n");
summary(thirty$indel);
t_indel <- t.test(fifteen$indel,thirty$indel, paired=T);
t_indel;
cat("Percentage of ");
t_indel$estimate/mean(thirty$indel);
sink();
