# bianchi_et_al_2017

Branch   |[![Travis CI logo](pics/TravisCI.png)](https://travis-ci.org)
---------|----------------------------------------------------------------------------------------------------------------------------------------------------------
`master` |[![Build Status](https://travis-ci.org/richelbilderbeek/bianchi_et_al_2017.svg?branch=master)](https://travis-ci.org/richelbilderbeek/bianchi_et_al_2017)
`develop`|[![Build Status](https://travis-ci.org/richelbilderbeek/bianchi_et_al_2017.svg?branch=develop)](https://travis-ci.org/richelbilderbeek/bianchi_et_al_2017)

R code for 'Transmembrane Helices Are an Overlooked Source of Major Histocompatibility Complex Class I Epitopes', by Frans Bianchi, Johannes Textor and Geert van den Bogaart.

These R scripts make almost all figures in the paper 
"Transmembrane helices are an overlooked source of MHC class I epitopes"
by Frans Bianchi, Johannes Textor, and Geert van den Bogaart.
(DOI: 10.3389/fimmu.2017.01118)

Figure 3 is not made by these scripts, as it was made using another
program.

## Usage

If you have all prerequisites installed, 
you should be able to create all figures by typing `make full ; make`. 
All necessary data will either be downloaded (such
as the human proteome) or is included in the folder `data/` (such as the
transmembrane domain predictions).

Be aware that the HLA binding predictions can take several hours. It can
be useful to speed up the process by running e.g. 'make -j 8' to run 8 
jobs in parallel. 

### Run test

```
make clean
make test
make
```

### Run full

```
make clean
make full
make
```

## Prerequisites

To run the code, you need:

 * A working R installation and the R packages `seqinr` and `data.table`
 * The R package `EpitopePrediction`, which can be installed from github
   using `remotes::install_github("jtextor/epitope-prediction")`
 * GNU Make
 * The program `wget`

If you do not have the program `wget` or do not wish to install it, you 
can also download the human proteome yourself and store it in the folder
'proteome/' before typing 'make'. 

## Files

The folder 'data' contains two files with peptide sequences that were 
eluted from B lymphoblastoid cell lines. These sequences are taken from
the following publication, which is also cited in our paper:

"Comprehensive analysis of the naturally processed peptide repertoire:
 differences between HLA-A and B in the immunopeptidome" 
by Schellens et al, PLoS One (2015) 10:e0136417. 
(DOI: 10.1371/journal.pone.0136417)
