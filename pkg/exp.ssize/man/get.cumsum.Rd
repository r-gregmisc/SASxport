\name{get.cumsum}
\alias{get.cumsum}

\title{ Get cumsum along columns for a matrix }
\description{
	Get cumsum along columns for a matrix 
}
\usage{
get.cumsum(mat)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{mat}{ a matrix for which cumsum along columns is desired}
}

\value{
returns a matrix of cumsum along columns
}

\author{ Peng Liu \email{peng_liu@groton.pfizer.com}}

% \note{ ~~further notes~~ }
% ~Make other sections like Warning with \section{Warning }{....} ~
% \seealso{ ~~objects to See Also as \code{\link{~~fun~~}}, ~~~ }

\examples{

m <- matrix(1:20, nr = 4, nc = 5)
get.cumsum(m)

}
\keyword{ array }
