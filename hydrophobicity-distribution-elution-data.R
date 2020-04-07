load("data/kyte.doolittle.scale.Rdata")
source("tools.R")

tmh.eluted <- read.table("data/TMH-Bcell-elution.txt",as.is=TRUE)$V1
nontmh.eluted <- read.table("data/non-TMH-Bcell-elution.txt",as.is=TRUE)$V1


pdf("plots/figure-3-a.pdf", width=4, height=4, useDingbats=FALSE)
par(bty="n", mar=c(4,4,.2,.2))


hy <- function(x) mean(kyte.doolittle.scale[explode(x)])

tmh.eluted <- sapply(tmh.eluted,hy)
nontmh.eluted <- sapply(nontmh.eluted,hy)

plot( density(nontmh.eluted),
	xlab="Mean hydrophobicity index in peptide",
	ylab="Probability density",
	main="" )
lines( density(tmh.eluted), col=2 )

legend( "topleft", c("all peptides"),text.col=c("black"), bty="n" )
legend( "topright", c("TMH peptides"), text.col=c("red"), bty="n" )

dev.off()


pdf("plots/figure-3-b.pdf", width=4, height=4, useDingbats=FALSE)
par(bty="n", mar=c(4,4,.2,.2))

d <- cbind( c(tmh.eluted,nontmh.eluted), 0 )
d[1:length(tmh.eluted),2] <- 1

d[,1] <- cut(d[,1],10)
barplot( 100*by( d[,2], d[,1], mean ), 
	xlab="Decile of mean hydrophobicity index", ylab="Percentage eluted TMH peptides",
	ylim=c(0,45), border=NA )

dev.off()

