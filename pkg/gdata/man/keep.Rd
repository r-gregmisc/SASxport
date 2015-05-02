\name{keep}
\alias{keep}
\title{Remove All Objects, Except Those Specified}
\description{
  Remove all objects from the user workspace, except those specified.
}
\usage{
keep(..., list=character(0), all=FALSE, sure=FALSE)
}
\arguments{
  \item{...}{objects to be kept, specified one by one, quoted or
    unquoted.}
  \item{list}{character vector of object names to be kept.}
  \item{all}{whether hidden objects (beginning with a \code{.}) should
    be removed, unless explicitly kept.}
  \item{sure}{whether to perform the removal, otherwise return names of
    objects that would have been removed.}
}
\details{
  Implemented with safety caps: objects whose name starts with a
  \code{.} are not removed unless \code{all=TRUE}, and an explicit
  \code{sure=TRUE} is required to remove anything.
}
\value{
  A character vector containing object names, or \code{NULL} when
  \code{sure} is \code{TRUE}.
}
\author{Arni Magnusson}
\seealso{
  \code{keep} is a convenient interface to \code{\link{rm}} when
  removing most objects from the user workspace.
}
\examples{
data(women, cars)
keep(cars)
## To remove all objects except cars, run:
## keep(cars, sure=TRUE)
}
% Programming
\keyword{data}
\keyword{environment}
\keyword{utilities}
