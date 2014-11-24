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

  info <- get_info(x)

  xs <- seq_along(info)
  if (!is.null(attr(info, ".RowNamesFileName")))
    xs <- c(0L, xs)

  cores <- if (.parallel) parallel::detectCores() else 1L

  parallel::mclapply(
    xs,
    function(i) {
      if (i == 0L) {
        fname <- attr(info, ".RowNamesFileName")
        obj <- attr(x, "row.names")
      } else {
        fname <- info[[i]]$.FileName
        obj <- x[[i]]
      }
      saveRDS(obj, file = file.path(.destdir, fname), compress = .compress)
    },
    mc.cores = cores
  )

  info_dfsplice <- structure(
    info,
    class = "dfsplice"
  )

  saveRDS(info_dfsplice, file = file.path(.destdir, DICT_FILENAME), compress = .compress)
}

get_info <- function(x) {
  fmt <- sprintf("%%.0%dd-%%s.rds", ceiling(log10(ncol(x) + 1)))

  info <- lapply(
    setNames(seq_along(x), names(x)),
    function(col) {
      name <- names(x)[[col]]
      ret <- list(
        attributes = attributes(x[[col]]),
        class = class(x[[col]]),
        levels = levels(x[[col]]),
        summary = summary(x[[col]]),
        .FileName = sprintf(fmt, col, name)
      )
      ret[!vapply(ret, is.null, logical(1L))]
    }
  )

  row_names <- attr(x, "row.names")
  row_names_file_name <- if (all(row_names == seq_len(nrow(x))))
    NULL
  else
    sprintf(fmt, 0L, "rownames")

  attrib_names <- setdiff(names(attributes(x)), "row.names")

  structure(
    info,
    attributes = attributes(x)[attrib_names],
    .NRows = nrow(x),
    .RowNamesFileName = row_names_file_name
  )
}
