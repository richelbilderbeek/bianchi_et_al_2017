#' Get the proteome from
#' Bianchi et al., 2017.
#' Assumes the file is already downloaded.
#' Use \link{download_proteome}
#' to download the file.
#' @param fasta_gz_filename the \code{.fasta.gz} filename
#' @param fasta_filename name of a temporary FASTA file
#' @return a \link[tibble]{tibble}, with columns named
#' \code{name} and \code{sequences}
#' @export
get_proteome <- function(
  fasta_gz_filename,
  fasta_filename = tempfile(fileext = ".fasta")
) {
  testthat::expect_true(file.exists(fasta_gz_filename))
  R.utils::gunzip(
    filename = fasta_gz_filename,
    destname = fasta_filename,
    remove = FALSE
  )
  testthat::expect_true(file.exists(fasta_gz_filename))
  testthat::expect_true(file.exists(fasta_filename))
  t <- pureseqtmr::load_fasta_file_as_tibble_cpp(fasta_filename)
  t
}
