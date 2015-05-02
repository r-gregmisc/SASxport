\name{left}
\alias{right}
\alias{left}
\title{Return the leftmost or rightmost columns of a matrix or dataframe}
\description{
  Return the leftmost or rightmost or  columns of a matrix or dataframe
}
\usage{
right(x, n = 6)
left(x, n=6)
}
\arguments{
  \item{x}{Matrix or dataframe}
  \item{n}{Number of columns to return}
}
\value{
  An object consisting of the leftmost or rightmost  \code{n} columns
  of \code{x}.
}
\author{
  Gregory R. Warnes \email{greg@warnes.net}
}
\seealso{
  \code{\link{first}},
  \code{\link{last}},
  \code{\link[utils]{head}},
  \code{\link[utils]{tail}}
}
\examples{
 m <- matrix( 1:100, ncol=10 )
 colnames(m) <- paste("Col",1:10, sep="_")
 left(m)
 right(m)

 d <- as.data.frame(m)
 left(d)
 right(d)
}
\keyword{ manip }
