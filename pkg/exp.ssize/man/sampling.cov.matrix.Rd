\name{sampling.cov.matrix}
\alias{sampling.cov.matrix}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{ Sample a covariance matrix from a list of cov matrices}
\description{
  Sample a covariance matrix from a list of cov matrices
}
\usage{
sampling.cov.matrix(cov.matrix, ngenes)
}
\arguments{
  \item{cov.matrix}{ the list a covariance matrices to sample from }
  \item{ngenes}{ number of covariance matrices in the list of cov.matrix}
}
\details{
  to be called by sample.dep
}
\value{
return a covariance matrix randomly sampled from the list of cov.matrix

}
\references{ ~put references to the literature/web site here ~ }
\author{ Peng Liu \email{peng\_liu@groton.pfizer.com}}
% \note{ ~~further notes~~ }

% ~Make other sections like Warning with \section{Warning }{....} ~

% \seealso{ ~~objects to See Also as \code{\link{~~fun~~}}, ~~~ }

\examples{
ngenes <- 7; cov.matrix <- list(ngenes);

for ( i in c(1:ngenes)) {
    cov.matrix[[i]] <- diag(rep(i*0.1, i+1))
}

cov.matrix[[4]][1,1] <- cov.matrix[[5]][1,1] <- cov.matrix[[6]][1,1] <- 1
cov.matrix[[4]][2,1] <- cov.matrix[[4]][1,2] <- 0.15 # corr = 0.15 / (1*0.2) = 0.75
cov.matrix[[5]][2,1] <- cov.matrix[[5]][1,2] <- 0.5 # corr = 0.15 /(1*sqrt(0.5)) = 0.59
cov.matrix[[7]][1,1] <- 10
cov.matrix[[7]][2,1] <- cov.matrix[[7]][1,2] <- 0.6 # corr = 0.67
cov.matrix[[7]][3,1] <- cov.matrix[[7]][1,3] <- 0.5
cov.matrix[[7]][3,2] <- cov.matrix[[7]][2,3] <- 0.4

test.cov <- sampling.cov.matrix(cov.matrix, ngenes)

}
\keyword{ multivariate }% at least one, from doc/KEYWORDS
\keyword{ datagen }% __ONLY ONE__ keyword per line
