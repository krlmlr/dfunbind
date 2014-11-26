#' Loads column-wise data
#'
#' These functions load the data for each column of a data frame from a separate
#' RDS file, as created by \code{\link{unbind}}.
#'
#' Normally, you want to use \code{isplice} with the name of the directory
#' (under \code{extdata}) where the data is located. The \code{splice} function
#' allows specifying a path in the file system; it is called internally from
#' \code{isplice}.
#'
#' @param path Source directory as passed to \code{\link{unbind}}
#' @return An object of class \code{dfsplice}; extract columns by using \code{[},
#'   \code{[[} or \code{$}
#' @export
splice <- function(path) {
  path <- normalizePath(path, mustWork = TRUE)

  info_fname <- file.path(path, DICT_FILENAME)
  if (!file.exists(info_fname))
    stop("Source directory ", path, " does not appear to contain a file ", DICT_FILENAME, " .")

  info <- readRDS(info_fname)

  row_names_fname <- attr(info, ".RowNamesFileName")
  row_names <- if (is.null(row_names_fname))
    c(NA, -attr(info, ".NRows"))
  else
    readRDS(file.path(path, row_names_fname))

  structure(
    info,
    row.names = row_names,
    .Path = path,
    .Values = new.env(parent = emptyenv()),
    class = c("dfsplice"))
}

#' @rdname splice
#' @param dataset The name of the directory under \code{inst/extdata} where the
#'   data is stored.
#' @param package The name of the package where the data is stored.  The default
#'   loads data from the current package.
#' @export
isplice <- function(dataset, package = packageName(env = parent.frame())) {
  path <- system.file(file.path("extdata", dataset), package = package)
  if (path == "")
    path <- system.file(file.path("inst", "extdata", dataset), package = package)
  if (path == "")
    stop("No subdirectory ", dataset, " found in package ", package, ".")
  splice(path)
}

get_path <- function(x) attr(x, ".Path")
get_file <- function(x, i) unclass(x)[[i]]$.FileName
get_values <- function(x) attr(x, ".Values")

#' @export
row.names.dfsplice <- function(x) row.names.data.frame(x)

#' @export
dimnames.dfsplice <- function(x) dimnames.data.frame(x)

#' @export
dim.dfsplice <- function(x) dim.data.frame(x)

#' @export
`[.dfsplice` <- function(x, i) {
  in_names <- setNames(nm = names(x))
  out_names <- in_names[i]

  cache_columns(x, out_names)

  as.data.frame(mget(out_names, get_values(x)), row.names = attr(x, "row.names"), stringsAsFactors = FALSE)
}

#' @export
`[[.dfsplice` <- function(x, i) {
  in_names <- setNames(nm = names(x))
  out_names <- in_names[[i]]

  cache_columns(x, out_names)

  get(out_names, get_values(x))
}

#' @export
`$.dfsplice` <- function(x, name) {
  in_names <- as.data.frame(as.list(setNames(nm = names(x))), stringsAsFactors = FALSE)
  out_names <- `$.data.frame`(in_names, name)

  cache_columns(x, out_names)

  get(out_names, get_values(x))
}

#' @export
as.data.frame.dfsplice <- function(x)
  x[seq_along(x)]

cache_columns <- function(x, out_names) {
  envir <- get_values(x)
  names <- names(x)
  path <- get_path(x)

  loaded_names <- ls(envir)
  names_to_load <- setdiff(out_names, loaded_names)
  indexes_to_load <- match(names_to_load, names)
  stopifnot(names[indexes_to_load] == names_to_load)

  for (i in indexes_to_load) {
    name <- names[[i]]
    assign(name, readRDS(file.path(path, get_file(x, i))), envir)
  }
}

#' @export
str.dfsplice <- function(object, ...) {
  object_info <- mapply(
    function(name, info) {
      ret <- c(
        name,
        sprintf(
          "- %s",
          c(
            info$class,
            paste(sprintf("%s=%s", names(info$summary), info$summary), collapse = ", "))
        )
      )
      if (!is.null(info$attributes$comment))
        ret <- c(sprintf("# %s", info$attributes$comment), ret)
      ret
    },
    names(object),
    unclass(object)
  )
  cat(
    sprintf(
      "A dfsplice object with %d rows and %d columns:%s",
      nrow(object),
      ncol(object),
      paste(c("", object_info), collapse = "\n  ")
    )
  )
  invisible(NULL)
}

#' @export
print.dfsplice <- function(x, ...) cat(str.dfsplice(x, ...), "\n")

DICT_FILENAME <- "dfunbind.rds"
