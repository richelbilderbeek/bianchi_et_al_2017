#' Downloads the \code{.tmhmm} file by Bianchi et al., 2017
#' @param url the download URL,
#'   which is \url{http://richelbilderbeek.nl/UP000005640_9606.tmhmm}
#' @param tmhmm_filename the TMHMM filename
#' @param verbose set to TRUE for more output
#' @return the TMHMM filename of the downloaded file
#' @seealso use \link{get_tmhmm_topology} to
#'   read the table as a \link[tibble]{tibble}
#' @export
download_tmhmm_topology <- function(
  url = "http://richelbilderbeek.nl/UP000005640_9606.tmhmm",
  tmhmm_filename = tempfile(fileext = ".tmhmm"),
  verbose = FALSE
) {
  utils::download.file(
    url = url,
    destfile = tmhmm_filename,
    quiet = !verbose
  )
  tmhmm_filename
}
