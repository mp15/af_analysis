options <- commandArgs(trailingOnly = TRUE)

## PSC   [2]id   [3]sample       [4]nRefHom      [5]nNonRefHom   [6]nHets        [7]nTransitions [8]nTransversions       [9]nIndels      [10]average depth       [11]nSingletons

thirty <- read.table(options[1], header=F, col.names=c(rep('',2),'sample','nRefHom','nNonRefHom','nHets','ti','tv','indel','avgdepth','nSingletons'), colClasses=c(rep('NULL',2),'character',rep('numeric',8)));
#thirty$coverage <- '30x';

fifteen <- read.table(options[2], header=F, col.names=c(rep('',2),'sample','nRefHom','nNonRefHom','nHets','ti','tv','indel','avgdepth','nSingletons'), colClasses=c(rep('NULL',2),'character',rep('numeric',8)));
#fifteen$coverage <- '15x';

#covdata <-rbind(fifteen, thirty);

sink(options[3]);
t.test(fifteen$nSingletons,thirty$nSingletons, paired=T);
t.test(fifteen$indel,thirty$indel, paired=T);
t.test(fifteen$nHets,thirty$nHets, paired=T);
t.test(fifteen$nRefHom,thirty$nRefHom, paired=T);
t.test(fifteen$nNonRefHom,thirty$nNonRefHom, paired=T);
sink();

