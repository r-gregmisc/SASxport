\name{est.sd.ctrl}
\alias{est.sd.ctrl}

\title{ Estimate sd for a control sample matrix}
\description{
    Estimate sd for a control sample matrix with dimension
    being num(observation) * num(replicates)
}
\usage{
est.sd.ctrl(sample.ctrl, nrep)
}

\arguments{
  \item{sample.ctrl}{ a sample matrix to estimate sd from}
  \item{nrep}{ a vector specifying the number of replicates to use for sd estimation }
}
% \details{
%  ~~ If necessary, more details than the __description__  above ~~
% }
\value{
	returns a matrix of sd with each row for one observation
	the columns are for each number of replicates in the vectr nrep
	column names are number of replicates in the vectr nrep
}

\author{ Peng Liu \email{peng_liu@groton.pfizer.com}}
% \note{ ~~further notes~~ }

% ~Make other sections like Warning with \section{Warning }{....} ~

% \seealso{ ~~objects to See Also as \code{\link{~~fun~~}}, ~~~ }

\examples{

sample.ctrl <- matrix(rnorm(100, 1:4, 0.1*(1:4)), nr = 4, nc = 20)
a <- est.sd.ctrl(sample.ctrl, nrep = c(5,20))
a
}
\keyword{ univar }% at least one, from doc/KEYWORDS
