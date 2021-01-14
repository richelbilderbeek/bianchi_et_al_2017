test_that("use", {
  tmhmm_filename <- download_tmhmm_topology()
  expect_true(file.exists(tmhmm_filename))
  t <- get_tmhmm_topology(
    tmhmm_filename = tmhmm_filename
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

test_that("proteome and topology has same names", {
  proteome <- get_proteome(
    fasta_gz_filename = download_proteome()
  )
  topology <- get_tmhmm_topology(
    tmhmm_filename = download_tmhmm_topology()
  )
  expect_equal(nrow(proteome), nrow(topology))
  expect_true(tibble::is_tibble(t))
  expect_true(nrow(t) > 20000)
  expect_equal(ncol(t), 2)
  expected_names <- c(
    "name",
    "sequence"
  )
  expect_equal(names(t), expected_names)
})
