context('Unbind')

my_subdir <- "subdir/for/data"
on.exit(unlink(my_subdir, recursive = TRUE))
unbind(iris, my_subdir)

test_that('Unbind creates files and directories', {
  expect_true(file.exists(my_subdir))
  expect_true(file.info(my_subdir)$isdir)
  files <- dir(my_subdir)
  expect_equal(length(files), ncol(iris) + 1)
})

test_that('File name format for unbind', {
  files <- dir(my_subdir)
  expect_equal(files, c(sprintf("%d-%s.rds", 1:5, c(colnames(iris))), DICT_FILENAME))
})

test_that('splice and row names', {
  expect_false(exists(file.path(my_subdir, "0-rownames.rds")))
})

test_that('splice and column names', {
  iris_splice <- splice(my_subdir)
  expect_equal(names(iris_splice), names(iris))
  expect_equal(colnames(iris_splice), colnames(iris))
  expect_equal(dimnames(iris_splice), dimnames(iris))
})

test_that('splice and dim', {
  iris_splice <- splice(my_subdir)
  expect_equal(nrow(iris_splice), nrow(iris))
  expect_equal(ncol(iris_splice), ncol(iris))
  expect_equal(dim(iris_splice), dim(iris))
})

test_that('splice and [', {
  iris_splice <- splice(my_subdir)
  expect_equal(iris_splice[3], iris[3])
  expect_equal(iris_splice[c(2,1,5,3)], iris[c(2,1,5,3)])
  expect_equal(iris_splice[names(iris)[c(2,1,5,3)]], iris[c(2,1,5,3)])
  expect_equal(iris_splice[names(iris)[c(4,5)]], iris[c(4,5)])
})

test_that('splice and [[', {
  iris_splice <- splice(my_subdir)
  expect_equal(iris_splice[[3]], iris[[3]])
  expect_equal(iris_splice[[names(iris)[4]]], iris[[4]])
  expect_error(iris_splice[[c(2,1,5,3)]])
  expect_error(iris_splice[[names(iris)[c(2,1,5,3)]]])
})

test_that('splice and $', {
  iris_splice <- splice(my_subdir)
  expect_equal(iris_splice$Species, iris$Species)
  expect_equal(iris_splice$Spec, iris$Species)
  expect_equal(iris_splice$Petal.L, iris$Petal.L)
  expect_error(iris_splice$Nonexisting)
})

test_that('splice and as.data.frame', {
  iris_splice <- splice(my_subdir)
  expect_equal(as.data.frame(iris_splice), iris)
})
