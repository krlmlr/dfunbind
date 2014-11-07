context('Iris')

test_that('Packaged dataset works', {
  if ("devtools" %in% unlist(sessionInfo()[c("otherPkgs", "loadedOnly")]))
    skip("https://github.com/hadley/devtools/issues/640")
  expect_equal(iris_unbound[1:5], iris)
})
