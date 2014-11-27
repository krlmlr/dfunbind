iris_commented <- iris
mapply(
  function(x, y) comment(iris_commented[[x]]) <<- y,
  names(iris_commented),
  c(
    "Length of the sepals",
    "Width of the sepals",
    "Length of the sepals",
    "Width of the sepals",
    "Species of Iris"
  )
)
unbind(iris_commented, "inst/extdata/iris")
