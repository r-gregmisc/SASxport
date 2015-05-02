\name{is.what}
\alias{is.what}
\title{Run Multiple is.* Tests on a Given Object}
\description{
  Run multiple \code{is.*} tests on a given object: \code{is.na},
  \code{is.numeric}, and many others.
}
\usage{
is.what(object, verbose=FALSE)
}
\arguments{
  \item{object}{any \R object.}
  \item{verbose}{whether negative tests should be included in output.}
}
\value{
  A character vector containing positive tests, or when \code{verbose}
  is \code{TRUE}, a data frame showing all test results.
}
\author{Arni Magnusson, inspired by \code{demo(is.things)}.}
\note{
  The following procedure is used to look for valid tests:
  \enumerate{
    \item{}{Find all objects named \code{is.*} in all loaded
      environments.}
    \item{}{Discard objects that are not functions.}
    \item{}{Include test result only if it is of class \code{"logical"},
      not an \code{NA}, and of length 1.}
  }
}
\seealso{
  \code{\link{is.na}} and \code{\link{is.numeric}} are commonly used
  tests.
}
\examples{
is.what(pi)
is.what(NA, verbose=TRUE)
is.what(lm(1~1))
is.what(is.what)
}
% Basics
\keyword{classes}
\keyword{NA}
% Programming
\keyword{programming}
\keyword{error}
\keyword{utilities}
