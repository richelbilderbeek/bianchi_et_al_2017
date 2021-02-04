test_that("use", {
  expect_equal(
    get_proteome_url(),
    "ftp://ftp.ebi.ac.uk/pub/databases/reference_proteomes/QfO/Eukaryota/UP000005640_9606.fasta.gz" # nolint long line indeed
  )
})
