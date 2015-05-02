\name{upperTriangle}
\alias{upperTriangle}
\alias{upperTriangle<-}
\alias{lowerTriangle}
\alias{lowerTriangle<-}
\title{Extract or replace the upper/lower triangular portion of a matrix}
\description{
  Extract or replace the upper/lower triangular portion of a matrix
}
\usage{
upperTriangle(x, diag=FALSE)
upperTriangle(x, diag=FALSE) <- value
lowerTriangle(x, diag=FALSE)
lowerTriangle(x, diag=FALSE) <- value
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{Matrix}
  \item{diag}{Logical.  If \code{TRUE}, include the matrix diagonal.}
  \item{value}{Either a single value or a vector of length equal to that
    of the current upper/lower triangular.  Should be of a mode which 
    can be coerced to that of \code{x}.}
}

\value{
  \code{upperTriangle(x)} and \code{lowerTriangle(x)} return the upper
  or lower triangle of matrix x, respectively. The assignment forms
  replace the upper or lower traingular area of the
  matrix with the provided value(s).
  }
\author{Gregory R. Warnes \email{greg@warnes.net}}
\seealso{ \code{\link[base]{diag}} }
\examples{
  x <- matrix( 1:25, nrow=5, ncol=5)
  x
  upperTriangle(x)
  upperTriangle(x, diag=TRUE)

  lowerTriangle(x)
  lowerTriangle(x, diag=TRUE)

  upperTriangle(x) <- NA
  x

  upperTriangle(x, diag=TRUE) <- 1:15
  x

  lowerTriangle(x) <- NA
  x

  lowerTriangle(x, diag=TRUE) <- 1:15
  x

}
\keyword{array}
