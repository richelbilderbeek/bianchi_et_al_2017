#' Downloads the \code{fasta.gz} file by Bianchi et al., 2017
#' @param url the download URL,
#'   which is \url{ftp://ftp.ebi.ac.uk/pub/databases/reference_proteomes/QfO/Eukaryota/UP000005640_9606.fasta.gz}
#' @param xlsx_filename the XLSX filename
#' @param verbose set to TRUE for more output
#' @return the XLSX filename of the downloaded file
#' @seealso use \link{get_schellens_et_al_2015_sup_1} to
#'   read the table as a \link{tibble}[tibble]
#' @export
download_proteome <- function(
  url = "ftp://ftp.ebi.ac.uk/pub/databases/reference_proteomes/QfO/Eukaryota/UP000005640_9606.fasta.gz",
  fasta_gz_filename = tempfile(fileext = ".fasta.gz"),
  verbose = FALSE
) {
  utils::download.file(
    url = url,
    destfile = fasta_gz_filename,
    quiet = !verbose
  )
  fasta_gz_filename
}
