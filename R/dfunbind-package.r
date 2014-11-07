#' dfunbind: Column-wise loading of large data frames for package authors
#'
#' When packaging data frames to a package, the entire data frame
#' is loaded when first accessed.  This is impractical if the data frame
#' contains many columns and only few of them are needed.  This package offers
#' a workaround by providing functions to store and load data frames in
#' one RDS file per column.
#'
#' @name dfunbind
#' @docType package
#' @examples
#' unbind_one(iris, "iris", ".")
#' iris_unbound <- splice("./iris")
#' head(iris_unbound[1:3])
NULL
