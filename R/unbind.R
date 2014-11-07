#' Save each column of a data frame to a separate file
#'
#' This function save the data for each column of a data frame to a separate
#' RData file.  If the target directory does not exist, it is created, including
#' intermediate directories.  Compression is optional.
#'
#' @param x A data frame
#' @param name A variable name under which this data frame should be accessible
#'   later
#' @param .destdir_pattern Where to save the files.  The default allows
#'   including the files in a package.
#' @param .compress Passed as \code{compress} to \code{\link[base]{save}}
#' @param .parallel If true, parallelize with \code{\link[parallel]{mclapply}}
#' @export
unbind_one <- function(x, name, .destdir_pattern = "inst/extdata/%s", .compress = TRUE, .parallel = FALSE) {
  if (!is.data.frame(x))
    stop("x must be a data frame")

  destdir = sprintf(.destdir_pattern, name)
  if (!file.exists(destdir))
    dir.create(destdir, recursive = TRUE)

  cores <- if (.parallel) parallel::detectCores() else 1L
  parallel::mclapply(names(x), function(name)
    saveRDS(x[[name]], file = file.path(destdir, sprintf("%s.rds", name)), compress = .compress),
    mc.cores = cores
  )

  invisible(NULL)
}
