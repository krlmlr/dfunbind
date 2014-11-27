context('Iris')

test_that('Packaged dataset works', {
  iris_data <- iris_unbound[1:5]
  lapply(names(iris_data), function(name) comment(iris_data[[name]]) <<- NULL)

  expect_equal(iris_data, iris)
})
