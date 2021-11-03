test_that("use", {
  skip("TODO: remove? Use 'bbbq::get_proteome' instead")
  fasta_gz_filename <- tempfile()
  expect_false(file.exists(fasta_gz_filename))
  download_proteome(
    fasta_gz_filename = fasta_gz_filename
  )
  expect_true(file.exists(fasta_gz_filename))
})

test_that("use", {
  skip("TODO: remove? Use 'bbbq::get_proteome' instead")
  fasta_gz_filename <- download_proteome()
  expect_true(file.exists(fasta_gz_filename))
})

test_that("read data", {
  skip("TODO: remove? Use 'bbbq::get_proteome' instead")
  fasta_gz_filename <- download_proteome()
  expect_true(file.exists(fasta_gz_filename))
})
