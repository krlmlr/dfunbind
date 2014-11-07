* `unbind_one` is now called `unbind` and doesn't have a `name` parameter
  anymore

v0.0-0.5 (2014-11-07)
===

* Operators `[[` and `$` for `dfunbind` class

v0.0-0.4 (2014-11-07)
===

* initial implementation of splice function, creates an object that has a `[`
  operator defined that allows accessing the data
* Use numeric prefix to file names to preserve order (#3).

v0.0-0.3 (2014-11-07)
===

* Write `.rds` files instead of `.rda` files (#4).
* `testthat` infrastructure.

v0.0-0.2 (2014-11-06)
===

* New argument `.parallel` to support parallel execution (#2).

v0.0-0.1 (2014-11-06)
===

* Function `unbind_one` saves the data for each column of a data frame to a
  separate RData file.
