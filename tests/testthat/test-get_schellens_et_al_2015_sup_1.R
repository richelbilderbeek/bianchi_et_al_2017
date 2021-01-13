test_that("use", {
  xlsx_filename <- download_schellens_et_al_2015_sup_1()
  expect_true(file.exists(xlsx_filename))
  t <- get_schellens_et_al_2015_sup_1(
    xlsx_filename = xlsx_filename
  )
  expect_true(tibble::is_tibble(t))
  expected_names <- c(
    "cell_line",
    "infected",
    "epitope_sequence",
    "epitope_length",
    "copy_number",
    "source_protein",
    "gene",
    "best_allele",
    "best_allele_rank",
    "best_allele_predscore",
    "normalized_copyno"
  )
  expect_equal(names(t), expected_names)
})
