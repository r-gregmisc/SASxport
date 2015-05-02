\name{Args}
\alias{Args}
\title{Describe Function Arguments}
\description{
  Display function argument names and corresponding default values,
  formatted in two columns for easy reading.
}
\usage{
Args(name, sort=FALSE)
}
\arguments{
  \item{name}{a function or function name.}
  \item{sort}{whether arguments should be sorted.}
}
\value{
  A data frame with named rows and a single column called \code{value},
  containing the default value of each argument.
}
\note{
  Primitive functions like \code{sum} and \code{all} have no formal
  arguments. See the \code{\link{formals}} help page.
}
\author{Arni Magnusson}
\seealso{
  \code{Args} is a verbose alternative to \code{\link{args}}, based on
  \code{\link{formals}}.

  \code{\link{help}} also describes function arguments.
}
\examples{
Args(glm)
Args(scan)
Args(legend, sort=TRUE)
}
% Programming
\keyword{programming}
\keyword{utilities}
\keyword{documentation}
