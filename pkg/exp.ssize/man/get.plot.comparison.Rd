\name{get.plot.comparison}
\alias{get.plot.comparison}

\title{ Plot estimated and simulated power against sample size}
\description{
Plot estimated and simulated power against sample size}
\usage{
get.plot.comparison(power.est, power.real, nrep.simu,
	 xlab = "Sample Size (per group)",
	 ylab = "Proportion of Genes with Power >= 80%",
	 marks = c(3, 5, 8, 10, 20), ...)
}

\arguments{
  \item{power.est}{ a list of estimated power and summary of power greater than 80%,
	 each element of the list is calculated for one set of sd }
  \item{power.real}{a list of power based on simulation,
	 each element contains $power.real and $propn.80 }
  \item{nrep.simu}{ a vector of sample size for which the power is calculated for 
	 both simulation and estimation}
  \item{xlab}{ x label}
  \item{ylab}{ y label}
}

\value{
plot of power versus sample size
}

\author{ Peng Liu \email{peng_liu@groton.pfizer.com}}

% \note{ ~~further notes~~ }
% ~Make other sections like Warning with \section{Warning }{....} ~
% \seealso{ ~~objects to See Also as \code{\link{~~fun~~}}, ~~~ }

\examples{

}
\keyword{ device }
