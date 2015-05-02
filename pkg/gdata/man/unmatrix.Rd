\name{unmatrix}
\alias{unmatrix}
\title{Convert a matrix into a vector, with appropriate names}
\description{
  Convert a matrix into a vector, with element names constructed from
  the row and column names of the matrix.
}
\usage{
unmatrix(x, byrow=FALSE)
}
\arguments{
  \item{x}{matrix}
  \item{byrow}{Logical. If \code{FALSE}, the elements within columns will be
    adjacent in the resulting vector, otherwise elements within rows
    will be adjacent.}
}
\value{
  A vector with names constructed from the row and column names from the
  matrix. If the the row or column names are missing, ('r1', 'r2', ..,) or
  ('c1', 'c2', ..) will be used as appropriate.
}
\author{Gregory R. Warnes \email{greg@warnes.net} }
\seealso{ \code{\link[base]{as.vector}} }
\examples{
# simple, useless example
m <- matrix( letters[1:10], ncol=5)
m
unmatrix(m)

# unroll model output
x <- rnorm(100)
y <- rnorm(100, mean=3+5*x, sd=0.25)
m <- coef( summary(lm( y ~ x )) )
unmatrix(m)
}
\keyword{manip}

