\name{tdecision.mutiComp}
\alias{tdecision.FDR}
\alias{tdecision.Bonf}

\title{Get the test decision based on FDR procedure or Bonferroni adjustment for a matrix of p-values }
\description{
	Get the test decision based on FDR procedure or Bonferroni adjustment for a matrix of p-values 
}
\usage{
tdecision.FDR(tp, sig.level)
tdecision.Bonf(tp, sig.level)
}

\arguments{
  \item{tp}{ a matrix matrix of p-values from t test}
  \item{sig.level}{ type I error to control for multiple tests}
}
%\details{
%
%}
\value{
 returns a logical matrix for t-test decision based on corresponding p values
}
\author{ Peng Liu \email{peng_liu@groton.pfizer.com}}

% \note{ ~~further notes~~ }
% ~Make other sections like Warning with \section{Warning }{....} ~
% \seealso{ ~~objects to See Also as \code{\link{~~fun~~}}, ~~~ }

\examples{
tp <- matrix(runif(10,0,1), nr = 5, nc = 2)
decision <- tdecision.FDR(tp, sig.level = 0.05)
decision <- tdecision.Bonf(tp, sig.level = 0.05)
}

\keyword{ htest }
