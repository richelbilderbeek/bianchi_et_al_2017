# Generates a set of 9mers that do not overlap with transmembrane helices
# and have a very similar hydrophobicity distribution as the set of 9mers 
# that do overlap with transmembrane helices.

load("work/proteome.9mer.hydrophobicity.Rdata")
load("work/tmh.9mers.Rdata")

source("tools.R")

is.tmh <- nlapply( proteome.9mer.hydrophobicity, function(n,x){ 
	r <- rep(0,length(x))
	r[tmh.9mers[[n]]] <- 1
	r  } )

indices.9mers <- lapply( proteome.9mer.hydrophobicity, seq_along )

d <- cbind( stack( proteome.9mer.hydrophobicity ), 
	unlist( indices.9mers, use.names=FALSE ),
	unlist( is.tmh, use.names=FALSE ) )


d <- d[,c(2,3,1,4)]
colnames(d) <- c("protein","9mer", "hy", "tmh")

grp <- quantile( d[d$tmh==1, "hy"], probs=seq(0,1,length.out=101), na.rm=TRUE )
grp[1] <- grp[1]*0.99
grp[2] <- grp[2]*1.01

d2 <- d[d$tmh==0 & d$hy >= grp[1] & d$hy <= tail(grp,1),]
d2$hyg <- cut( d2$hy, breaks=grp )

n.per.group <- sum(d$tmh)/10/100 

hydrophobe.control.peptides <- do.call( rbind, 
	by( d2[,c("protein","9mer","hy")], d2$hyg, 
	function(x) x[sample(1:nrow(x),n.per.group),] ) )

save( hydrophobe.control.peptides, file="work/hydrophobe-control-peptides.Rdata" )

pdf("plots/figure-4-a.pdf",useDingbats=FALSE, width=4,height=4 )
par( bty="n", mar=c(4,4,.2,.2) )

plot( density( d$hy, na.rm=TRUE ) ,
	xlab="Mean hydrophobicity index in 9-mer",
	ylab="Probability density", xlim=c(-5,5),
	main="" )

lines( density( d[d$tmh==1,"hy"], na.rm=TRUE ), col=2 ) 
lines( density( hydrophobe.control.peptides$hy, na.rm=TRUE ), col=3 )


legend( "topleft", c("all 9-mers"),text.col=c("black"), bty="n" )
legend( "topright", c("predicted\nTMH\n9-mers"), text.col=c("red"), bty="n" )
legend( "topright", c("\n\n\nmatched\nnon-TMH\n9-mers"), text.col=c("green"), bty="n" )

dev.off()


