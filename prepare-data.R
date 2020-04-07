# Converts the human proteome, as downloaded from UniProt,
# into a more convenient data structure to work with: a named
# list of strings. 

# Also creates a few other files that are helpful for the analysis.

library( seqinr )
x <- read.fasta("proteome/UP000005640_9606.fasta.gz", 
	forceDNAtolower=FALSE, as.string=TRUE )
x <- lapply( x, function(x) x[1] )
names( x ) <- sapply( strsplit( names(x), "\\|" ), function(x) x[2] )

sink("work/protein-lengths.txt")
for( i in seq_along(x) ){
        cat(names(x)[i]," ",nchar(x[[i]]),"\n",sep="")
}
sink()

proteome <- x

#proteome <- lapply( x, function(x) strsplit( x,"" )[[1]] )

save(proteome,file="work/proteome.Rdata")

# generate a list containing the starting position of all 9mers overlapping
# with predicted transmembrane helices
library( data.table )
x <- read.table("tmh-predictions/trans-membrane-analysis-shortened.txt")
x <- x[x$V2=="TMhelix",c(1,3,4)]

x <- tapply( 1:nrow(x), list(x$V1), 
	function(p) do.call( c, lapply( p, function(k) seq(x[k,2]-8,x[k,3])) )  ) 

for( i in names(x) ){
	x[[i]] <- intersect( x[[i]], 1:(nchar(proteome[[i]])-8) )
}

for( i in names(proteome) ){
	if( is.null(x[[i]]) ){
		x[[i]] <- integer(0)
	}
}

tmh.9mers <- x
save( tmh.9mers, file="work/tmh.9mers.Rdata" )

  
