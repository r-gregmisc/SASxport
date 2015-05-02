% $Id$

\name{t.decision.Bonf}
\alias{t.decision.Bonf}
\alias{t.decision.FDR}
\title{ Accept or reject hypotheses at specified alpha level for a
        vector of p-values}
\description{
  Accept or reject hypotheses at specified
  alpha level for a vector of p-values}
}
\usage{
t.decision.Bonf(tp, sig.level)
t.decision.FDR(tp, sig.level)
}
\arguments{
  \item{tp}{1 column matrix of p-values}
  \item{sig.level}{Significance level (alpha)}
}
\value{
  Vector of logicals indicating whether the hypothsis was rejected
  (TRUE) or accepted (FALSE).
}
%\references{ ~put references to the literature/web site here ~ }
\author{ Peng Liu \email{peng\_liu@groton.pfizer.com}}
%\seealso{ ~~objects to See Also as \code{\link{~~fun~~}}, ~~~ }
\examples{
  p <- matrix(seq(0,0.01,by=0.001),ncol=1)
  bonf <- t.decision.Bonf(p, 0.05)
  fdr  <- t.decision.FDR(p, 0.05)
  data.frame("P-value"=p,"Bonferonni Reject"=bonf, "FDR Reject"=fdr)
}
\keyword{ multivariate}
