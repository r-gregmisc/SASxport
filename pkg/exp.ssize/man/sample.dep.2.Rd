\name{sample.dep.2}
\alias{sample.dep.2}

\title{ Simulate a sample of groups of dependent normal observations}
\description{
   Given a list of covariance matrices, this function
   simulate normal observation based on the covariance matrix from 
   first until the last one in the list of cov.matrix
}
\usage{
sample.dep.2(ngenes.dep, n, var.ratio, cov.matrix, delta, distrn = "normal")
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{ngenes.dep}{ integer number of genes to sample the dependent expression  }
  \item{n}{ positive integer number of replicates for each gene each group 
           (control/treatment)}
  \item{var.ratio}{ a positive number for the ratio of variance between 
           treatment and control }
  \item{cov.matrix}{ a list of covariance matrices based on which normal 
	     samples are generated}
  \item{delta}{ effect size for sample size calculation
           the absolute distance from null value for expression values of genes 
           coming from the true alternative hypothesis group}
  \item{distrn}{ distribution of expression data, set to be normal for here }
}
% \details{
%   ~~ If necessary, more details than the __description__  above ~~
% }

\value{
  returns a matrix with ngenes.dep rows and 2*n columns with the first n 
  columns being samples from control group and last n columns being from
  treatment group for each gene (row). each group of genes consists of 
  subgroups of genes that are dependent
}
\author{ Peng Liu \email{peng_liu@groton.pfizer.com}}
% \note{ ~~further notes~~ }

% ~Make other sections like Warning with \section{Warning }{....} ~

% \seealso{ ~~objects to See Also as \code{\link{~~fun~~}}, ~~~ }

\examples{
library(MASS)

n.dep <- 9; n <- 100; delta <- 5; var.ratio <- 1;
n.matrix <- 3; cov.matrix <- list(n.matrix);

for ( i in c(1:n.matrix)) {
    cov.matrix[[i]] <- diag(rep(i*0.1, 3))
}

cov.matrix[[3]][1,1] <- cov.matrix[[2]][1,1] <- 1
cov.matrix[[3]][2,1] <- cov.matrix[[3]][1,2] <- 0.15 

test.sample.dep <- sample.dep.2( n.dep , n, var.ratio, cov.matrix, delta, distrn = "normal")

}
\keyword{ multivariate }
\keyword{ datagen }
