#' Loads column-wise data
#'
#' This function loads the data for each column of a data frame from a separate
#' RDS file, as created by \code{\link{unbind}}.
#'
#' @param path Source directory as passed to \code{\link{unbind}}
#' @return An object of class \code{dfsplice}; extract columns by using \code{[},
#'   \code{[[} or \code{$}
#' @export
splice <- function(path) {
  path <- normalizePath(path)
  pattern <- "[0-9]+-(.*)[.]rds$"
  files <- dir(path = path, pattern = pattern)

  col_names <- gsub(pattern, "\\1", files)

  if (length(indexes) == 0)
    stop("Source directory ", path, " does not appear to contain .rds files.")

  structure(
    list(envir = new.env(parent = emptyenv())),
    .ColNames = col_names,
    .Path = path,
    .Files = files,
    class = c("dfsplice"))
}

#' @export
`[.dfsplice` <- function(x, i) {
  names <- setNames(nm = attr(x, ".ColNames"))
  out_names <- names[i]

  cache_columns(x, out_names)

  as.data.frame(mget(out_names, unclass(x)[["envir"]]))
}

#' @export
`[[.dfsplice` <- function(x, i) {
  names <- setNames(nm = attr(x, ".ColNames"))
  out_names <- names[[i]]

  cache_columns(x, out_names)

  get(out_names, unclass(x)[["envir"]])
}

#' @export
`$.dfsplice` <- function(x, name) {
  names <- as.data.frame(as.list(setNames(nm = attr(x, ".ColNames"))), stringsAsFactors = FALSE)
  out_names <- `$.data.frame`(names, name)

  cache_columns(x, out_names)

  get(out_names, unclass(x)[["envir"]])
}

cache_columns <- function(x, out_names) {
  envir <- unclass(x)[["envir"]]
  names <- attr(x, ".ColNames")
  path <- attr(x, ".Path")
  files <- attr(x, ".Files")

  loaded_names <- ls(envir)
  names_to_load <- setdiff(out_names, loaded_names)
  indexes_to_load <- match(names_to_load, names)
  stopifnot(names[indexes_to_load] == names_to_load)

  for (i in indexes_to_load) {
    name <- names[[i]]
    assign(name, readRDS(file.path(path, files[[i]])), envir)
  }
}

#' @export
str.dfsplice <- function(object, ...) {
  cat(
    sprintf(
      "A dfsplice object"
    )
  )
  invisible(NULL)
}
