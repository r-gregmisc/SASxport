\name{power.simu}
\alias{power.simu}

\title{ Summarize the simulated power in a list }
\description{
	Summarize the simulated power in a list 
}
\usage{
power.simu(avg.power, nrep.simu, ngenes.null)
}

\arguments{
  \item{avg.power}{ a matrix of average test result with each element being
	the proportion of rejection in t-test for that observation
	the 1st ngenes.null rows store result for observations from Ho}
  \item{nrep.simu}{ interested sample size fr power calculation }
  \item{ngenes.null}{ the number of observations from Ho }
}
% \details{
%  ~~ If necessary, more details than the __description__  above ~~
% }
\value{
  \item{true.power}{the matrix of calculated power with dimension: ngenes x length(nrep.simu)}
  \item{propn.80}{a vector of propn.80 with length = ngenes}

}

\author{ Peng Liu \email{peng_liu@groton.pfizer.com}}

% \note{ ~~further notes~~ }
% ~Make other sections like Warning with \section{Warning }{....} ~
% \seealso{ ~~objects to See Also as \code{\link{~~fun~~}}, ~~~ }

\examples{
avg.power <- matrix(runif(1000,0,1), nr = 100, nc = 10)
a <- power.simu(avg.power, nrep.simu = c(3,5,8), ngenes.null = 10)
}
\keyword{ design }
