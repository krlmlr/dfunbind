#' Save each column of a data frame to a separate file
#'
#' This function save the data for each column of a data frame to a separate
#' RDS file.  If the target directory does not exist, it is created, including
#' intermediate directories.  Compression is optional.
#'
#' Use this function in a helper script for your package to add the files needed
#' for column-wise loading this data set, e.g., in the \code{data-raw} directory.
#' According to the "Writing R Extensions" manual,
#' "the convention has grown up to use directory \code{inst/extdata} for [other
#' data files needed by the package]"; use a subdirectory for each data frame.
#'
#' @param x A data frame
#' @param .destdir Where to save the files.  For proper operation, it
#'   cannot contain other files with \code{.rds} extension.
#' @param .compress Passed as \code{compress} to \code{\link[base]{save}}
#' @param .parallel If true, parallelize with \code{\link[parallel]{mclapply}}
#' @references \href{http://r-pkgs.had.co.nz/data.html}{R packages: External data}
#' @references \href{http://cran.r-project.org/doc/manuals/R-exts.html}{Writing R extensions}
#' @export
unbind <- function(x, .destdir, .compress = TRUE, .parallel = FALSE) {
  if (!is.data.frame(x))
    stop("x must be a data frame")

  if (!file.exists(.destdir))
    dir.create(.destdir, recursive = TRUE)

  fmt <- sprintf("%%.0%dd-%%s.rds", ceiling(log10(ncol(x) + 1)))

  cores <- if (.parallel) parallel::detectCores() else 1L
  parallel::mclapply(
    seq_along(x),
    function(i) {
      name <- names(x)[[i]]
      saveRDS(x[[i]], file = file.path(.destdir, sprintf(fmt, i, name)), compress = .compress)
    },
    mc.cores = cores
  )

  invisible(NULL)
}
