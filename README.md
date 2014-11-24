# dfunbind [![Build Status](https://snap-ci.com/krlmlr/dfunbind/branch/master/build_image)](https://snap-ci.com/krlmlr/dfunbind/branch/master)

When packaging data frames to a package, the entire data frame
is loaded when first accessed.  This is impractical if the data frame
contains many columns and only few of them are needed.  This package offers
a workaround by providing functions to store and load data frames in
one RDS file per column.

## Installation

```r
devtools::install_github("krlmlr/dfunbind")
```

## Usage

To package a data set, use `unbind(dataset, "inst/extdata/dataset")`.
Then,  in the `R/` subdirectory of your package, create a source file
with the following contents:

```
#' @importFrom dfunbind isplice
#' @export
dataset <- isplice("dataset")
```

Use `roxygen2` or `devtools` to create documentation and the `NAMESPACE` file.
The `dfunbind` package needs to be imported explicitly to access S3 methods and
operators defined there.


## Example

The Iris dataset is packaged here as an example.
Packaging happens by manually running [`data-raw/iris.R`](data-raw/iris.R),
it is made available to users of the package by [`R/iris.R`](R/iris.R).
The data files are stored in [`inst/extdata/iris`](inst/extdata/iris).
