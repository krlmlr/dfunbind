v0.0-1.1 (2014-11-07)
===

* Include an unbound version of the Iris data as example.
* Implement `str.dfsplice` (#5).
* During package loading, relative paths passed to splice are interpreted as relative to the package's installation directory.

v0.0-1 (2014-11-07)
===

* Initial implementation
* Function `unbind` saves the data for each column of a data frame to a
  separate RDS file.
* Function `splice` loads this data and offers a lightweight `data.frame`-like
  interface with operators `[`, `[[` and `$`
* `testthat` infrastructure.
