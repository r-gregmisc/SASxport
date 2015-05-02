\name{get.sd}
\alias{get.sd}
\title{Function to Get sd from Inverse Variance}
\description{
  It is a small function to calculate sd by taking sqrt((num)^(-1)), 
  where num = inverse variance.
}
\usage{
get.sd(num)
}
\arguments{
  \item{num}{ a positive number or a vector of positive numbers}
}
\details{
  to be called by sample.null.ind or sample.alt.ind  
}
\value{
  a number that is the sqrt of the inverse of the argument
}
\author{Peng Liu \email{peng\_liu@groton.pfizer.com}}
\examples{

## example 1
temp1 <- get.sd(4)
temp1

## example 2
temp2 <- get.sd(c(1,4,9,16))
temp2
}
\keyword{ math }% at least one, from doc/KEYWORDS
