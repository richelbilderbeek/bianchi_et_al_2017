library( seqinr )

# devtools::install_github("jtextor/epitope-prediction")
library( EpitopePrediction )

argv <- commandArgs( trailingOnly = TRUE )
mhc <- argv[1]

mhc <- gsub("([AB][0-9][[0-9])-([0-9][0-9])","\\1:\\2",mhc)

x <- read.fasta("proteome/UP000005640_9606.fasta.gz", 
		forceDNAtolower=FALSE, as.string=TRUE )

for( i in seq_along(x) ){
	tryCatch({
		xn <- strsplit(attr(x[[i]],'name'),"\\|")[[1]][2]
		xb <- binders( x[[i]], mhc, quantile.threshold=.02 )
		write.table( cbind( xn, xb[,1:3] ), col.names=F, row.names=F, quote=F ) 
		 }, error=function(e){} )
}

