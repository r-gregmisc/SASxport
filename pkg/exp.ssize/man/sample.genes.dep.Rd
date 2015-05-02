% $Id$
\name{sample.genes.dep}
\alias{sample.genes.dep}
\alias{sample.genes.dep.grp}
\title{Simulate Observations Given the Covariance Matrix for Normal Distribution}
\description{
    simulate a sample for genes given the covariance matrix for normal
    distribution
    }
\usage{
sample.genes.dep(n, delta, cov.ctrl, var.ratio)
sample.genes.dep.grp(n, delta, cov.ctrl, var.ratio)
}
\arguments{
  \item{n}{ number of replicates for each observation(gene) for each 
     of control/treatment group }
  \item{delta}{ effect size for sample size calculation the minimum
     distance from zero for expression values of genes coming from 
     the true alternative hypothesis group}
  \item{cov.ctrl}{ covariance matrix for control group }
  \item{var.ratio}{ a positive number for the ration of variance between 
           treatment and control }
}
\details{
  \code{sample.genes.dep} allows any size covariance matrix, while
  \code{sample.genes.dep.grp} assumes that the covariance matrix is 50x50.

  The number of observation in the generated sample depends on the size of 
  covariance matrix, the replicates for each observation for each control/
  treatment group is specified by n
}
\value{
  returns a matrix with row number corresponding to the size of the covariance
  matrix and with 2*n columns: the first n columns being samples from control
  group and last n columns being from treatment group 
}
% \references{ ~put references to the literature/web site here ~ }

\author{ Peng Liu \email{peng_liu\@groton.pfizer.com}}

% \seealso{ ~~objects to See Also as \code{\link{~~fun~~}}, ~~~ }

\examples{

library(MASS)
# set.seed(100)
n <- 1000; delta <- 50; var.ratio <- 1;
cov.ctrl <- diag(rep(0.4,4))
cov.ctrl[1,1] <- 1
cov.ctrl[1,2] <- cov.ctrl[2,1] <- 0.15; # from test.sampling.cov

test.sample <- sample.genes.dep(n, delta, cov.ctrl, var.ratio)

\dontrun{
% begin dontrun
ndim <- dim(test.sample);
var.r <- rep(0, ndim[1])

for ( i in c(1:ndim[1]))
  { var.r[i] <- var(test.sample[i,(n+1):(2*n)]) / var(test.sample[i,1:n])}

generated.cov <- cov(t(test.sample[,1:n]), t(test.sample[,1:n]))
% # the fn cov compute the covariance between the columns

cat("comparison between the desired sample and the generated sample: \n")

cat(" ------------------------------------------ \n",
    "number of genes (rows) :\t", length(cov.ctrl[1,]), "\t", ndim[1], "\n",
    "number of obs for each group: \t", n, "\t", ndim[2]/2, "\n",
    "variance ratio (trt/ctrl) is: \t", var.ratio, "\t", mean(var.r), "\n",
    "covariance matrix should be: \n")
print(cov.ctrl)

cat("the covariance matrix for the generated sample is: \n")
print(generated.cov)
cat("\n------------------------------------------ \n")
}	% end of dontrun

}
\keyword{ datagen }% at least one, from doc/KEYWORDS
\keyword{ multivariate }% __ONLY ONE__ keyword per line

