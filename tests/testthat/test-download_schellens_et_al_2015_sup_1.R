test_that("use", {
  xlsx_filename <- tempfile()
  expect_false(file.exists(xlsx_filename))
  download_schellens_et_al_2015_sup_1(
    xlsx_filename = xlsx_filename
  )
  expect_true(file.exists(xlsx_filename))
})

test_that("use", {
  xlsx_filename <- download_schellens_et_al_2015_sup_1()
  expect_true(file.exists(xlsx_filename))
  readLines(xlsx_filename)
})
