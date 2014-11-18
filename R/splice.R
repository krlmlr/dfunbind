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
  # Work around hadley/devtools#640
  if (!file.exists(path) && basename(getwd()) == "R" && file.exists(file.path("..", path)))
    path <- file.path("..", path)

  path <- normalizePath(path)
  pattern <- "^([0-9]+)-(.*)[.]rds$"
  files <- dir(path = path, pattern = pattern)

  indexes <- gsub(pattern, "\\1", files)
  col_names <- gsub(pattern, "\\2", files)

  if (length(indexes) == 0)
    stop("Source directory ", path, " does not appear to contain .rds files.")

  if (as.integer(indexes[[1L]]) != 0L)
    stop("No row names found")

  row_names <- readRDS(file.path(path, files[[1L]]))
  if (is.list(row_names))
    row_names <- seq_len(row_names[[1L]])
  col_names <- col_names[-1L]
  files <- files[-1L]

  structure(
    rep(NA, length(col_names)),
    .Names = col_names,
    row.names = row_names,
    .Path = path,
    .Files = files,
    .Values = new.env(parent = emptyenv()),
    class = c("dfsplice"))
}

get_path <- function(x) attr(x, ".Path")
get_files <- function(x) attr(x, ".Files")
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

  as.data.frame(mget(out_names, get_values(x)))
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

cache_columns <- function(x, out_names) {
  envir <- get_values(x)
  names <- names(x)
  path <- get_path(x)
  files <- get_files(x)

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
      "A dfsplice object with %d rows and %d columns:%s",
      nrow(object),
      ncol(object),
      paste(c("", names(object)), collapse = "\n  ")
    )
  )
  invisible(NULL)
}
