context('Unbind iris')

my_subdir <- "subdir/for/data"
on.exit(unlink(my_subdir, recursive = TRUE))
unbind(iris, my_subdir)

test_that('File name format for unbind', {
  files <- dir(my_subdir)
  expect_equal(files, c(sprintf("%d-%s.rds", 1:5, c(colnames(iris))), DICT_FILENAME))
})

test_that('splice and row names', {
  expect_false(exists(file.path(my_subdir, "0-rownames.rds")))
})

test_that('splice and $', {
  iris_splice <- splice(my_subdir)
  expect_equal(iris_splice$Species, iris$Species)
  expect_equal(iris_splice$Spec, iris$Species)
  expect_equal(iris_splice$Petal.L, iris$Petal.L)
  expect_error(iris_splice$Nonexisting)
})
