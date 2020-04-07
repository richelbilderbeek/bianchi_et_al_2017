
# explodes a string into a character vector
explode <- function(s) strsplit(s,"")[[1]]

# version of lapply that also passes along the 
# name of each list element. f must be a function
# with arguments n and x.

nlapply <- function( l, f ) mapply( f, 
	n=names(l), 
	x=l )

