\name{sample.dep}
\alias{sample.dep}

\title{ Simulate a sample of groups of dependent normal observations}
\description{
   Given a structure of covariance matrices to sample from, this function
   repeats the steps of first randomly selects covariance matrices and 
   then simulate normal observation based on the current selected covariance
   until the sample of specified size is reached
}
\usage{
sample.dep(ngenes.dep, n, var.ratio, cov.matrix, ngenes.matrix, delta, distrn = "normal")
}
\arguments{
  \item{ngenes.dep}{integer number of genes to sample the dependent expression  }
  \item{n}{ positive integer number of replicates for each gene each group 
           (control/treatment)}
  \item{var.ratio}{ a positive number for the ratio of variance between 
           treatment and control }
  \item{cov.matrix}{ a list of covariance matrices to sample the covariance from}
  \item{ngenes.matrix}{ the number of covariance matrices in the list of cov.matrix }
  \item{delta}{ effect size for sample size calculation
           the absolute distance from zero for expression values of genes 
           coming from the true alternative hypothesis group}
  \item{distrn}{ distribution of expression data, set to be normal for here }
}
\value{
  returns a matrix with ngenes.ind rows and 2*n columns with the first n 
  columns being samples from control group and last n columns being from
  treatment group for each gene (row). each group of genes consists of 
  subgroups of genes that are dependent
}
% \references{ ~put references to the literature/web site here ~ }

\author{ Peng Liu \email{peng\_liu@groton.pfizer.com}}

% \seealso{ ~~objects to See Also as \code{\link{~~fun~~}}, ~~~ }

\examples{
 library(MASS)
# set.seed(100)

# initial values to put in argument
n.dep <- 10; n <- 1000; delta <- 50; var.ratio <- 1;

ngenes <- 7; cov.matrix <- list(ngenes);

for ( i in c(1:ngenes)) {
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

## begin testing
test.sample.dep <- sample.dep( n.dep , n, var.ratio, cov.matrix, ngenes, delta, distrn = "normal")

\dontrun{ % begin of dontrun

ndim <- dim(test.sample.dep);
var.r <- rep(0, ndim[1])

for ( i in c(1:ndim[1]))
  {
     var.r[i] <- var(test.sample.dep[i,(n+1):(2*n)]) /
                var(test.sample.dep[i,1:n])
  }

generated.cov <- cov(t(test.sample.dep[,1:n]), t(test.sample.dep[,1:n]))
# the fn cov compute the covariance between the columns

cat("\n comparison between the desired sample and the generated sample: \n")

cat(" ------------------------------------------ \n",
    "number of genes (rows) :\t", n.dep, "\t", ndim[1], "\n",
    "number of obs for each group: \t", n, "\t", ndim[2]/2, "\n",
    "variance ratio (trt/ctrl) is: \t", var.ratio, "\t", mean(var.r), "\n",
    "covariance matrix should be one of the following: \n")
# print(cov.matrix)

cat("the covariance matrix for the generated sample is: \n")
print(generated.cov)
cat("\n------------------------------------------ \n")

} % end of dontrun

}
\keyword{ datagen }
\keyword{ multivariate }
