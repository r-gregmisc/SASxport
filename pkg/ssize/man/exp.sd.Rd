\name{exp.sd}
\alias{exp.sd}
\docType{data}
\title{Example baseline variability for gene expression experiment}
\description{
Example baseline variability for gene expression experiment
}
\usage{data(exp.sd)}
\format{
  Vector of 12,625 standard deviations of gene expresion data normalized
  via the RMA method (ie on log2 scale) with names from Affymetrix probe
  set IDs.
}
%\details{
%  
%  ~~ If necessary, more details than the __description__ above ~~
%}
%\source{
%  
%}
%\references{
%  ~~ possibly secondary sources and usages ~~
%}
\examples{
data(exp.sd)

hist(exp.sd, prob=TRUE)
lines(density(exp.sd), col="red", lwd=2)
}
\keyword{datasets}
