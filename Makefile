.SECONDARY:
.DELETE_ON_ERROR:



mhcs = HLA-A01-01 HLA-A02-01 HLA-A03-01 HLA-A24-02 HLA-A26-01 HLA-B07-02 HLA-B08-01 HLA-B18-01 HLA-B27-05 HLA-B39-01 HLA-B40-02 HLA-B58-01 HLA-B15-01
proteome_filename = proteome/UP000005640_9606.fasta.gz
tma_filename = tmh-predictions/trans-membrane-analysis-shortened.txt

targets = $(proteome_filename) plots/figure-3-a.pdf plots/figure-1-d.pdf

# These figure panels are at the leaves of the dependency graph.
# All other figure panels are made as side-effects by intermediate
# scripts.
all: $(targets)
#all: proteome/UP000005640_9606.fasta.gz plots/figure-4-b.pdf plots/figure-3-a.pdf plots/figure-1-d.pdf 

full: proteome/full.fasta.gz
	cp proteome/full.fasta.gz $(proteome_filename)
	make

test: proteome/short.fasta.gz
	cp proteome/short.fasta.gz $(proteome_filename)
	make

binders: $(foreach m,$(mhcs),binding-predictions/$m.txt)

#plots/figure-4-b.pdf: calculate-overlap-controls.R work/hydrophobe-control-peptides.Rdata binders
#	Rscript $<

#work/hydrophobe-control-peptides.Rdata: hydrophobe-controls.R work/proteome.9mer.hydrophobicity.Rdata
#	Rscript $<

plots/figure-3-a.pdf: hydrophobicity-distribution-elution-data.R
	Rscript $<

plots/figure-1-d.pdf: correlate-to-hydrophobicity.R work/tmh-overlapping-binders.Rdata
	Rscript $<

#work/proteome.9mer.hydrophobicity.Rdata: hydrophobicity-distribution.R work/proteome.Rdata
#	Rscript $<

work/tmh-overlapping-binders.Rdata: calculate-overlap.R work/proteome.Rdata binders
	Rscript $<

# File 1/3 created by prepare-data.R
work/protein-lengths.txt : prepare-data.R $(proteome_filename) $(tma_filename)
	Rscript $<

# File 2/3 created by prepare-data.R
work/proteome.Rdata : prepare-data.R $(proteome_filename) $(tma_filename)
	Rscript $<

# File 3/3 created by prepare-data.R
work/tmh.9mers.Rdata : prepare-data.R $(proteome_filename) $(tma_filename)
	Rscript $<

binding-predictions/HLA-%.txt : predict-binders.R $(proteome_filename)
	Rscript $< HLA-$* > $@	

proteome/full.fasta.gz:
	wget ftp://ftp.ebi.ac.uk/pub/databases/reference_proteomes/QfO/Eukaryota/UP000005640_9606.fasta.gz -O proteome/full.fasta.gz

proteome/full.fasta: proteome/full.fasta.gz
	gunzip -k proteome/full.fasta.gz

proteome/short.fasta: proteome/full.fasta
	head proteome/full.fasta -n 21 > proteome/short.fasta

proteome/short.fasta.gz: proteome/short.fasta
	gzip -k proteome/short.fasta

clean:
	rm -f plots/* proteome/* work/* binding-predictions/*

pic:
	make -Bnd | ../makefile2graph/make2graph | dot -Tpng -o pics/makefile.png

