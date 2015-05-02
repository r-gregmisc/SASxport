\name{first}
\alias{first}
\alias{last}
\title{Return first or last element of an object}
\description{
  Return first or last element of an object.  These functions are convenience
  wrappers for \code{head(x, n=1, ...)} and \code{tail(x, n=1, ...)}.
  }
\usage{
first(x, n=1, ...)
last(x, n=1, ...)
}
\arguments{
  \item{x}{data object}
  \item{n}{a single integer. If positive, size for the resulting object:
          number of elements for a vector (including lists), rows for a
          matrix or data frame or lines for a function. If negative,
          all but the 'n' last/first number of elements of 'x'.}
   \item{...}{arguments to be passed to or from other methods.}
}
\value{
  An object (usually) like 'x' but generally smaller.
}
\author{
  Gregory R. Warnes \email{greg@warnes.net}
}
\seealso{
  \code{\link[utils]{head}},
  \code{\link[utils]{tail}},
  \code{\link{left}},
  \code{\link{right}}
}
\examples{
## works for vectors..
v <- 1:10
first(v)
last(v)

## and for lists
l <- list(a=1, b=2, c=3)
first(l)
last(l)

## and data.frames
df <- data.frame(a=1:2, b=3:4, c=5:6)
first(df)
last(df)

## and matrixes
m <- as.matrix(df)
first(m)
last(m)

}
\keyword{ manip }
