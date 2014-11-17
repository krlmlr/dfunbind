context('Splice')

test_that('Error with empty directory', {
  expect_error(splice("empty"), "[.]rds files")
})
