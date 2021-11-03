test_that("use", {
  skip("TODO: remove? Use 'bbbq::get_topology' instead")
  tmhmm_filename <- tempfile()
  expect_false(file.exists(tmhmm_filename))
  download_tmhmm_topology(
    tmhmm_filename = tmhmm_filename
  )
  expect_true(file.exists(tmhmm_filename))
})

test_that("use", {
  skip("TODO: remove? Use 'bbbq::get_topology' instead")
  tmhmm_filename <- download_tmhmm_topology()
  expect_true(file.exists(tmhmm_filename))
})

test_that("read data", {
  skip("TODO: remove? Use 'bbbq::get_topology' instead")
  tmhmm_filename <- download_tmhmm_topology()
  expect_true(file.exists(tmhmm_filename))
})
