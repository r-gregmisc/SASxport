\name{resample}
\alias{resample}
\title{Consistent Random Samples and Permutations}
\description{
  \code{resample} takes a sample of the specified size from the
  elements of \code{x} using either with or without replacement.

}
\usage{
resample(x, size, replace = FALSE, prob = NULL)
}
\arguments{
  \item{x}{ A numeric, complex, character or logical vector from which
    to choose.}
  \item{size}{Non-negative integer giving the number of items to choose.}
  \item{replace}{Should sampling be with replacement?}
  \item{prob}{A vector of probability weights for obtaining the elements of
    the vector being sampled.}
  }
\details{
  \code{resample} differs from the S/R \code{sample} function in
  \code{resample} always considers \code{x} to be a vector of elements
  to select from, while \code{sample} treats a vector of length one as a
  special case and samples from \code{1:x}.  Otherwise, the functions
  have identical behavior.
}
\value{
  Vector of the same length as the input, with the elements permuted.
}
\author{Gregory R. Warnes \email{greg@warnes.net} }
\seealso{ \code{\link{sample}} }
\examples{

## sample behavior differs if first argument is scalar vs vector
sample( c(10) )
sample( c(10,10) )

## resample has the consistent behavior for both cases
resample( c(10) )
resample( c(10,10) )

}
\keyword{misc}
