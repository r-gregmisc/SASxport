\name{sample.genes.ind}
\alias{sample.genes.ind}
\title{Sample Observations (gene expressions) from Independent Normal 
       Distribution with Known sd}
\description{
   Sample observations (gene expressions) from independent normal 
   distribution for both control group and the treatment group with 
   known sd for control group and the variance ratio between
   treatment/control groups.
}
\usage{
sample.genes.ind(ngenes.ind, n, sd.ctrl, var.ratio, delta, distrn = "normal")
}
\arguments{
  \item{ngenes.ind}{ positive integer number of genes to sample the expression }
  \item{n}{ positive integer number of replicates for each gene each group 
           (control/treatment)}
  \item{sd.ctrl}{ vector of positive numbers for the sample length as 
           ngenes.ind }
  \item{var.ratio}{ a positive number for the ratio of variance between 
           treatment and control}
  \item{delta}{ effect size for sample size calculation
           the minimum distance from zero for expression values of genes 
           coming from the true alternative hypothesis group}
  \item{distrn}{ distribution of expression data, set to be normal for here}
}
% \details{
%   ~~ If necessary, more details than the __description__  above ~~
% }
\value{
  returns a matrix with ngenes.ind rows and 2*n columns with the first n 
  columns being samples from control group and last n columns being from
  treatment group for each gene (row)
}
% \references{ ~put references to the literature/web site here ~ }

\author{ Peng Liu \email{peng\_liu@groton.pfizer.com}}
% \note{ ~~further notes~~ }

% ~Make other sections like Warning with \section{Warning }{....} ~

% \seealso{ ~~objects to See Also as \code{\link{~~fun~~}}, ~~~ }

\examples{
##---- Should be DIRECTLY executable !! ----

n.ind <- 100; n <- 500; sd.ctrl <- c(1:100)*0.01
var.ratio1 <- 10;
delta <- 50;

test.sample1 <- sample.genes.ind(n.ind, n, sd.ctrl, var.ratio1, delta)
ndim <- dim(test.sample1);
var.r <- rep(0, ndim[1])
k <- ceiling(n.ind * runif(1,0,1))

for ( i in c(1:ndim[1]))
  { var.r[i] <- var(test.sample1[i,(n+1):(2*n)]) / var(test.sample1[i,1:n])}

cat("comparison between the desired sample and the generated sample: \n")

cat(" ------------------------------------------ \n",
    "number of genes (rows) :\t", n.ind, "\t", ndim[1], "\n",
    "number of obs for each group: \t", n, "\t", ndim[2]/2, "\n",
    "variance ratio (trt/ctrl) is: \t", var.ratio1, "\t", mean(var.r), "\n",
    "sd for gene", k, ":\t\t", sd.ctrl[k], "\t", sd(test.sample1[k,1:n]), "\n",
    "------------------------------------------ \n")

}
\keyword{ datagen }% at least one, from doc/KEYWORDS
