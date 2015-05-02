\name{simu.sample}
\alias{simu.sample}

\title{ Simulate a sample with normal distribution}
\description{
 Simulate samples from normal distributions with specified proportion 
 of observations from true alternative hypothesis, dependent groups,
 variance ratio for treatment/control group
}
\usage{
simu.sample(ngenes, n, fractn.alt, fractn.dep, var.ratio, cov.matrix, ngenes.matrix, delta)
}
\arguments{
  \item{ngenes}{number of genes to simulate }
  \item{n}{number of replicates for each group of control/treatment}
  \item{fractn.alt}{ the fraction of genes coming from true alternative hypothesis}
  \item{fractn.dep}{ the fraction of genes coming from dependent group }
  \item{var.ratio}{ ratio of variance between treatment/control }
  \item{cov.matrix}{  a list of covariance matrices to sample the covariance from }
  \item{ngenes.matrix}{ the number of covariance matrices in the list of cov.matrix }
  \item{delta}{ effect size for sample size calculation
           the absolute distance from zero for expression values of genes 
           coming from the true alternative hypothesis group }
}
% \details{
%  ~~ If necessary, more details than the __description__  above ~~
% }
\value{
  returns a matrix with ngenes rows and 2*n columns with the first n 
  columns being samples from control group and last n columns being from
  treatment group for each gene (row). each group of genes consists of 
  subgroups of genes that are dependent and/or coming from true alternative
  hypothesis. the row order is: null.ind -> null.dep -> alt.ind -> alt.dep

}

\author{ Peng Liu \email{peng\_liu@groton.pfizer.com}}
% \note{ ~~further notes~~ }

% ~Make other sections like Warning with \section{Warning }{....} ~

% \seealso{ ~~objects to See Also as \code{\link{~~fun~~}}, ~~~ }

\examples{
library(MASS)
cov.matrix <- list(7);

for ( i in c(1:7)) {
    cov.matrix[[i]] <- diag(rep(i*0.1, i+1))
    # cov.matrix[[i]] <- diag(rep(i*0.1,4))
}

cov.matrix[[4]][1,1] <- cov.matrix[[5]][1,1] <- cov.matrix[[6]][1,1] <- 1
cov.matrix[[4]][2,1] <- cov.matrix[[4]][1,2] <- 0.15 # corr = 0.15 / (1*0.2) = 0.75
cov.matrix[[5]][2,1] <- cov.matrix[[5]][1,2] <- 0.5 # corr = 0.15 /(1*sqrt(0.5)) = 0.59
cov.matrix[[7]][1,1] <- 10
cov.matrix[[7]][2,1] <- cov.matrix[[7]][1,2] <- 0.6 # corr = 0.67
cov.matrix[[7]][3,1] <- cov.matrix[[7]][1,3] <- 0.5
cov.matrix[[7]][3,2] <- cov.matrix[[7]][2,3] <- 0.4

test.sample <- simu.sample(ngenes = 100, n = 6, fractn.alt = 0.8, fractn.dep = 0.2,
   var.ratio=1, cov.matrix, ngenes.matrix = 7, delta = 10)

}
\keyword{ datagen }% at least one, from doc/KEYWORDS
\keyword{ multivariate }% __ONLY ONE__ keyword per line
