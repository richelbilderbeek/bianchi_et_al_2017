.SECONDARY:
.DELETE_ON_ERROR:



mhcs=HLA-A01-01 HLA-A02-01 HLA-A03-01 HLA-A24-02 HLA-A26-01 HLA-B07-02 HLA-B08-01 HLA-B18-01 HLA-B27-05 HLA-B39-01 HLA-B40-02 HLA-B58-01 HLA-B15-01

# These figure panels are at the leaves of the dependency graph.
# All other figure panels are made as side-effects by intermediate
# scripts.
all: proteome/UP000005640_9606.fasta.gz plots/figure-4-b.pdf plots/figure-3-a.pdf plots/figure-1-d.pdf 

full: proteome/full.fasta.gz
	cp proteome/full.fasta.gz proteome/UP000005640_9606.fasta.gz
	touch proteome/use_full
	make

test: proteome/short.fasta.gz
	cp proteome/short.fasta.gz proteome/UP000005640_9606.fasta.gz
	touch proteome/use_test
	make

binders: $(foreach m,$(mhcs),binding-predictions/$m.txt)

plots/figure-4-b.pdf: calculate-overlap-controls.R work/hydrophobe-control-peptides.Rdata binders
	Rscript $<

work/hydrophobe-control-peptides.Rdata: hydrophobe-controls.R work/proteome.9mer.hydrophobicity.Rdata
	Rscript $<

plots/figure-3-a.pdf: hydrophobicity-distribution-elution-data.R
	Rscript $<

plots/figure-1-d.pdf: correlate-to-hydrophobicity.R work/tmh-overlapping-binders.Rdata
	Rscript $<

work/proteome.9mer.hydrophobicity.Rdata: hydrophobicity-distribution.R work/proteome.Rdata proteome/use_full
	Rscript $<

work/tmh-overlapping-binders.Rdata: calculate-overlap.R work/proteome.Rdata binders
	Rscript $<

# also generates some other files, see the script
work/proteome.Rdata : prepare-data.R proteome/UP000005640_9606.fasta.gz
	Rscript $<

binding-predictions/HLA-%.txt : predict-binders.R proteome/UP000005640_9606.fasta.gz
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
