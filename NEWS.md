v0.0-2.2 (2014-11-17)
===

* Store and row names in a separate file, retrieve them unconditionally
* Implement `row.names.dfsplice` (as forward to `row.names.data.frame`)

v0.0-2.1 (2014-11-17)
===

* `splice` throws error if directory is empty

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
