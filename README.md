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
Then, in a source file, add a statement `dataset <- splice("inst/extdata/dataset")`
to a source file in the `R/` subdirectory of your package.

## Example

The Iris dataset is packaged here as an example.
Packaging happens by manually running [`data-raw/iris.R`](data-raw/iris.R),
it is made available to users of the package by [`R/iris.R`](R/iris.R).
The data files are stored in [`inst/extdata/iris`](inst/extdata/iris).
