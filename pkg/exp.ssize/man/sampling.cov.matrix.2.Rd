\name{sampling.cov.matrix.2}
\alias{sampling.cov.matrix.2}

\title{Sample a list of covariance matrices that has the total number as ngenes.dep}
\description{
Sample a list of covariance matrices that has the total number as ngenes.dep
}
\usage{
sampling.cov.matrix.2(cov.list, ngenes.dep)
}

\arguments{
  \item{cov.list}{the list a covariance matrices to sample from }
  \item{ngenes.dep}{ the total number of dependent observations to sample}
}
\details{
  to be called by sample.dep.2
}
\value{
	returns a list of covariance matrices with the total number of 
	dimension equal to the number of dependent observations to simulate
}

\author{ Peng Liu \email{peng_liu@groton.pfizer.com}}

% \note{ ~~further notes~~ }
% ~Make other sections like Warning with \section{Warning }{....} ~
% \seealso{ ~~objects to See Also as \code{\link{~~fun~~}}, ~~~ }

\examples{
ngenes <- 7; cov.matrix <- list(ngenes);

for ( i in c(1:ngenes)) {
    cov.matrix[[i]] <- diag(rep(i*0.1, 50))
}

cov.matrix[[4]][1,1] <- cov.matrix[[5]][1,1] <- cov.matrix[[6]][1,1] <- 1
cov.matrix[[4]][2,1] <- cov.matrix[[4]][1,2] <- 0.15 # corr = 0.15 / (1*0.2) = 0.75
cov.matrix[[5]][2,1] <- cov.matrix[[5]][1,2] <- 0.5 # corr = 0.15 /(1*sqrt(0.5)) = 0.59
cov.matrix[[7]][1,1] <- 10
cov.matrix[[7]][2,1] <- cov.matrix[[7]][1,2] <- 0.6 # corr = 0.67
cov.matrix[[7]][3,1] <- cov.matrix[[7]][1,3] <- 0.5
cov.matrix[[7]][3,2] <- cov.matrix[[7]][2,3] <- 0.4

test.cov <- sampling.cov.matrix.2(cov.matrix, ngenes = 10)
test.cov2 <- sampling.cov.matrix.2(cov.matrix, ngenes = 60)
}
\keyword{ multivariate }% at least one, from doc/KEYWORDS
\keyword{ datagen }% __ONLY ONE__ keyword per line
