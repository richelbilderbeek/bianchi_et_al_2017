# Performs the same analysis as "calculate-overlap.R", but now for the
# 'control population' consisting of 9mers that do not overlap with 
# transmembrane helices.

load("work/hydrophobe-control-peptides.Rdata" )

library( data.table )

d2 <- unstack(hydrophobe.control.peptides,
	`9mer` ~ protein)

pldf <- read.table( "work/protein-lengths.txt", row.names=1 )
pl <- pldf[,1]
names(pl) <- rownames(pldf)

ninemers.in.tmhs <- sapply( d2, length )
ninemers.total <- pl-8
ninemers.total[ninemers.total < 0] <- 0

perc.binders <- function( mhc = "A01-01" ){
	message( mhc )
	d <- fread(paste0("binding-predictions/HLA-",mhc,".txt"), data.table=FALSE)[,c(1,3)]
	colnames(d) <- c("protein", "start") 
	d <- unstack( d, start ~ protein )
	binders.in.tmhs <- sapply( names(d) , function(i) length( intersect( d[[i]], d2[[i]] ) ) )
	c( sum( binders.in.tmhs ), sum( sapply( d, length ) ) )
}

hlas <- c("A01-01","A02-01","A03-01","A24-02","A26-01",
	"B07-02","B08-01","B15-01","B18-01",
	"B27-05","B39-01","B40-02","B58-01")

r <- sapply( hlas, 
	perc.binders )

pdf("plots/figure-4-b.pdf",
	width=4,height=4,useDingbats=FALSE)

par( mar=c(6,5,.2,.2) ) 


barplot( 1000 * r[1,] / r[2,], xlab="", 
	ylab="% epitopes overlapping\nwith transmembrane helix", border=NA, las=2 )

mtext( "HLA haplotype", 1, line=4.5 )

pbin <- sum( ninemers.in.tmhs) / sum(ninemers.total)

ci <- ( binom.test( round(0.02*sum(ninemers.in.tmhs)), round(0.02*sum(ninemers.total)), p=pbin, 
	conf.level=0.999  ) )$conf

abline( h=1000*ci[1], col=2 )
abline( h=1000*ci[2], col=2 )

dev.off()

for( h in hlas ){
	cat( h, "\t", binom.test( r[1,h], r[2,h], p=pbin )$p.value," \n" )	
}
