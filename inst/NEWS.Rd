\name{NEWS}
\title{News for Package 'dfunbind'}
\encoding{UTF-8}
\section{Changes in dfunbind version 0.0-5 (2014-11-24)}{
  \itemize{
    \item \code{isplice} also works for other packages
    \item Better error checking in \code{splice} and \code{isplice}
  }
}
\section{Changes in dfunbind version 0.0-4 (2014-11-24)}{
  \itemize{
    \item New function \code{isplice} to allow a shorter specification of the data directory
  }
}
\section{Changes in dfunbind version 0.0-3 (2014-11-18)}{
  \itemize{
    \item Complete \code{data.frame}-like implementation for \code{dfsplice} class with new
      methods \code{names}, \code{dimnames}, \code{row.names}, \code{dim} and \code{print}
    \item Better implementation of \code{str.dfsplice} now prints rows, columns and column
      names
    \item \code{splice} throws error if directory is empty
    \item Store row names in a separate file, retrieve them unconditionally
    \item Work around \code{devtools} issue hadley/devtools#640 (working directory for
      testing and documenting)
  }
}
\section{Changes in dfunbind version 0.0-2 (2014-11-09)}{
  \itemize{
    \item Include an unbound version of the Iris data as example.
    \item Add test that is currently skipped when running from \code{devtools}.
    \item Implement \code{str.dfsplice} (#5).
  }
}
\section{Changes in dfunbind version 0.0-1 (2014-11-07)}{
  \itemize{
    \item Initial implementation
    \item Function \code{unbind} saves the data for each column of a data frame to a
      separate RDS file.
    \item Function \code{splice} loads this data and offers a lightweight \code{data.frame}-like
      interface with operators \code{[}, \code{[[} and \code{$}
    \item \code{testthat} infrastructure.
  }
}
