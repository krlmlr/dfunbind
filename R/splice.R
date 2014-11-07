#' @export
splice <- function(path) {
  path <- normalizePath(path)
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

  as.data.frame(mget(out_names, x[["envir"]]))
}

cache_columns <- function(x, out_names) {
  envir <- x[["envir"]]
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
