options <- commandArgs(trailingOnly = TRUE)

## PSC   [2]id   [3]sample       [4]nRefHom      [5]nNonRefHom   [6]nHets        [7]nTransitions [8]nTransversions       [9]nIndels      [10]average depth       [11]nSingletons

thirty <- read.table(options[1], header=F, col.names=c(rep('',2),'sample','nRefHom','nNonRefHom','nHets','ti','tv','indel','avgdepth','nSingletons'), colClasses=c(rep('NULL',2),'character',rep('numeric',8)));
#thirty$coverage <- '30x';

fifteen <- read.table(options[2], header=F, col.names=c(rep('',2),'sample','nRefHom','nNonRefHom','nHets','ti','tv','indel','avgdepth','nSingletons'), colClasses=c(rep('NULL',2),'character',rep('numeric',8)));
#fifteen$coverage <- '15x';

#covdata <-rbind(fifteen, thirty);

printf <- function(...) invisible(cat(sprintf(...)));

sink(options[3]);
cat("field\t30x mean\t15x mean\tmean diff\tpercent mean diff\tp value\n");
t_sing <- t.test(fifteen$nSingletons,thirty$nSingletons, paired=T);
printf("Singletons\t%f\t%f\t%f\t%f\t%f\n",mean(thirty$nSingletons),mean(fifteen$nSingletons),
 t_sing$estimate,t_sing$estimate/mean(thirty$nSingletons),t_sing$p.value);
t_nrh <-t.test(fifteen$nNonRefHom,thirty$nNonRefHom, paired=T);
printf("Nonref Homs\t%f\t%f\t%f\t%f\t%f\n",mean(thirty$nNonRefHom),mean(fifteen$nNonRefHom),
t_nrh$estimate,t_nrh$estimate/mean(thirty$nNonRefHom),t_nrh$p.value);
t_het <- t.test(fifteen$nHets,thirty$nHets, paired=T);
printf("Hets\t%f\t%f\t%f\t%f\t%f\n",mean(thirty$nHets),mean(fifteen$nHets),
t_het$estimate,t_het$estimate/mean(thirty$nHets),t_het$p.value);
t_hom <-t.test(fifteen$nRefHom,thirty$nRefHom, paired=T);
printf("Ref Homs\t%f\t%f\t%f\t%f\t%f\n",mean(thirty$nRefHom),mean(fifteen$nRefHom),
t_hom$estimate,t_hom$estimate/mean(thirty$nRefHom),t_hom$p.value);
t_indel <- t.test(fifteen$indel,thirty$indel, paired=T);
printf("INDELs\t%f\t%f\t%f\t%f\t%f\n",mean(thirty$indel),mean(fifteen$indel),
t_indel$estimate,t_indel$estimate/mean(thirty$indel),t_indel$p.value);
sink();
