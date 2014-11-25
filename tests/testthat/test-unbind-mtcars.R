context('Unbind mtcars')

my_subdir <- "mtcars/subdir"
on.exit(unlink(my_subdir, recursive = TRUE))
unbind(mtcars, my_subdir)

test_that('File name format for unbind', {
  files <- dir(my_subdir)
  expect_equal(length(files), ncol(mtcars) + 2)
  expect_equal(files, c(sprintf("%.2d-%s.rds", seq_len(ncol(mtcars) + 1) - 1, c("rownames", colnames(mtcars))), DICT_FILENAME))
})

test_that('splice and row names', {
  expect_false(exists(file.path(my_subdir, "0-rownames.rds")))
})

test_that('splice and $', {
  mtcars_splice <- splice(my_subdir)
  expect_equal(mtcars_splice$mpg, mtcars$mpg)
  expect_equal(mtcars_splice$mp, mtcars$mpg)
  expect_equal(mtcars_splice$di, mtcars$di)
  expect_error(mtcars_splice$bla)
})
