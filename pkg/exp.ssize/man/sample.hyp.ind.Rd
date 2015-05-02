\name{sample.hyp.ind}
\alias{sample.null.ind}
\alias{sample.alt.ind}

%- Also NEED an '\alias' for EACH other topic documented here.
\title{ Function to Sample Observations(gene expressions) from Independent
       Normal Distribution with Simulated sd}
\description{
       Function to Sample Observations(gene expressions) from Independent
       Normal Distribution with Simulated sd
}
\usage{

sample.null.ind(ngenes.null.ind, n, sd.vector, var.ratio)
sample.alt.ind(ngenes.alt.ind, n, sd.vector, var.ratio, delta)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{ngenes.null.ind}{an integer number for the number of observations
    (gene expression values) to simulate for genes coming from true
    null hypothesis}
  \item{n}{number of replicates for each group of control/treatment}
  \item{sd.vector}{vector of sd to sample from for controls}
  \item{var.ratio}{ratio of variance between treatment/control}
  \item{ngenes.alt.ind}{an integer number for the number of observations
          (gene expression values) to simulate for genes coming from true
           alternative hypothesis}
  \item{delta}{effect size, absolute difference of the means between genes
          from true alternative and true null nypothesis groups}
}
% \details{
%   ~~ If necessary, more details than the __description__  above ~~
% }
\value{
  returns a matrix with ngenes.null.ind(or ngenes.alt.ind) rows and 2*n 
  columns with the first n columns being samples from control group and
  last n columns being from treatment group for each gene (row)
}
% \references{~put references to the literature/web site here ~ }

\author{Peng Liu \email{peng\_liu@groton.pfizer.com}}
% \note{~~further notes~~ }

% ~Make other sections like Warning with \section{Warning }{....} ~

% \seealso{~~objects to See Also as \code{\link{~~fun~~}}, ~~~ }

\examples{
n.null.ind <- 50; n <- 500; var.ratio <- 1;

test.null.ind <- sample.null.ind(n.null.ind , n, var.ratio)

\dontrun{
% begin of dontrun
ndim <- dim(test.null.ind);
ssd.ctrl<-rep(0, ndim[1])
var.r <- rep(0, ndim[1])
k <- ceiling(n.null.ind * runif(1,0,1))

for ( i in c(1:ndim[1]))
  {ssd.ctrl[i]  <- sd(test.null.ind[i,1:n])
    var.r[i] <- var(test.null.ind[i,(n+1):(2*n)]) / var(test.null.ind[i,1:n])}

cat("comparison between the desired sample and the generated sample: \n")

cat(" ------------------------------------------ \n",
    "number of genes (rows) :\t", n.null.ind, "\t", ndim[1], "\n",
    "number of obs for each group: \t", n, "\t", ndim[2]/2, "\n",
    "variance ratio (trt/ctrl) is: \t", var.ratio, "\t", mean(var.r), "\n",
    "variances for ctrl are generated randomly from inverse gamma distrn. \n",
    "please check histogram of sd.\n",
    "------------------------------------------ \n")

### Histogram of the standard deviations generated

hist(ssd.ctrl,n=20, col="cyan", border="blue", main="",
     xlab="Standard Deviation (for simulated data)")
dens <- density(ssd.ctrl)
lines(dens$x, dens$y*par("usr")[4]/max(dens$y),col="red",lwd=2)

title("Histogram of Standard Deviations for generated sample")
} % end of dontrun

}
\keyword{datagen }% at least one, from doc/KEYWORDS
