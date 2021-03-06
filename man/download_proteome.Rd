% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/download_proteome.R
\name{download_proteome}
\alias{download_proteome}
\title{Downloads the \code{fasta.gz} file by Bianchi et al., 2017}
\usage{
download_proteome(
 
    url = "ftp://ftp.ebi.ac.uk/pub/databases/reference_proteomes/QfO/Eukaryota/UP000005640_9606.fasta.gz",
  fasta_gz_filename = tempfile(fileext = ".fasta.gz"),
  verbose = FALSE
)
}
\arguments{
\item{url}{the download URL,
which is \url{ftp://ftp.ebi.ac.uk/pub/databases/reference_proteomes/QfO/Eukaryota/UP000005640_9606.fasta.gz}}

\item{verbose}{set to TRUE for more output}

\item{xlsx_filename}{the XLSX filename}
}
\value{
the XLSX filename of the downloaded file
}
\description{
Downloads the \code{fasta.gz} file by Bianchi et al., 2017
}
\seealso{
use \link{get_schellens_et_al_2015_sup_1} to
  read the table as a \link{tibble}[tibble]
}
