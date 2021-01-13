#' Downloads the XLSX file by Schellens et al., 2015
#' @param url the download URL. Note that the original URL is
#'   \url{https://doi.org/10.1371/journal.pone.0136417.s005},
#'   which redirects to an unknown (and hence unusable)
#'   actual download URL
#' @param xlsx_filename the XLSX filename
#' @param verbose set to TRUE for more output
#' @return the XLSX filename of the downloaded file
#' @seealso use \link{get_schellens_et_al_2015_sup_1} to
#'   read the table as a \link{tibble}[tibble]
#' @export
download_schellens_et_al_2015_sup_1 <- function(
  url = "http://richelbilderbeek.nl/schellens_et_al_2015_s_1.xlsx",
  xlsx_filename = tempfile(fileext = ".xlsx"),
  verbose = FALSE
) {
  utils::download.file(
    url = url,
    destfile = xlsx_filename,
    quiet = !verbose
  )
  xlsx_filename
}
