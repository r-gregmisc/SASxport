\name{FDR}
\alias{FDR}

\title{ Calculate FDR for a vector of p-values}
\description{
Calculate FDR for a vector of p-values
}
\usage{
FDR(p)
}

\arguments{
  \item{p}{ a vector of p-values }
}

\value{
	returns a vector of FDR values based on Benjamini & Hochberg procedure
}
\references{ Benjamini and Hochberg, 1995, JRSSB}
\author{ Peng Liu \email{peng_liu@groton.pfizer.com}}
% \note{ ~~further notes~~ }

% ~Make other sections like Warning with \section{Warning }{....} ~

% \seealso{ ~~objects to See Also as \code{\link{~~fun~~}}, ~~~ }

\examples{
p.test <- c(0.01,0.025,0.05,0.1)
FDR(p.test)
}
\keyword{ multivariate}
