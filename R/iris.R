#' The Iris data, saved as one file per column
#'
#' This is the same data as \code{\link[datasets]{iris}}, saved in
#' \code{inst/extdata} using one file per column.
#'
#' @docType data
#' @include splice.R
#' @export
#' @examples
#' head(iris_unbound[1:3])
iris_unbound <- splice(system.file("extdata/iris", package = packageName()))
