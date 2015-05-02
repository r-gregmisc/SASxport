\name{case}
\alias{case}
\title{Map elements of a vector according to the provided 'cases'}
\description{
  Map elements of a vector according to the provided 'cases'.  This
  function is useful for mapping discrete values to factor labels and 
  is the vector equivalent to the \code{switch} function.
}
\usage{
case(x, ..., default = NA)
}
\arguments{
  \item{x}{Vector to be converted}
  \item{\dots}{Map of alternatives, specified as "name"=value}
  \item{default}{Value to be assigned to elements of \code{x} not
    matching any of the alternatives. Defaults to \code{NA}.}
}
\details{
  This function is to \code{switch} what \code{ifelse} is to \code{if},
  and is a convenience wrapper for \code{factor}.
}
\value{
  A factor variables with each element of \code{x} mapped into the
  corresponding level of specified in the mapping.
}
\author{Gregory R. Warnes \email{greg@warnes.net}}
\seealso{\code{factor}, \code{switch}, \code{ifelse}}
\examples{
## default = NA
case( c(1,1,4,3), "a"=1, "b"=2, "c"=3)

## default = "foo"
case( c(1,1,4,3), "a"=1, "b"=2, "c"=3, default="foo" )


}
\keyword{ manip }
