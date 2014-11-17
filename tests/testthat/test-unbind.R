context('Unbind')

my_subdir <- "subdir/for/data"
on.exit(unlink(my_subdir, recursive = TRUE))
unbind(iris, my_subdir)

test_that('Unbind creates files and directories', {
  expect_true(file.exists(my_subdir))
  expect_true(file.info(my_subdir)$isdir)
  files <- dir(my_subdir)
  expect_equal(length(files), ncol(iris) + 1)
  expect_equal(files, sprintf("%d-%s.rds", 0:5, c("rownames", colnames(iris))))
})

test_that('splice and row names', {
  expect_equal(readRDS(file.path(my_subdir, "0-rownames.rds")), list(nrow(iris)))
  iris_splice <- splice(my_subdir)
  expect_equal(row.names(iris_splice), row.names(iris))
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
