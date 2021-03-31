library(EpitopePrediction)

# Loads 'r'
load("work/tmh-overlapping-binders.Rdata")

# Calculate the hydrophobic preference score from a haplotype
hyPref <- function( mhc="A02-01" ){
	mhc <- paste0("HLA-",gsub("-",":",mhc))

	M <- 10^(-smmMatrix(mhc)$M)

	M <- scale(M, center = FALSE, scale = colSums(M))

	colEntropies <- apply(M, 2, function(x) {
        	x <- x * log(x)
        	x[is.nan(x)] <- 0
      		log(20) + sum(x) # 20 is the number of (regular) amino acids
    	})
    	M <- scale(M, center = FALSE, scale = 1/colEntropies)

	sum(sweep( M, 1, Peptides::hydrophobicity(rownames(M)), "*" )) / 9  # The most common length of an epitope, in AAs
}

pdf("plots/figure-1-d.pdf", width=4, height=4,
	useDingbats=FALSE)

par( bty="n", mar=c(4,4,.2,.2) )

# x: percentage of binders that are TMH, e.g. 7.68 equals 7.68 percent
x <- 100* r[1,] / r[2,]
# y: hydrophobic preference scores
y <- sapply( colnames(r), hyPref ) + 0.3963411 # Where does this value come from?

plot( NA,
	xlab="Percentage of TMH epitopes",
	ylab="Hydrophobic preference score",
	xlim=c(2,15), ylim=c(-1.5,1.5) )

# In a test run, all x values are zeroes
if (!all(x == 0.0) ) {
  abline( lm(y~x), col="gray")
}

points( x, y, pch=19, cex=0.8 )

text( x, y, substring( colnames(r), 1,3 ),
	pos=c(1L, 2L, 4L, 4L, 2L, 4L, 4L, 4L, 1L, 4L, 4L, 2L, 4L), srt=0, cex=.8, offset=.3 )

# In a test run, all x values are zeroes
if (!all(x == 0.0) ) {
  legend( "topleft", legend=bquote( r == .(signif(cor(x,y),2)) ), bty='n' )
}

dev.off()

