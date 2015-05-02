\name{sample.hyp.dep}
\alias{sample.null.dep}
\alias{sample.alt.dep}

\title{ Generate observations from each hypothesis (null/alternative)
        group based on dependent normal distribution }
\description{
 	  Generate observations from each hypothesis (null/alternative)
        group based on dependent normal distribution}
\usage{

sample.null.dep(ngenes.null.dep, n, var.ratio, cov.matrix,
                ngenes.matrix, distrn = "normal")

sample.alt.dep(ngenes.alt.dep, n, var.ratio, cov.matrix, ngenes.matrix,
               delta, distrn = "normal")

}
%- maybe also 'usage' for other objects documented here.
\arguments{

  \item{ngenes.null.dep}{an integer number for the number of observations
           (gene expression values) to simulate for genes coming from true
            null hypothesis}
  \item{n}{number of replicates for each group of control/treatment}
  \item{var.ratio}{ratio of variance between treatment/control}
  \item{cov.matrix}{a list of covariance matrices to sample the covariance from }
  \item{ngenes.matrix}{the number of covariance matrices in the list of cov.matrix }
  \item{distrn}{always being normal}

  \item{ngenes.alt.dep}{an integer number for the number of observations
           (gene expression values) to simulate for genes coming from true
            alternative hypothesis}
  \item{delta}{effect size for sample size calculation
           the absolute distance from zero for expression values of genes 
           coming from the true alternative hypothesis group}
}
% \details{
%   ~~ If necessary, more details than the __description__  above ~~
% }

\value{
  returns a matrix with ngenes.***.dep rows and 2*n columns with the first n 
  columns being samples from control group and last n columns being from
  treatment group for each gene (row). each group of genes consists of 
  subgroups of genes that are dependent
}
% \references{ ~put references to the literature/web site here ~ }

\author{ Peng Liu \email{peng\_liu@groton.pfizer.com}}
% \note{ ~~further notes~~ }

% ~Make other sections like Warning with \section{Warning }{....} ~

% \seealso{ ~~objects to See Also as \code{\link{~~fun~~}}, ~~~ }

\examples{
library(MASS)
ngenes.null.dep <- ngenes.alt.dep <- 10
n <- 1000; delta <- 50; var.ratio <- 1;

ngenes.matrix <- 7; cov.matrix <- list(ngenes.matrix);

for ( i in c(1:ngenes.matrix)) {
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

 test.sample.null.dep <- sample.null.dep(ngenes.null.dep , n, var.ratio,
      cov.matrix, ngenes.matrix)
 test.sample.alt.dep <- sample.alt.dep(ngenes.alt.dep , n, var.ratio,
      cov.matrix, ngenes.matrix, delta)

}
\keyword{ datagen }% at least one, from doc/KEYWORDS
\keyword{ multivariate }% __ONLY ONE__ keyword per line
