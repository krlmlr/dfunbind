context('Unbind')

test_that('Unbind creates files and directories', {
  my_subdir <- "subdir/for/data"
  on.exit(unlink(my_subdir, recursive = TRUE))
  unbind_one(iris, "iris", my_subdir)

  expect_true(file.exists(my_subdir))
  expect_true(file.info(my_subdir)$isdir)
  files <- dir(my_subdir)
  expect_equal(length(files), ncol(iris))
  expect_equal(files, sprintf("%d-%s.rds", 1:5, colnames(iris)))

  iris_splice <- splice(my_subdir)
  expect_equal(iris_splice[3], iris[3])
  expect_equal(iris_splice[c(2,1,5,3)], iris[c(2,1,5,3)])
  expect_equal(iris_splice[names(iris)[c(2,1,5,3)]], iris[c(2,1,5,3)])
})
