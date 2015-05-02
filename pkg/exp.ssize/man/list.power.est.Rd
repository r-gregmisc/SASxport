\name{list.power.est}
\alias{list.power.est}

\title{ Calculate power for each set of sd in est.sd }
\description{
	Calculate power for each set of sd in est.sd 
}
\usage{
list.power.est(est.sd, ngenes.null, nrep.simu, delta, sig.level)
}

\arguments{
  \item{est.sd}{ a matrix of estimated sd, one row for each observation
		and one column for each sample size}
  \item{ngenes.null}{ number of genes from Ho }
  \item{nrep.simu}{ sample size used for power calculation }
  \item{delta}{ effect size for power calculation }
  \item{sig.level}{ type I error rate }
}

\value{
returns a list with the same length as the number of sets for sd
each component in the list is a list of a matrix (stores estimated power)
and a vector (stores summary of proportion of observations with power greater
then 80%
}

\author{ Peng Liu \email{peng_liu@groton.pfizer.com}}

% \note{ ~~further notes~~ }
% ~Make other sections like Warning with \section{Warning }{....} ~
% \seealso{ ~~objects to See Also as \code{\link{~~fun~~}}, ~~~ }

\examples{
est.sd <- cbind(c(1:4)*0.01, c(1:4)*0.1)
list.power.est(est.sd, ngenes.null=0, nrep.simu=c(3,5,8), delta=1, sig.level=0.05)

}
\keyword{ multivariate }
\keyword{ design }
