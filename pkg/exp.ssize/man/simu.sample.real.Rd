\name{simu.sample.real}
\alias{simu.sample.real}

\title{ Simulate a sample to do t test}
\description{
	Simulate a sample to do t test
}
\usage{
simu.sample.real(sd.null, sd.alt, cov.null, ngenes.null.dep, cov.alt, ngenes.alt.dep, n, var.ratio, delta)
}

\arguments{
  \item{sd.null}{  sd vector for observations that are independent and come from Ho }
  \item{sd.alt}{ sd vector for observations that are independent and come from Ha}
  \item{cov.null}{ list of covariance matrices for observations that are 
	dependent and come from Ho }
  \item{ngenes.null.dep}{  number of observations in dependent groups for
	observations coming from Ho }
  \item{cov.alt}{ list of covariance matrices for observations that are 
	dependent and come from Ha }
  \item{ngenes.alt.dep}{ number of observations in dependent groups for
	observations coming from Ha }
  \item{n}{ number of replicates to simulate for each group of control/treatment }
  \item{var.ratio}{ ratio of variance between treatment/control}
  \item{delta}{ effect size for sample size calculation
           the absolute distance from null value for expression values of genes 
           coming from Ha group}
}
\details{
 	simulate observations from both control group and treatment group
}

\value{
	returns a matrix of data with each row for a observation and 
	columns are replicates, observations from Ho group occupy
	first rows followed by observations from Ha
	first n columns are from control group and second n columns 
	are from treatment group
}
\author{ Peng Liu \email{peng_liu@groton.pfizer.com}}

% \note{ ~~further notes~~ }
% ~Make other sections like Warning with \section{Warning }{....} ~
% \seealso{ ~~objects to See Also as \code{\link{~~fun~~}}, ~~~ }

\examples{
library(MASS)
sd.null <- rep(0.1,4); sd.alt <- rep(0.2,5);
cov.null <- cov.alt <- list(2)
cov.null[[1]] <- cov.alt[[1]] <- cbind(c(0.1, 0.05), c(0.05,0.2));
cov.null[[2]] <- cbind(c(0.15, 0.05), c(0.05,0.2));
cov.alt[[2]] <- cbind(c(0.039, -0.037, 0.018), c(-0.037, 0.045, -0.021),
	 c(0.018, -0.021, 0.013));

test <- simu.sample.real(sd.null, sd.alt, cov.null, ngenes.null.dep = 4,
	 cov.alt, ngenes.alt.dep=5, n = 15,	var.ratio = 1, delta = 5)

# dim(test) should be [18,30]
}
\keyword{ datagen } 
\keyword{ multivariate } 
