#' Downloads the \code{fasta.gz} file by Bianchi et al., 2017
#' @param url the download URL,
#'   which is \url{ftp://ftp.ebi.ac.uk/pub/databases/reference_proteomes/QfO/Eukaryota/UP000005640_9606.fasta.gz}
#' @param fasta_gz_filename the \code{fasta.gz} filename
#' @param verbose set to TRUE for more output
#' @return the \code{fasta.gz} name of the downloaded file
#' @export
download_proteome <- function(
  url = get_proteome_url(),
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
