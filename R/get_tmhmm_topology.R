#' Get the topology as predicted by TMHMM from
#' Bianchi et al., 2017.
#' Assumes the file is already downloaded.
#' Use \link{download_tmhmm_topology}
#' to download the pre-calculated topology.
#' @param tmhmm_filename name of the TMHMM file
#' @return a \link[tibble]{tibble}, with columns named
#' \code{name} and \code{sequences}
#' @export
get_tmhmm_topology <- function(
  tmhmm_filename
) {
  testthat::expect_true(file.exists(tmhmm_filename))
  t <- pureseqtmr::load_fasta_file_as_tibble_cpp(tmhmm_filename)
  t
}
