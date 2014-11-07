* Initial implementation

* Function `unbind` saves the data for each column of a data frame to a
  separate RDS file.
* Function `splice` loads this data and offers a lightweight `data.frame`-like
  interface with operators `[`, `[[` and `$`
* `testthat` infrastructure.
