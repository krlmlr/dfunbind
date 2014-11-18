\name{NEWS}
\title{News for Package 'dfunbind'}
\encoding{UTF-8}
\section{Changes in dfunbind version 0.0-2.3 (2014-11-18)}{
  \itemize{
    \item Implement \code{names.dfsplice} and \code{dimnames.dfsplice}
    \item \code{colnames} now also works for \code{dfsplice} objects
    \item Work around \code{devtools} issue hadley/devtools#640 (working directory for
      testing and documenting)
  }
}
\section{Changes in dfunbind version 0.0-2.2 (2014-11-17)}{
  \itemize{
    \item Store and row names in a separate file, retrieve them unconditionally
    \item Implement \code{row.names.dfsplice} (as forward to \code{row.names.data.frame})
  }
}
\section{Changes in dfunbind version 0.0-2.1 (2014-11-17)}{
  \itemize{
    \item \code{splice} throws error if directory is empty
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
