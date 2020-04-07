# Determines the hydrophobicity distribution of all peptides
# in the human proteome as well as all peptides overlapping
# with transmembrane helices.

load("work/proteome.Rdata")
load("data/kyte.doolittle.scale.Rdata")
source("tools.R")

proteome.hydrophobicity <- lapply( proteome, function(x) kyte.doolittle.scale[explode(x)] )
proteome.9mer.hydrophobicity <- lapply( proteome.hydrophobicity, 
	function(x) 
		if( length(x)>=9 ) tail( filter( x, rep(1/9,9), sides=1 ), -8 )
		else c() )
save( proteome.9mer.hydrophobicity, file="work/proteome.9mer.hydrophobicity.Rdata" )

load("work/tmh.9mers.Rdata")
tmh.9mer.hydrophobicity <- nlapply( tmh.9mers, function(n, x)
	proteome.9mer.hydrophobicity[[n]][x] )

pdf("plots/figure-1-b.pdf", width=4, height=4, useDingbats=FALSE)
par(bty="n", mar=c(4,4,.2,.2))

plot( density( unlist(proteome.9mer.hydrophobicity, use.names=FALSE), na.rm=TRUE ),
	xlab="Mean hydrophobicity index in 9-mer",
	ylab="Probability density", xlim=c(-5,5),
	main="" )

lines( density( unlist( tmh.9mer.hydrophobicity, use.names=FALSE), na.rm=TRUE ),
	col=2 )


legend( "topleft", c("all 9-mers"),text.col=c("black"), bty="n" )
legend( "topright", c("predicted\nTMH\n9-mers"), text.col=c("red"), bty="n" )

dev.off()




pdf("plots/figure-1-c.pdf", width=4, height=4, useDingbats=FALSE)

is.tmh <- nlapply( proteome.9mer.hydrophobicity, function(n,x){ 
	r <- rep(0,length(x))
	r[tmh.9mers[[n]]] <- 1
	r  } )

d <- cbind( unlist(proteome.9mer.hydrophobicity,use.names=FALSE), 
	unlist(is.tmh,use.names=FALSE) )
d[,1] <- cut(d[,1],10)
barplot( 100*by( d[,2], d[,1], mean ), 
	xlab="Hydrophobicity index decile", ylab="Percentage of predicted TMH 9-mers",
	ylim=c(0,100), border=NA )

dev.off()
