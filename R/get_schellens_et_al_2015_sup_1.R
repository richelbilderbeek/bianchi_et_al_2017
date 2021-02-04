#' Get the table of Supplementary Material 1 from
#' Schellens et al., 2015.
#' Will download the file if needed.
#' @param xlsx_filename the XLSX filename
#' @return a \link[tibble]{tibble}, with columns named
#' \code{cell_line},
#' \code{infected},
#' \code{epitope_sequence},
#' \code{epitope_length},
#' \code{copy_number},
#' \code{source_protein},
#' \code{gene},
#' \code{best_allele},
#' \code{best_allele_rank},
#' \code{best_allele_predscore},
#' \code{normalized_copyno}
#' @export
get_schellens_et_al_2015_sup_1 <- function(
  url = "http://richelbilderbeek.nl/schellens_et_al_2015_s_1.xlsx",
  xlsx_filename = file.path(
    rappdirs::user_data_dir(appname = "bianchietal2017"),
    "schellens_et_al_2015_s_1.xlsx"
  ),
  verbose = FALSE
) {
  if (!file.exists(xlsx_filename)) {
    bianchietal2017::download_schellens_et_al_2015_sup_1(
      url = url,
      xlsx_filename = xlsx_filename,
      verbose = verbose
    )
  }
  testthat::expect_true(file.exists(xlsx_filename))
  t <- readxl::read_excel(
    path = xlsx_filename,
    skip = 2
  )
  # Cleanup
  old_names <- names(t)
  testthat::expect_equal(old_names[2], "infected (0=no;1=yes)") # verbose
  old_names[2] <- "infected"
  testthat::expect_equal(old_names[3], "epitope sequence") # no underscore
  old_names[3] <- "epitope_sequence"
  testthat::expect_equal(old_names[4], "epitope length") # no underscore
  old_names[4] <- "epitope_length"
  testthat::expect_equal(old_names[8], "Best_Allele") # upper case?
  old_names[8] <- "best_allele"
  names(t) <- old_names
  t
}
