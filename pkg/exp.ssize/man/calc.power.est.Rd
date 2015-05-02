\name{calc.power.est}
\alias{calc.power.est}

\title{ Calculate power and proportion of observations with power greater than 0.8 }
\description{
Given a set of sd and specified effect size, significance level and sample size,
	 calculate power and proportion of observations with power greater than 0.8
}
\usage{
calc.power.est(sd, nrep.simu, delta, sig.level)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{sd}{a vector of standard deviation}
  \item{nrep.simu}{ a vector which specifies the sample size for calculate power}
  \item{delta}{ effect size for sample size calculation }
  \item{sig.level}{ type I error rate to control }
}
\details{
  to be called by list.power.est
}
\value{
  \item{calc.power }{	the matrix of calculated power (ngenes x length( nrep.simu ))}
  \item{propn.80 }{	a vector of with the same length as the number of observations
		to store the proportion of observations with power greater than 0.8 }
}
% \references{ ~put references to the literature/web site here ~ }
\author{ Peng Liu \email{peng_liu@groton.pfizer.com}}

% \note{ ~~further notes~~ }

% ~Make other sections like Warning with \section{Warning }{....} ~
% \seealso{ ~~objects to See Also as \code{\link{~~fun~~}}, ~~~ }

\examples{
sd <- rep(0.1,5)
calc.power.est(sd, nrep.simu=c(3,5,8), delta = 1, sig.level = 0.05)
}
\keyword{ design }% at least one, from doc/KEYWORDS
