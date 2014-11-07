\name{NEWS}
\title{News for Package 'dfunbind'}
\encoding{UTF-8}
\section{Changes in dfunbind version 0.0-0.6 (2014-11-07)}{
  \itemize{
    \item \code{unbind_one} is now called \code{unbind} and doesn't have a \code{name} parameter
      anymore
  }
}
\section{Changes in dfunbind version 0.0-0.5 (2014-11-07)}{
  \itemize{
    \item Operators \code{[[} and \code{$} for \code{dfunbind} class
  }
}
\section{Changes in dfunbind version 0.0-0.4 (2014-11-07)}{
  \itemize{
    \item initial implementation of splice function, creates an object that has a \code{[}
      operator defined that allows accessing the data
    \item Use numeric prefix to file names to preserve order (#3).
  }
}
\section{Changes in dfunbind version 0.0-0.3 (2014-11-07)}{
  \itemize{
    \item Write \code{.rds} files instead of \code{.rda} files (#4).
    \item \code{testthat} infrastructure.
  }
}
\section{Changes in dfunbind version 0.0-0.2 (2014-11-06)}{
  \itemize{
    \item New argument \code{.parallel} to support parallel execution (#2).
  }
}
\section{Changes in dfunbind version 0.0-0.1 (2014-11-06)}{
  \itemize{
    \item Function \code{unbind_one} saves the data for each column of a data frame to a
      separate RData file.
  }
}
