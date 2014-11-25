test_unbind <- function(my_data) {
  context(sprintf('Unbind generic %s', deparse(substitute(my_data))))

  my_subdir <- "datadir"
  on.exit(unlink(my_subdir, recursive = TRUE))
  unbind(my_data, my_subdir)

  test_that('Unbind creates files and directories', {
    expect_true(file.exists(my_subdir))
    expect_true(file.info(my_subdir)$isdir)
  })

  test_that('splice and column names', {
    my_data_splice <- splice(my_subdir)
    expect_equal(names(my_data_splice), names(my_data))
    expect_equal(colnames(my_data_splice), colnames(my_data))
    expect_equal(dimnames(my_data_splice), dimnames(my_data))
  })

  test_that('splice and dim', {
    my_data_splice <- splice(my_subdir)
    expect_equal(nrow(my_data_splice), nrow(my_data))
    expect_equal(ncol(my_data_splice), ncol(my_data))
    expect_equal(dim(my_data_splice), dim(my_data))
  })

  test_that('splice and [', {
    my_data_splice <- splice(my_subdir)
    expect_equal(my_data_splice[3], my_data[3])
    expect_equal(my_data_splice[c(2,1,5,3)], my_data[c(2,1,5,3)])
    expect_equal(my_data_splice[names(my_data)[c(2,1,5,3)]], my_data[c(2,1,5,3)])
    expect_equal(my_data_splice[names(my_data)[c(4,5)]], my_data[c(4,5)])
  })

  test_that('splice and [[', {
    my_data_splice <- splice(my_subdir)
    expect_equal(my_data_splice[[3]], my_data[[3]])
    expect_equal(my_data_splice[[names(my_data)[4]]], my_data[[4]])
    expect_error(my_data_splice[[c(2,1,5,3)]])
    expect_error(my_data_splice[[names(my_data)[c(2,1,5,3)]]])
  })

  test_that('splice and as.data.frame', {
    my_data_splice <- splice(my_subdir)
    expect_equal(as.data.frame(my_data_splice), my_data)
  })
}

test_unbind(iris)
test_unbind(mtcars)
