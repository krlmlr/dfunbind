#' Loads column-wise data
#'
#' This function loads the data for each column of a data frame from a separate
#' RDS file, as created by \code{\link{unbind}}.
#'
#' If this function is called from a namespace (e.g., when loading a package)
#' and \code{path} is a relative directory, it is assumed to be relative to the
#' installation path of the package (via \code{\link[base]{system.file}}).
#'
#' @param path Source directory as passed to \code{\link{unbind}}
#' @return An object of class \code{dfunbind}; extract columns by using \code{[},
#'   \code{[[} or \code{$}
#' @export
splice <- function(path) {
  norm_path <- normalizePath(path, mustWork = FALSE)
  if (path != norm_path) {
    if (isNamespace(package_envir <- parent.frame()))
      path <- system.file(path, package = getNamespaceName(package_envir))
    else
      path <- norm_path
  }

  pattern <- "[0-9]+-(.*)[.]rds$"
  files <- dir(path = path, pattern = pattern)

  col_names <- gsub(pattern, "\\1", files)

  structure(
    list(envir = new.env(parent = emptyenv())),
    .ColNames = col_names,
    .Path = path,
    .Files = files,
    class = c("dfsplice"))
}

`[.dfsplice` <- function(x, i) {
  names <- setNames(nm = attr(x, ".ColNames"))
  out_names <- names[i]

  cache_columns(x, out_names)

  as.data.frame(mget(out_names, unclass(x)[["envir"]]))
}

`[[.dfsplice` <- function(x, i) {
  names <- setNames(nm = attr(x, ".ColNames"))
  out_names <- names[[i]]

  cache_columns(x, out_names)

  get(out_names, unclass(x)[["envir"]])
}

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

str.dfsplice <- function(x) {
  cat(
    sprintf(
      "A dfsplice object"
    )
  )
  invisible(NULL)
}
