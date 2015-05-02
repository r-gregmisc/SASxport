\name{ans}
\alias{ans}
\title{Value of Last Evaluated Expression}
\usage{
ans()
}
\description{
  The functon returns the value of the last evaluated \emph{top-level}
  expression, which is always assigned to \code{.Last.value} (in
  \code{package:base}).
}
\details{
  This function retrieves \code{.Last.value}. For more details see 
  \code{\link[base]{.Last.value}}.  
}
\value{
  \code{.Last.value}
}
\seealso{
  \code{\link[base]{.Last.value}}, \code{\link[base]{eval}}
}
\author{Liviu Andronic}
\examples{
  2+2                  # Trivial calculation...
  ans()                # See the answer again

  gamma(1:15)          # Some intensive calculation...
  fac14 <- ans()       # store the results into a variable

  rnorm(20)            # Generate some standard normal values
  ans()^2              # Convert to Chi-square(1) values...
  stem(ans())          # Now show a stem-and-leaf table
}
\keyword{programming}
