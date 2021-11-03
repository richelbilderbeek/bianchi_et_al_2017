test_that("use", {
  skip("TODO: remove? Use 'bbbq::get_proteome' instead")
  fasta_gz_filename <- download_proteome()
  expect_true(file.exists(fasta_gz_filename))
  t <- get_proteome(
    fasta_gz_filename = fasta_gz_filename
  )
  expect_true(tibble::is_tibble(t))
  expect_true(nrow(t) > 20000)
  expect_equal(ncol(t), 2)
  expected_names <- c(
    "name",
    "sequence"
  )
  expect_equal(names(t), expected_names)
})
