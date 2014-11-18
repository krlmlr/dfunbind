context('Iris')

test_that('Packaged dataset works', {
  expect_equal(iris_unbound[1:5], iris)
})
