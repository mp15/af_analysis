require(ggplot2)
require(reshape2)

# Usage: R --vanilla --slave --args infile="data.tsv" outfile="plot.pdf" < downsampling-plot.R
infile="downsampling.tsv"
outfile="downsampling.png"
width.cm="27"
height.cm="12"

###############################################################################
# Process command-line arguments into variables, overriding defaults.
###############################################################################
for (e in commandArgs(trailingOnly=TRUE)) {
  ta = strsplit(e,"=",fixed=TRUE)
  if(!is.null(ta[[1]][2])) {
    assign(ta[[1]][1],ta[[1]][2])
  } else {
    assign(ta[[1]][1],TRUE)
  }
}

data <- read.table(infile, sep="\t", header=TRUE, as.is=TRUE, colClasses=c(NA,NA,"NULL",NA,"NULL",NA))

data.melt <- melt(data=data,id.vars="Downsampled.Coverage")

levels(data.melt$variable) <- gsub(pattern="[.]",replacement=" ", x=levels(data.melt$variable))

rate.plot <- ggplot(data=data.melt) + geom_path(mapping=aes(x=Downsampled.Coverage, y=value*100, colour=variable), size=1) + scale_colour_brewer(palette="Dark2", name="") + scale_y_continuous(breaks=seq(from=0,to=100,by=5), name="Rate %") + scale_x_continuous(breaks=seq(from=5,to=30,by=2.5), name="Downsampled Coverage")

ggsave(filename=outfile, plot=rate.plot, width=as.numeric(as.character(width.cm)), height=as.numeric(as.character(height.cm)), units="cm")
