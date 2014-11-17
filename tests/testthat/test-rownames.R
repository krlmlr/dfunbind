context('Row names')

my_subdir <- "subdir/for/mtcars"
on.exit(unlink(my_subdir, recursive = TRUE))
unbind(mtcars, my_subdir)

test_that('splice and row names for mtcars', {
  expect_equal(readRDS(file.path(my_subdir, "00-rownames.rds")), row.names(mtcars))
  mtcars_splice <- splice(my_subdir)
  expect_equal(row.names(mtcars_splice), row.names(mtcars))
})
