* change of internal data format allows storing much richer metadata such as
  data type, summary and attributes (including comments) for each column
  and the entire data frame

v0.0-5 (2014-11-24)
===

* `isplice` also works for other packages
* Better error checking in `splice` and `isplice`

v0.0-4 (2014-11-24)
===

* New function `isplice` to allow a shorter specification of the data directory

v0.0-3 (2014-11-18)
===

* Complete `data.frame`-like implementation for `dfsplice` class with new
  methods `names`, `dimnames`, `row.names`, `dim` and `print`
* Better implementation of `str.dfsplice` now prints rows, columns and column
  names
* `splice` throws error if directory is empty
* Store row names in a separate file, retrieve them unconditionally
* Work around `devtools` issue hadley/devtools#640 (working directory for
  testing and documenting)

v0.0-2 (2014-11-09)
===

* Include an unbound version of the Iris data as example.
* Add test that is currently skipped when running from `devtools`.
* Implement `str.dfsplice` (#5).

v0.0-1 (2014-11-07)
===

* Initial implementation
* Function `unbind` saves the data for each column of a data frame to a
  separate RDS file.
* Function `splice` loads this data and offers a lightweight `data.frame`-like
  interface with operators `[`, `[[` and `$`
* `testthat` infrastructure.
