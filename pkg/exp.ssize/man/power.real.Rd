\name{power.real}
\alias{power.real}

\title{ Summarize test result in power }
\description{
	Summarize test result in power 
}
\usage{
power.real(avg.power)
}

\arguments{
  \item{avg.power}{ a matrix of average test result with each element being the proportion
	of rejection in t-test for that observation}
}
%\details{
%  ~~ If necessary, more details than the __description__  above ~~
%}

\value{
  \item{avg.power }{mean power based on all tests in simulation}
  \item{propn.80}{proportion of number of observations with power greater than 0.8 }
}

\author{ Peng Liu \email{peng_liu@groton.pfizer.com}}

% \note{ ~~further notes~~ }
% ~Make other sections like Warning with \section{Warning }{....} ~
% \seealso{ ~~objects to See Also as \code{\link{~~fun~~}}, ~~~ }

\examples{
avg.power <- matrix(runif(100,0,1), nr = 25, nc = 4)
power.real(avg.power)
}
\keyword{ design }
