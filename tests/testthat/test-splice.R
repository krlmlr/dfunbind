context('Splice')

test_that('Error with empty directory', {
  expect_error(splice("empty"), glob2rx(sprintf("*%s*", DICT_FILENAME)))
})
