% $Id%
%
\name{frameApply}
\alias{frameApply}
\title{Subset analysis on data frames}
\description{Apply a function to row subsets of a data frame. 
}
\usage{
frameApply(x, by=NULL, on=by[1], fun=function(xi) c(Count=nrow(xi)), 
           subset=TRUE, simplify=TRUE, byvar.sep="\\\\$\\\\@\\\\$", ...)
}
\arguments{
  \item{x}{a data frame}
  \item{by}{names of columns in \code{x} specifying the variables to use
    to form the subgroups. 
    None of the \code{by} variables should have
    the name "sep" (you will get an error if one of them does; a bit of
    laziness in the code). Unused levels of 
    the \code{by} variables will be dropped. Use \code{by = NULL} (the
    default) to indicate that all of the data is to be treated as a
    single (trivial) subgroup.}
  \item{on}{names of columns in \code{x} specifying columns over which
    \code{fun} is to be applied. These can include columns specified in
    \code{by}, (as with the default) although that is not usually the case.}
  \item{fun}{a function that can operate on data frames that are row
    subsets of \code{x[on]}. If \code{simplify = TRUE},
    the return value of the function should always be either a try-error
    (see \code{\link{try}}), or a vector of
    fixed length (i.e. same length for every subset), preferably with
    named elements.}
  \item{subset}{logical vector (can be specified in terms of variables
    in data). This row subset of \code{x} is taken before doing anything
    else.}
  \item{simplify}{logical. If TRUE (the default), return value will
    be a data frame including the \code{by} columns and a column for
    each element of the return vector of \code{fun}. If FALSE, the
    return value will be a list, sometimes necessary for less structured
    output (see description of return value below).}
  \item{byvar.sep}{character. This can be any character string not
    found anywhere in the values of the \code{by} variables. The
    \code{by} variables will be pasted together using this as the
    separator, and the result will be used as the index to form the
    subgroups.  }
  \item{...}{additional arguments to \code{fun}.}
}
\value{a data frame if \code{simplify = TRUE} (the default), assuming
  there is sufficiently structured output from \code{fun}. If
  \code{simplify = FALSE} and \code{by} is not NULL, the return value will be a list with two
  elements. The first element, named "by", will be a data frame with the
  unique rows of \code{x[by]}, and the second element, named "result"
  will be a list where the ith 
  component gives the result for the ith row of the "by" element.  
}
\details{This function accomplishes something similar to
  \code{\link{by}}. The main difference is that \code{frameApply} is
  designed to return data frames and lists instead of objects of class
  'by'. Also, \code{frameApply} works only on the unique combinations of
  the \code{by} that are actually present in the data, not on the entire
  cartesian product of the \code{by} variables. In some cases this
  results in great gains in efficiency, although \code{frameApply} is
  hardly an efficient function.}

\examples{
data(ELISA, package="gtools")

# Default is slightly unintuitive, but commonly useful: 
frameApply(ELISA, by = c("PlateDay", "Read"))

# Wouldn't actually recommend this model! Just a demo:
frameApply(ELISA, on = c("Signal", "Concentration"), by = c("PlateDay", "Read"),
           fun = function(dat) coef(lm(Signal ~ Concentration, data =
dat)))

frameApply(ELISA, on = "Signal", by = "Concentration",
           fun = function(dat, ...) {
                    x <- dat[[1]]
                    out <- c(Mean = mean(x, ...),
                             SD = sd(x, ...),
                             N = sum(!is.na(x)))
                  },
           na.rm = TRUE,
           subset = !is.na(Concentration))
}
\author{Jim Rogers \email{james.a.rogers@pfizer.com}}
\keyword{manip}

