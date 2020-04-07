library( EpitopePrediction )

load("work/tmh-overlapping-binders.Rdata")
load("data/kyte.doolittle.scale.Rdata")

M <- smmMatrix( "HLA-A02:01" )$M

hyPref <- function( mhc="A02-01" ){
	mhc <- paste0("HLA-",gsub("-",":",mhc))

	M <- 10^(-smmMatrix(mhc)$M)

	M <- scale(M, center = FALSE, scale = colSums(M))
  
	colEntropies <- apply(M, 2, function(x) {
        	x <- x * log(x)
        	x[is.nan(x)] <- 0
      		log(20) + sum(x)
    	})
    	M <- scale(M, center = FALSE, scale = 1/colEntropies)

	sum(sweep( M, 1, kyte.doolittle.scale[rownames(M)], "*" )) / 9
}

pdf("plots/figure-1-d.pdf", width=4, height=4,
	useDingbats=FALSE)

par( bty="n", mar=c(4,4,.2,.2) )

x <- 100* r[1,] / r[2,]
y <- sapply( colnames(r), hyPref )+0.3963411

plot( NA, 
	xlab="Percentage of TMH epitopes",
	ylab="Hydrophobic preference score",
	xlim=c(2,15), ylim=c(-1.5,1.5) )

abline( lm(y~x), col="gray")

points( x, y, pch=19, cex=0.8 )

text( x, y, substring( colnames(r), 1,3 ),
	pos=c(1L, 2L, 4L, 4L, 2L, 4L, 4L, 4L, 1L, 4L, 4L, 2L, 4L), srt=0, cex=.8, offset=.3 )

legend( "topleft", legend=bquote( r == .(signif(cor(x,y),2)) ), bty='n' )

dev.off()

