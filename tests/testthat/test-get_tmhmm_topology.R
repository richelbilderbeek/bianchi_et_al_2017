test_that("use", {
  skip("TODO: remove? Use 'bbbq::get_topology' instead")
  tmhmm_filename <- download_tmhmm_topology()
  expect_true(file.exists(tmhmm_filename))
  t <- get_tmhmm_topology(
    tmhmm_filename = tmhmm_filename
  )
  expect_true(tibble::is_tibble(t))
  expect_equal(nrow(t), 2440)
  expect_equal(ncol(t), 2)
  expected_names <- c(
    "name",
    "sequence"
  )
  expect_equal(names(t), expected_names)
})

test_that("proteome and topology has same names", {
  skip("TODO: remove? Use 'bbbq::get_topology' instead")
  skip("proteome and topology has same names")
  proteome <- bianchietal2017::get_proteome(
    fasta_gz_filename = bianchietal2017::download_proteome()
  )
  topology <- bianchietal2017::get_tmhmm_topology(
    tmhmm_filename = bianchietal2017::download_tmhmm_topology()
  )
  head(topology$name[1])
  head(proteome$name[1])
  sum(topology$name %in% proteome$name)
  sum(proteome$name %in% topology$name)
  if (1 == 2) {
    # Regenerate the topology file to have as much rows as the proteome
    fasta_gz_filename <- bianchietal2017::download_proteome()
    fasta_filename <- normalizePath("~/UP000005640_9606.fasta", mustWork = FALSE)
    R.utils::gunzip(
      filename = fasta_gz_filename,
      destname = fasta_filename,
      remove = FALSE
    )
    testthat::expect_true(file.exists(fasta_filename))
    expect_equal(
      nrow(pureseqtmr::load_fasta_file_as_tibble_cpp(fasta_filename)),
      20600
    )
    # Fails due to selenoproteins
    topology <- tmhmm::predict_topology(fasta_filename = fasta_filename)
    tmhmm_filename <- normalizePath("~/UP000005640_9606.tmhmm", mustWork = FALSE)
    readr::write_csv(x = topology, file = tmhmm_filename)
  }
  expect_equal(nrow(proteome), nrow(topology))
  expect_true(tibble::is_tibble(t))
  expect_equal(nrow(t), 2440)
  expect_equal(ncol(t), 2)
  expected_names <- c(
    "name",
    "sequence"
  )
  expect_equal(names(t), expected_names)
})
